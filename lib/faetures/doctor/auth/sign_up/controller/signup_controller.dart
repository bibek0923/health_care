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
      imagePicker.selectedImage.value != null? await storage.uploadImage(imagePicker.selectedImage.value!):null;
      final String uploadedImageUrl = storage.imageUrl.value;
      final doctor = DoctorModel(
        doctorId: doctorId,
        firstName: firstNameController.text.trim(),
        middleName: middleNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        imageUrl: imagePicker.selectedImage.value != null ?uploadedImageUrl:'',
      );
      await fireStore
          .storeDataWithUserID<DoctorModel>(
            collectionName: "healthCare_hub_Doctor",
            data: doctor,
            toJson: (model) => model.toMap(),
          )
          .then((value) {
            refreshField();
            return Get.offNamed(AppRoutes.DRPERSONALINFOSCREEN);
          });
      toast.showCustomToast("Doctor registered successfully!");
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
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
