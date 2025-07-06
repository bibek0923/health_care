import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
import 'package:healthcare_hub/data/repositories/user_repository.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/helpers/image_picker.dart';
import '../../../../../core/widgets/custom_toast_show.dart';
import '../../../../../data/models/doctor_model.dart';

class DrSignUpController extends GetxController {
  ImagePickerHelper imagePicker = ImagePickerHelper();
  UserRepository auth = UserRepository();
  FireStoreRepository fireStore = FireStoreRepository();
  StorageRepository storage = StorageRepository();
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  File? imagePath = ImagePickerHelper().selectedImage.value;
  RxBool isLoading = false.obs;

 
//  final FireStoreRepository fireStore = FireStoreRepository();

  final licenseController = TextEditingController();
  final experienceController = TextEditingController();
  final aboutController = TextEditingController();
  final degreesNameTextController = TextEditingController();
  RxBool isInitialized = false.obs;


  RxString selectedGender = 'Male'.obs;
  // RxBool isLoading = false.obs;
 final RxString selectedCategory = ''.obs;

  final List<String> categories = [
    'Cardiology',
    'Neurology',
    'Pediatrics',
    'Orthopedics',
    'Dermatology',
  ];
  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a category";
    }
    return null;
  }
  // Dropdown values
  final List<String> dummyHospitals = ['Hospital A', 'Hospital B', 'Hospital C'];
  final List<String> dummyDepartments = ['Dept 1', 'Dept 2', 'Dept 3'];
  final List<String> dummySpecializations = ['Cardiology', 'Dermatology', 'Neurology'];
  final List<String> dummyDegrees = ['MBBS', 'MD', 'MS', 'BDS', 'DM'];

  RxString selectedHospital = ''.obs;
  RxString selectedDepartment = ''.obs;
  RxString selectedSpecialization = ''.obs;
  RxString selectedDegree = ''.obs;


  var degreesNameList = <String>[].obs;

  String? validateLicense(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your License number";
    }
    if (!RegExp(r'^[a-zA-Z0-9]{1,15}$').hasMatch(value)) {
      return "License number should be up to 15 letters/digits only";
    }
    return null;
  }

  String? validateExperience(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your experience";
    }
    if (!RegExp(r'^\d+(\.\d)?$').hasMatch(value)) {
      return "Enter valid experience (e.g., 3 or 3.5)";
    }
    final double? experience = double.tryParse(value);
    if (experience == null || experience < 0 || experience > 50) {
      return "Experience must be between 0 and 50 years";
    }
    return null;
  }

  String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please select a $fieldName";
    }
    return null;
  }

  void addDegreeName() {
    String name = degreesNameTextController.text.trim();
    if (name.isNotEmpty) {
      degreesNameList.add(name);
      degreesNameTextController.clear();
    }
  }

  void removeDegreeName(String name) {
    degreesNameList.remove(name);
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
  String? validateAbout(String? value){
    if(value==null || value.trim().isEmpty){
      return null;
    }
    if (value.length>150){
      return "Enter upto 150 letters";
    }
    return null;
  }
   Future<void> doctorRegistration() async {
    try {
      isLoading.value = true;
      await auth.signUp(
        emailController.text.trim(),
        createPasswordController.text.trim(),
      );

      final String? doctorId = FirebaseAuth.instance.currentUser?.uid;

      if (doctorId == null) {
        throw Exception("Unable to retrieve doctor ID.");
      }
      imagePicker.selectedImage.value != null
          ? await storage.uploadImage(imagePicker.selectedImage.value!)
          : null;
      final String uploadedImageUrl = storage.imageUrl.value;
      final doctor = DoctorModel(
        doctorId: doctorId,
        firstName: firstNameController.text.trim(),
        middleName: middleNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        imageUrl:
            imagePicker.selectedImage.value != null ? uploadedImageUrl : '',
        liceneceNumber: licenseController.text.trim(),
        experience: experienceController.text,
        about: aboutController.text,
        gender: selectedGender.value,
        hospitalName: selectedHospital.value,
        department: selectedDepartment.value,
        specialization: selectedSpecialization.value,
        degreesName: degreesNameList,

        
      );
      await fireStore
          .storeDataWithUserID<DoctorModel>(
            collectionName: "healthCare_hub_Doctor",
            data: doctor,
            toJson: (model) => model.toMap(),
          )
          .then((value) {
            refreshField();
              toast.showCustomToast("Doctor registered successfully!");
            return Get.offAllNamed(AppRoutes.DRHOMESCREEN);
          });
    
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
    lastNameController.clear();
    emailController.clear();
    middleNameController.clear();
    createPasswordController.clear();
    confirmPasswordController.clear();
    formKey = GlobalKey<FormState>();
    aboutController.clear();
    degreesNameTextController.clear();
    licenseController.clear();
    experienceController.clear();
   
  imagePicker.selectedImage.value = null;


  // Reset dropdowns
  selectedHospital.value = '';
  selectedDepartment.value = '';
  selectedSpecialization.value = '';
  selectedDegree.value = '';
  selectedCategory.value = '';

  // Reset gender
  selectedGender.value = 'Male';

  // Clear degrees list
  degreesNameList.clear();

  // Reset loading and form
  isLoading.value = false;
  formKey = GlobalKey<FormState>();
   
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }

  @override
void onInit() {
  super.onInit();
  refreshField(); // clears all form values
}
}

