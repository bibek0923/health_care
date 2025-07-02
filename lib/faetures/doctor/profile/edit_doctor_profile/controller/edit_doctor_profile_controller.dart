import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/helpers/image_picker.dart';
import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
import '../../../../../data/models/doctor_model.dart';

class DoctorEditProfileController extends GetxController {
  FireStoreRepository fireStore = FireStoreRepository();
  StorageRepository storage = StorageRepository();
  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController licenseNumberController;
  late TextEditingController phoneNumberController;
  late TextEditingController experienceController;
  late TextEditingController specializationController;
  late TextEditingController addressController;
  TextEditingController degreeTextController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  RxString imageUrl = ''.obs;
  RxString gender = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  ImagePickerHelper imagePicker = ImagePickerHelper();

  // Degree info
  RxList<String> degreesName = <String>[].obs;
  RxList<String> degreesUrl = <String>[].obs;
  late DoctorModel doctor;

  Future<void> pickAndAddCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final file = File(filePath);

      if (file.existsSync()) {
        try {
          final fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".pdf";
          final ref = FirebaseStorage.instance.ref().child("doctor_certificates/$fileName");

          final uploadTask = await ref.putFile(file);
          final downloadUrl = await uploadTask.ref.getDownloadURL();

          degreesUrl.add(downloadUrl);
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar("Invalid File", "Selected file doesn't exist.");
      }
    } else {
      Get.snackbar("Cancelled", "No file selected");
    }
  }


  void removeCertificate(int index) {
    degreesUrl.removeAt(index);
  }

  void initializeWithDoctor(DoctorModel doctor) {
    degreesUrl.assignAll(doctor.degreesUrl ?? []);
  }

  @override
  void onInit() {
    doctor = Get.arguments as DoctorModel;
    imageUrl.value = doctor.imageUrl!;
    gender.value = doctor.gender!;
    firstNameController = TextEditingController(text: doctor.firstName);
    hospitalNameController = TextEditingController(text: doctor.hospitalName);
    departmentController = TextEditingController(text: doctor.department);
    aboutController = TextEditingController(text: doctor.about);
    middleNameController = TextEditingController(text: doctor.middleName ?? '');
    lastNameController = TextEditingController(text: doctor.lastName);
    emailController = TextEditingController(text: doctor.email);
    licenseNumberController = TextEditingController(
      text: doctor.liceneceNumber ?? '',
    );
    phoneNumberController = TextEditingController(
      text: doctor.phoneNumber ?? '',
    );
    experienceController = TextEditingController(text: doctor.experience ?? '');
    specializationController = TextEditingController(
      text: doctor.specialization ?? '',
    );
    addressController = TextEditingController(text: doctor.address ?? '');
    degreesName.addAll(doctor.degreesName ?? []);
    degreesUrl.addAll(doctor.degreesUrl ?? []);

    super.onInit();
  }

  void addDegree() {
    String degree = degreeTextController.text.trim();
    if (degree.isNotEmpty) {
      degreesName.add(degree);
      degreeTextController.clear();
    }
  }

  void removeDegree(int index) {
    degreesName.removeAt(index);
  }

  RxBool isLoading = false.obs;

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      final localDegreePaths =
          degreesUrl.value
              .where(
                (path) =>
                    !(path.startsWith('http') || path.startsWith('https')),
              )
              .toList();
      if (localDegreePaths.isNotEmpty) {
        await storage.uploadReports(localDegreePaths);
      }
      String? uploadedImageUrl;
      if (imagePicker.selectedImage.value != null) {
        await storage.uploadImage(imagePicker.selectedImage.value!);
        uploadedImageUrl = storage.imageUrl.value;
      }else{
        uploadedImageUrl = imageUrl.value;
      }
      final uploadedDegreeUrls = [
        ...degreesUrl.value.where(
          (e) => e.startsWith('http') || e.startsWith('https'),
        ),
        ...storage.reportUrls?.value ?? [],
      ];
      print("Uploaded Certificates: $uploadedDegreeUrls");
      await fireStore.updateDataByUserID(
        collectionName: "healthCare_hub_Doctor",
        updates: {
          'firstName': firstNameController.text.trim(),
          'middleName': middleNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'specialization': specializationController.text.trim(),
          'department': departmentController.text.trim(),
          'address': addressController.text.trim(),
          'hospitalName': hospitalNameController.text.trim(),
          'idCard': licenseNumberController.text.trim(),
          'phoneNumber': phoneNumberController.text.trim(),
          'experience': experienceController.text.trim(),
          'about': aboutController.text.trim(),
          'gender': gender.value,
          'imageUrl': uploadedImageUrl ?? '',
          'degreesName': degreesName.value,
          'degreesUrl': uploadedDegreeUrls,
        },
      );

      // 5. Reset data and go back
      degreesUrl.value = [];
      degreesName.value = [];
      Get.back();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
