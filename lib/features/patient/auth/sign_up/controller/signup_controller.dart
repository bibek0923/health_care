import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
import 'package:healthcare_hub/data/repositories/user_repository.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/helpers/image_picker.dart';
import '../../../../../core/widgets/custom_toast_show.dart';

class SignUpController extends GetxController {
  FireStoreRepository fireStore = FireStoreRepository();
  StorageRepository storage = StorageRepository();
  UserRepository auth = UserRepository();
  ImagePickerHelper imagePicker = ImagePickerHelper();
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController insuranceCardController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  File? imagePath = ImagePickerHelper().selectedImage.value;
  RxBool isLoading = false.obs;
  RxString selectedGender = 'Male'.obs;
  RxBool isAbove18 = false.obs;
RxBool isInitialized1 =false.obs;
  // String? errorText  ;
  RxBool showHeightError = false.obs;
  RxBool showWeightError = false.obs;

  String heightErrorMessage = 'Please enter valid height';
  String weightErrorMessage = 'Please enter valid weight';

  List<String> heightUnitsList = <String>["Feet", "Inch"];
  List<String> weightUnitsList = <String>["Kgs", "Pound"];
  RxString selectedHeightUnit = "Feet".obs;
  RxString selectedWeightUnit = "Kgs".obs;

  void setBirthDate(DateTime birthDate) {
    dobController.text = _formatDate(birthDate);
    isAbove18.value = _calculateAge(birthDate) >= 18;
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // String? heightValidator(String?  value){
  //   if(value ==null || value.trim().isEmpty  ){
  //     // return "Please enter heightttt";
  //     errorText='Please Enter Heighttttt';
  //     // return '';
  //   }
  //   return null;

  // }

  // height validator
  String? heightValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      showHeightError.value = true;
      return ''; // Return empty string to hide default error
    }
    // else if(value.length>3){
    //   heightErrorMessage='Enter Valid Value';
    //   return '';
    // }
    else {
      showHeightError.value = false;
      return null;
    }
  }

  String? weightValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      showWeightError.value = true;
      return ''; // Return empty string to hide default error
    }
    // else if(value.length>3){
    //   heightErrorMessage='Enter Valid Value';
    //   return '';
    // }
    else {
      showWeightError.value = false;
      return null;
    }
  }

  void clearHeightError() {
    showWeightError.value = false;
  }
String? validateAbout(String? value){
    if(value==null || value.trim().isEmpty){
      return null;
    }
    if (value.length>150){
      return "Enter upto 150 letters";
    }
    return null;
  }
  // String? validateInsuranceCard(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return null;
  //   }
  //   if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
  //     return "Insurance card must contain digits only";
  //   }
  //   return null;
  // }
  
String? validateInsuranceCard(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!RegExp(r'^[a-zA-Z0-9]{1,15}$').hasMatch(value)) {
      return "License number should be up to 15 letters/digits only";
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9\s]).+$');
    if (!regex.hasMatch(value)) {
      return "Password too weak";
    }

    return null;
  }

  String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }

    if (value != originalPassword) {
      return "Passwords do not match";
    }

    return null;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Enter first name";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Enter letters only";
    }
    if (value.length > 50) {
      return "Name too long";
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Enter last name";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Enter letters only";
    }
    if (value.length > 50) {
      return "Name too long";
    }
    return null;
  }

  String? validateMiddleName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Enter letters only";
    }
    if (value.length > 50) {
      return "Name too long";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your email";
    }

    // Email regex pattern
    const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    if (!RegExp(emailRegex).hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }

    return null;
  }

  Future<void> patientRegistration() async {
    try {
      isLoading.value = true;

      await auth.signUp(
        emailController.text.trim(),
        createPasswordController.text.trim(),
      );
      final String? patientId = FirebaseAuth.instance.currentUser?.uid;
      imagePicker.selectedImage.value != null
          ? await storage.uploadImage(imagePicker.selectedImage.value!)
          : null;
      final String uploadedImageUrl = storage.imageUrl.value;
      // print(dobController.text.trim(),);
      // print(weightController.text.trim(),);
      // print( selectedGender.value,);
      // print(selectedHeightUnit.value);
      // print(idCardController.text);
      PatientModel patient = PatientModel(
        id: patientId,
        firstName: firstNameController.text.trim(),
        middleName: middleNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        imageUrl: uploadedImageUrl,
        age: dobController.text.trim(),
        insuranceCard: insuranceCardController.text.trim(),
        height: heightController.text.trim(),
        weight: weightController.text.trim(),
        about: aboutController.text,
        gender: selectedGender.value,
        idCardNumber: idCardController.text,
        heightUnit: selectedHeightUnit.value,
        weightUnit: selectedWeightUnit.value,

      );

      await fireStore
          .storeDataWithUserID(
            collectionName: "healthCare_hub",
            data: patient,
            toJson: (model) => model.toJson(),
          )
          .then((value) {
            refreshField();
            return Get.offAllNamed(AppRoutes.HOMESCREEN);
          });
      toast.showCustomToast("Patient registered successfully!");
      refreshField();
    } catch (e) {
      toast.showCustomToast("Registration failed: $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void refreshField() {
    imagePicker.selectedImage.value = null;
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    emailController.clear();
    createPasswordController.clear();
    confirmPasswordController.clear();
    formKey = GlobalKey<FormState>();
    imagePath = null;
    dobController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
