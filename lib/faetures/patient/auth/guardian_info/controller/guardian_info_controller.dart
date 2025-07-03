import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
import 'package:healthcare_hub/data/repositories/user_repository.dart';
import '../../../../../core/widgets/custom_toast_show.dart';

class GuardianInfoController extends GetxController {
  ToastClass toast = ToastClass();
  FireStoreRepository fireStore = FireStoreRepository();
  StorageRepository storage = StorageRepository();
  UserRepository auth = UserRepository();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController guardianNameController = TextEditingController();
  final TextEditingController guardianIdCardController =
      TextEditingController();
  final TextEditingController guardianPhoneController = TextEditingController();
  final TextEditingController relationShipController = TextEditingController();
  RxString selectedGender = 'Male'.obs;
  RxBool isLoading = false.obs;

  Future<void> patientDataSave({
    required String idCardNumber,
    required String insuranceCardNumber,
    required String phoneNumber,
    required String age,
    // required String bloodGroup,
    required String about,
    required String gender,
    required String height,
    required String weight,
    // required File report,
  }) async {
    try {
      isLoading.value = true;
      // await storage.uploadReports([report]);
      final String uploadedReportUrl = storage.reportUrls!.first;
      log("Uploaded Pdf Url: $uploadedReportUrl");
      await fireStore
          .updateDataByUserID(
            collectionName: "healthCare_hub",
            updates: {
              'guardianRelationShip': relationShipController.text.trim(),
              'insuranceCard': insuranceCardNumber,
              'guardianGender': selectedGender.value,
              'idCardNumber': idCardNumber,
              'phoneNumber': phoneNumber,
              'height': height,
              'weight': weight,
              'age': age,
              // 'bloodGroup': bloodGroup,
              'about': about,
              'gender': gender,
              // 'reportUrl': uploadedReportUrl,
              'guardianName': guardianNameController.text.trim(),
              'guardianIdCard': guardianIdCardController.text.trim(),
              'guardianPhoneNumber': guardianPhoneController.text.trim(),
            },
          )
          .then((value) {
            return Get.offNamed(AppRoutes.HOMESCREEN);
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
    guardianNameController.clear();
    guardianIdCardController.clear();
    guardianPhoneController.clear();
    relationShipController.clear();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
