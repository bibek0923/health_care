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
  final degreesNameTextController = TextEditingController();
  RxString imageUrl = ''.obs;
  RxString gender = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  ImagePickerHelper imagePicker = ImagePickerHelper();
  final List<String> dummyHospitals = [
    'Hospital A',
    'Hospital B',
    'Hospital C',
  ];
  RxString selectedSpecialization = ''.obs;
  final List<String> dummySpecializations = [
    'Cardiology',
    'Dermatology',
    'Neurology',
  ];
  RxString selectedDepartment = ''.obs;
  final List<String> dummyDepartments = ['Dept 1', 'Dept 2', 'Dept 3'];
  // Degree info
  final List<String> dummyDegrees = ['MBBS', 'MD', 'MS', 'BDS', 'DM'];
  var degreesNameList = <String>[].obs;
  RxString selectedDegree = ''.obs;
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

  RxList<String> degreesName = <String>[].obs;
  RxList<String> degreesUrl = <String>[].obs;
  late DoctorModel doctor;
  RxString selectedHospital = ''.obs;
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
          final fileName =
              DateTime.now().millisecondsSinceEpoch.toString() + ".pdf";
          final ref = FirebaseStorage.instance.ref().child(
            "doctor_certificates/$fileName",
          );

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

  String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please select a $fieldName";
    }
    return null;
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
    gender.value = doctor.gender ?? "Male";
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
if(doctor.degreesName!=null && doctor.degreesName!.isNotEmpty){
  degreesNameList.value=doctor.degreesName!;
}

if (doctor.hospitalName != null && doctor.hospitalName!.isNotEmpty) {
    if (!dummyHospitals.contains(doctor.hospitalName)) {
      dummyHospitals.add(doctor.hospitalName!);
    }
  }
  
  if (doctor.specialization != null && doctor.specialization!.isNotEmpty) {
    if (!dummySpecializations.contains(doctor.specialization)) {
      dummySpecializations.add(doctor.specialization!);
    }
  }
  
  if (doctor.department != null && doctor.department!.isNotEmpty) {
    if (!dummyDepartments.contains(doctor.department)) {
      dummyDepartments.add(doctor.department!);
    }
  }
  
  // Now set the selected values
  selectedHospital.value = doctor.hospitalName ?? '';
  selectedSpecialization.value = doctor.specialization ?? '';
  selectedDepartment.value = doctor.department ?? '';


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
      } else {
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
          'specialization': selectedSpecialization.value,
          'department': selectedDepartment.value,
          'address': addressController.text.trim(),
          'hospitalName': selectedHospital.value,
          'licenseNumber': licenseNumberController.text.trim(),
          'phoneNumber': phoneNumberController.text.trim(),
          'experience': experienceController.text.trim(),
          'about': aboutController.text.trim(),
          'gender': gender.value,
          'imageUrl': uploadedImageUrl ?? '',
          'degreesName': degreesNameList,
          'degreesUrl': uploadedDegreeUrls,
        },
      );

      // 5. Reset data and go back
      degreesUrl.value = [];
      degreesNameList.value = [];
      Get.back();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
