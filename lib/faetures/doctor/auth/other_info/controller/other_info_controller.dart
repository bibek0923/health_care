import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/widgets/custom_toast_show.dart';
import '../../../../../data/repositories/firebase_storage.dart';
import '../../../../../data/repositories/firestore_repository.dart';
import '../../../../../data/repositories/user_repository.dart';

class DrOtherInfoController extends GetxController {
  ToastClass toast = ToastClass();
  FireStoreRepository fireStore = FireStoreRepository();
  StorageRepository storage = StorageRepository();
  UserRepository auth = UserRepository();
  var degreesNameTextController = TextEditingController();
  var hospitalNameController = TextEditingController();
  var addressController = TextEditingController();
  var departmentController = TextEditingController();
  var specializationController = TextEditingController();
  var degreesNameList = <String>[].obs;
  var documentList = <PlatformFile>[].obs;

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

  void addDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      documentList.add(result.files.first);
    }
  }

  void removeDocument(PlatformFile file) {
    documentList.remove(file);
  }

  RxBool isLoading = false.obs;

  Future<void> doctorRegistration({
    required String phoneNumber,
    required String experience,
    required String about,
    required String gender,
    required String license,
  }) async {
    try {
      isLoading.value = true;
      await storage.uploadReports(documentList.value);
      /// Store doctor data in Firestore
      await fireStore
          .updateDataByUserID(collectionName: "healthCare_hub_Doctor", updates: {
        'specialization': specializationController.text.trim(),
        'department': departmentController.text.trim(),
        'address': addressController.text.trim(),
        'hospitalName': hospitalNameController.text.trim(),
        'phoneNumber': phoneNumber,
        'experience': experience,
        'about': about,
        'gender': gender,
        'degreesName': degreesNameList.value,
        'degreesUrl': storage.reportUrls!.value,
      })
          .then((value) {
        documentList.value = [];
        degreesNameList.value = [];
        return Get.offNamed(AppRoutes.DRHOMESCREEN);
      });
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

}
