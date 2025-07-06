// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/core/app_routes/routes.dart';
// import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
// import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
// import 'package:healthcare_hub/data/repositories/user_repository.dart';
// import '../../../../../core/widgets/custom_toast_show.dart';

// class DrPersonalInfoController extends GetxController {
//   ToastClass toast = ToastClass();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   FireStoreRepository fireStore = FireStoreRepository();
//   StorageRepository storage = StorageRepository();
//   UserRepository auth = UserRepository();
//   final TextEditingController licenseController = TextEditingController();
//   final TextEditingController experienceController = TextEditingController();
//   final TextEditingController aboutController = TextEditingController();
//   // final TextEditingController phoneNumberController = TextEditingController();
//    var degreesNameTextController = TextEditingController();
//   var hospitalNameController = TextEditingController();
//   // var addressController = TextEditingController();
//   var departmentController = TextEditingController();
//   var specializationController = TextEditingController();
//   var degreesNameList = <String>[].obs;
//   var documentList = <PlatformFile>[].obs;
//   var pickedPDF = Rxn<File>();
//   RxString selectedGender = 'Male'.obs;

//   // Future<void> pickPDF() async {
//   //   FilePickerResult? result = await FilePicker.platform.pickFiles(
//   //     type: FileType.custom,
//   //     allowedExtensions: ['pdf'],
//   //   );
//   //   if (result != null && result.files.single.path != null) {
//   //     pickedPDF.value = File(result.files.single.path!);
//   //   }
//   // }

//   RxBool isLoading = false.obs;
// String? validateLicense(String? value) {
//   if (value == null || value.isEmpty) {
//     return "Please enter your License number";
//   }
//   if (!RegExp(r'^[a-zA-Z0-9]{1,15}$')
// .hasMatch(value)) {
//     return "License number should be upto 15 letters/digits only";
//   }
//   return null;
// }
// void addDegreeName() {
//     String name = degreesNameTextController.text.trim();
//     if (name.isNotEmpty) {
//       degreesNameList.add(name);
//       degreesNameTextController.clear();
//     }
//   }
//   void removeDegreeName(String name) {
//     degreesNameList.remove(name);
//   }
// Future<void> doctorRegistration(
  
//   ) async {
//     try {
//       isLoading.value = true;
//       // await storage.uploadReports(documentList.value);

//       /// Store doctor data in Firestore
//       await fireStore
//           .updateDataByUserID(
//             collectionName: "healthCare_hub_Doctor",
//             updates: {
//               'specialization': specializationController.text.trim(),
//               'department': departmentController.text.trim(),
//               // 'address': addressController.text.trim(),
//               'hospitalName': hospitalNameController.text.trim(),
//               // 'phoneNumber': phoneNumber,
//               'experience': experienceController.text,
//               'about': aboutController.text,
//               'gender': selectedGender,
//               'degreesName': degreesNameList.value,
//               // 'degreesUrl': storage.reportUrls!.value,
//             },
//           )
//           .then((value) {
//             documentList.value = [];
//             degreesNameList.value = [];
//             return Get.offNamed(AppRoutes.DRHOMESCREEN);
//           });
//     } catch (e) {
//       rethrow;
//     } finally {
//       isLoading.value = false;
//     }}
//   void refreshField() {
//     licenseController.clear();
//     // phoneNumberController.clear();
//     experienceController.clear();
//     aboutController.clear();
//     selectedGender.value = "Male";
//     formKey = GlobalKey<FormState>();
//     hospitalNameController.clear();
//     departmentController.clear();
//     specializationController.clear();
//     degreesNameList.clear();

//   }

//   @override
//   void dispose() {
//     super.dispose();
//     refreshField();
//   }
// }

// 📁 DrPersonalInfoController.dart //working
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/core/app_routes/routes.dart';
// import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
// import '../../../../../core/widgets/custom_toast_show.dart';

// class DrPersonalInfoController extends GetxController {
//   ToastClass toast = ToastClass();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final FireStoreRepository fireStore = FireStoreRepository();

//   final licenseController = TextEditingController();
//   final experienceController = TextEditingController();
//   final aboutController = TextEditingController();
//   final degreesNameTextController = TextEditingController();

//   RxString selectedGender = 'Male'.obs;
//   RxBool isLoading = false.obs;

//   // Dropdown values
//   final List<String> dummyHospitals = ['Hospital A', 'Hospital B', 'Hospital C'];
//   final List<String> dummyDepartments = ['Dept 1', 'Dept 2', 'Dept 3'];
//   final List<String> dummySpecializations = ['Cardiology', 'Dermatology', 'Neurology'];
//   final List<String> dummyDegrees = ['MBBS', 'MD', 'MS', 'BDS', 'DM'];

//   RxString selectedHospital = ''.obs;
//   RxString selectedDepartment = ''.obs;
//   RxString selectedSpecialization = ''.obs;
//   RxString selectedDegree = ''.obs;

//   var degreesNameList = <String>[].obs;

//   String? validateLicense(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Please enter your License number";
//     }
//     if (!RegExp(r'^[a-zA-Z0-9]{1,15}\$').hasMatch(value)) {
//       return "License number should be up to 15 letters/digits only";
//     }
//     return null;
//   }

//   void addDegreeName() {
//     String name = degreesNameTextController.text.trim();
//     if (name.isNotEmpty) {
//       degreesNameList.add(name);
//       degreesNameTextController.clear();
//     }
//   }

//   void removeDegreeName(String name) {
//     degreesNameList.remove(name);
//   }

//   Future<void> doctorRegistration() async {
//     try {
//       isLoading.value = true;
//       await fireStore.updateDataByUserID(
//         collectionName: "healthCare_hub_Doctor",
//         updates: {
//           'license': licenseController.text.trim(),
//           'experience': experienceController.text,
//           'about': aboutController.text.trim(),
//           'gender': selectedGender.value,
//           'hospitalName': selectedHospital.value,
//           'department': selectedDepartment.value,
//           'specialization': selectedSpecialization.value,
//           'degreesName': degreesNameList + [selectedDegree.value],
//         },
//       );
//       refreshField();
//       Get.offNamed(AppRoutes.DRHOMESCREEN);
//     } catch (e) {
//       rethrow;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void refreshField() {
//     licenseController.clear();
//     experienceController.clear();
//     aboutController.clear();
//     selectedGender.value = 'Male';
//     degreesNameTextController.clear();
//     degreesNameList.clear();
//     selectedHospital.value = '';
//     selectedDepartment.value = '';
//     selectedSpecialization.value = '';
//     selectedDegree.value = '';
//     formKey = GlobalKey<FormState>();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     refreshField();
//   }
// }


// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/core/app_routes/routes.dart';
// import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
// import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
// import 'package:healthcare_hub/data/repositories/user_repository.dart';
// import '../../../../../core/widgets/custom_toast_show.dart';

// class DrPersonalInfoController extends GetxController {
//   ToastClass toast = ToastClass();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   FireStoreRepository fireStore = FireStoreRepository();
//   StorageRepository storage = StorageRepository();
//   UserRepository auth = UserRepository();

//   final TextEditingController licenseController = TextEditingController();
//   final TextEditingController experienceController = TextEditingController();
//   final TextEditingController aboutController = TextEditingController();
//   final TextEditingController degreesNameTextController = TextEditingController();
//   final TextEditingController hospitalNameController = TextEditingController();
//   final TextEditingController departmentController = TextEditingController();
//   final TextEditingController specializationController = TextEditingController();

//   var degreesNameList = <String>[].obs;
//   var documentList = <PlatformFile>[].obs;
//   var pickedPDF = Rxn<File>();
//   RxString selectedGender = 'Male'.obs;

//   RxBool isLoading = false.obs;

//   String? validateLicense(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Please enter your License number";
//     }
//     if (!RegExp(r'^[a-zA-Z0-9]{1,15}\$').hasMatch(value)) {
//       return "License number should be up to 15 letters/digits only";
//     }
//     return null;
//   }

//   void addDegreeName() {
//     String name = degreesNameTextController.text.trim();
//     if (name.isNotEmpty && !degreesNameList.contains(name)) {
//       degreesNameList.add(name);
//       degreesNameTextController.clear();
//     }
//   }

//   void removeDegreeName(String name) {
//     degreesNameList.remove(name);
//   }

//   Future<void> doctorRegistration() async {
//     try {
//       isLoading.value = true;

//       await fireStore.updateDataByUserID(
//         collectionName: "healthCare_hub_Doctor",
//         updates: {
//           'specialization': specializationController.text.trim(),
//           'department': departmentController.text.trim(),
//           'hospitalName': hospitalNameController.text.trim(),
//           'experience': experienceController.text.trim(),
//           'about': aboutController.text.trim(),
//           'gender': selectedGender.value,
//           'degreesName': degreesNameList.value,
//         },
//       ).then((value) {
//         documentList.clear();
//         degreesNameList.clear();
//         Get.offNamed(AppRoutes.DRHOMESCREEN);
//       });
//     } catch (e) {
//       rethrow;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void refreshField() {
//     licenseController.clear();
//     experienceController.clear();
//     aboutController.clear();
//     selectedGender.value = "Male";
//     formKey = GlobalKey<FormState>();
//     hospitalNameController.clear();
//     departmentController.clear();
//     specializationController.clear();
//     degreesNameList.clear();
//     degreesNameTextController.clear();
//   }

//   @override
//   void dispose() {
//     refreshField();
//     super.dispose();
//   }
// }


// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/core/app_routes/routes.dart';
// import 'package:healthcare_hub/data/repositories/firebase_storage.dart';
// import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
// import 'package:healthcare_hub/data/repositories/user_repository.dart';
// import '../../../../../core/widgets/custom_toast_show.dart';

// class DrPersonalInfoController extends GetxController {
//   ToastClass toast = ToastClass();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   FireStoreRepository fireStore = FireStoreRepository();
//   StorageRepository storage = StorageRepository();
//   UserRepository auth = UserRepository();

//   final TextEditingController licenseController = TextEditingController();
//   final TextEditingController experienceController = TextEditingController();
//   final TextEditingController aboutController = TextEditingController();
//   final TextEditingController degreesNameTextController = TextEditingController();
//   final TextEditingController hospitalNameController = TextEditingController();
//   final TextEditingController departmentController = TextEditingController();
//   final TextEditingController specializationController = TextEditingController();

//   var degreesNameList = <String>[].obs;
//   var documentList = <PlatformFile>[].obs;
//   var pickedPDF = Rxn<File>();
//   RxString selectedGender = 'Male'.obs;

//   RxBool isLoading = false.obs;

//   List<String> experienceOptions = List.generate(51, (index) => index.toString());
//   List<String> hospitalOptions = ['Hospital A', 'Hospital B', 'Hospital C'];
//   List<String> departmentOptions = ['Cardiology', 'Neurology', 'Orthopedics'];
//   List<String> specializationOptions = ['Surgeon', 'Therapist', 'Pediatrician'];
//   List<String> degreeOptions = ['MBBS', 'MD', 'DO', 'PhD', 'BDS'];

//   String? validateLicense(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Please enter your License number";
//     }
//     if (!RegExp(r'^[a-zA-Z0-9]{1,15}\$').hasMatch(value)) {
//       return "License number should be up to 15 letters/digits only";
//     }
//     return null;
//   }

//   void addDegreeName() {
//     String name = degreesNameTextController.text.trim();
//     if (name.isNotEmpty && !degreesNameList.contains(name)) {
//       degreesNameList.add(name);
//       degreesNameTextController.clear();
//     }
//   }

//   void removeDegreeName(String name) {
//     degreesNameList.remove(name);
//   }

//   Future<void> doctorRegistration() async {
//     try {
//       isLoading.value = true;

//       await fireStore.updateDataByUserID(
//         collectionName: "healthCare_hub_Doctor",
//         updates: {
//           'specialization': specializationController.text.trim(),
//           'department': departmentController.text.trim(),
//           'hospitalName': hospitalNameController.text.trim(),
//           'experience': experienceController.text.trim(),
//           'about': aboutController.text.trim(),
//           'gender': selectedGender.value,
//           'degreesName': degreesNameList.value,
//         },
//       ).then((value) {
//         documentList.clear();
//         degreesNameList.clear();
//         Get.offNamed(AppRoutes.DRHOMESCREEN);
//       });
//     } catch (e) {
//       rethrow;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void refreshField() {
//     licenseController.clear();
//     experienceController.clear();
//     aboutController.clear();
//     selectedGender.value = "Male";
//     formKey = GlobalKey<FormState>();
//     hospitalNameController.clear();
//     departmentController.clear();
//     specializationController.clear();
//     degreesNameList.clear();
//     degreesNameTextController.clear();
//   }

//   @override
//   void dispose() {
//     refreshField();
//     super.dispose();
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';
import '../../../../../core/widgets/custom_toast_show.dart';

class DrPersonalInfoController extends GetxController {
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FireStoreRepository fireStore = FireStoreRepository();

  final licenseController = TextEditingController();
  final experienceController = TextEditingController();
  final aboutController = TextEditingController();
  final degreesNameTextController = TextEditingController();

  RxString selectedGender = 'Male'.obs;
  RxBool isLoading = false.obs;
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

  Future<void> doctorRegistration(BuildContext context) async {
    try {
      print(licenseController.text);
      print(degreesNameList);
      print(selectedCategory);
      print(selectedDepartment);
      print(selectedDepartment);
      isLoading.value = true;
      await fireStore.updateDataByUserID(
        collectionName: "healthCare_hub_Doctor",
        updates: {
          'license': licenseController.text.trim(),
          'experience': experienceController.text,
          'about': aboutController.text.trim(),
          'gender': selectedGender.value,
          'hospitalName': selectedHospital.value,
          'department': selectedDepartment.value,
          'specialization': selectedSpecialization.value,
          'degreesName': degreesNameList,
        },
      );
      toast.showCustomToast( "Registration successful!");
      refreshField();
      Get.offNamed(AppRoutes.DRHOMESCREEN);
    } catch (e) {
      toast.showCustomToast("Registration failed: $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void refreshField() {
    licenseController.clear();
    experienceController.clear();
    aboutController.clear();
    selectedGender.value = 'Male';
    degreesNameTextController.clear();
    degreesNameList.clear();
    selectedHospital.value = '';
    selectedDepartment.value = '';
    selectedSpecialization.value = '';
    selectedDegree.value = '';
  }

  @override
  void dispose() {
    refreshField();
    super.dispose();
  }
}
