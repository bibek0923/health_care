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
      PatientModel patient = PatientModel(
        id: patientId,
        firstName: firstNameController.text.trim(),
        middleName: middleNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        imageUrl: uploadedImageUrl,
      );

      await fireStore
          .storeDataWithUserID(
            collectionName: "healthCare_hub",
            data: patient,
            toJson: (model) => model.toJson(),
          )
          .then((value) {
            refreshField();
            return Get.offNamed(AppRoutes.PERSONALINFOSCREEN);
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
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
