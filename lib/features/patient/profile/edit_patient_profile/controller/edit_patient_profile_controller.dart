import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/helpers/image_picker.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
import '../../../../../data/models/doctor_model.dart';

class PatientEditProfileController extends GetxController {
  FireStoreRepository fireStore = FireStoreRepository();
  StorageRepository storage = StorageRepository();
  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController idCardController;
  late TextEditingController insuranceCardController;
  late TextEditingController phoneNumberController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController ageController;
  late TextEditingController aboutController;
  late TextEditingController guardianNameController;
  late TextEditingController guardianRelationController;
  late TextEditingController guardianPhoneController;
  late TextEditingController guardianIDCardController;
  RxString imageUrl = ''.obs;
    RxBool isInitialized1 = false.obs;
  RxString gender = ''.obs;
  final RxString selectedBloodGroup = ''.obs;
  RxString reportUrl = ''.obs;
  RxString guardianGender = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
RxBool showHeightError = false.obs;
  RxBool showWeightError = false.obs;

  String heightErrorMessage = 'Please enter valid height';
  String weightErrorMessage = 'Please enter valid weight';

  List<String> heightUnitsList = <String>["Feet", "Inch"];
  List<String> weightUnitsList = <String>["Kgs", "Pound"];
  RxString selectedHeightUnit = "Feet".obs;
  RxString selectedWeightUnit = "Kgs".obs;
   String? heightValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      showHeightError.value = true;
      return ''; // Return empty string to hide default error
    }
    
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
  
    else {
      showWeightError.value = false;
      return null;
    }
  }
  void clearHeightError() {
    showWeightError.value = false;
  }
  final RxList<String> bloodGroups =
      ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', "Don't know"].obs;
  ImagePickerHelper imagePicker = ImagePickerHelper();

  void setBirthDate(DateTime birthDate) {
    ageController.text = _formatDate(birthDate);
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  void updateBloodGroup(String value) => selectedBloodGroup.value = value;

  late PatientModel patient;

  @override
  void onInit() {
    patient = Get.arguments as PatientModel;
    imageUrl.value = patient.imageUrl!;
    selectedBloodGroup.value = patient.bloodGroup!;
    gender.value = patient.gender!;
    guardianGender.value = patient.guardianGender!;
    ageController = TextEditingController(text: patient.age);
    firstNameController = TextEditingController(text: patient.firstName);
    middleNameController = TextEditingController(
      text: patient.middleName ?? '',
    );
    lastNameController = TextEditingController(text: patient.lastName);
    emailController = TextEditingController(text: patient.email);
    idCardController = TextEditingController(text: patient.idCardNumber);
    insuranceCardController = TextEditingController(
      text: patient.insuranceCard,
    );
    phoneNumberController = TextEditingController(
      text: patient.phoneNumber ?? '',
    );
    heightController = TextEditingController(text: patient.height ?? '');
    weightController = TextEditingController(text: patient.weight ?? '');
    aboutController = TextEditingController(text: patient.about ?? '');
    guardianNameController = TextEditingController(
      text: patient.guardianName ?? '',
    );
    guardianRelationController = TextEditingController(
      text: patient.guardianRelationShip ?? '',
    );
    guardianPhoneController = TextEditingController(
      text: patient.guardianPhoneNumber ?? '',
    );
    guardianIDCardController = TextEditingController(
      text: patient.guardianIdCard ?? '',
    );

    super.onInit();
  }

  Rxn<File> selectedPdfFile = Rxn<File>();

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      selectedPdfFile.value = File(result.files.single.path!);
    }
  }

  RxBool isLoading = false.obs;

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      // Upload PDF if selected
      String finalReportUrl = reportUrl.value; // fallback to old URL
      if (selectedPdfFile.value != null) {
        await storage.uploadReports([selectedPdfFile.value!]);
        if (storage.reportUrls != null && storage.reportUrls!.isNotEmpty) {
          finalReportUrl = storage.reportUrls!.first; // get the first URL string
        }
      }

      // Handle image upload
      String? uploadedImageUrl;
      if (imagePicker.selectedImage.value != null) {
        await storage.uploadImage(imagePicker.selectedImage.value!);
        uploadedImageUrl = storage.imageUrl.value;
      } else {
        uploadedImageUrl = imageUrl.value;
      }

      print("PDF Url: $finalReportUrl");

      // Update Firestore
      await fireStore.updateDataByUserID(
        collectionName: "healthCare_hub",
        updates: {
          'imageUrl': uploadedImageUrl,
          'middleName': middleNameController.text.trim(),
          'firstName': firstNameController.text.trim(),
          'guardianRelationShip': guardianRelationController.text.trim(),
          'insuranceCard': insuranceCardController.text.trim(),
          'guardianGender': guardianGender.value,
          'lastName': lastNameController.text.trim(),
          'idCardNumber': idCardController.text.trim(),
          'phoneNumber': phoneNumberController.text.trim(),
          'height': heightController.text.trim(),
          'weight': weightController.text.trim(),
          'age': ageController.text.trim(),
          'bloodGroup': selectedBloodGroup.value,
          'about': aboutController.text.trim(),
          'gender': gender.value,
          'reportUrl': finalReportUrl,
          'guardianName': guardianNameController.text.trim(),
          'guardianIdCard': guardianIDCardController.text.trim(),
          'guardianPhoneNumber': guardianPhoneController.text.trim(),
          'heightUnit':selectedHeightUnit.value,
          'weightUnit':selectedWeightUnit.value,

        },
      );

      Get.back();
    } catch (e) {
     
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }


}
