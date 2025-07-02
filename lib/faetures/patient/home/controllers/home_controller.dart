import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/data/repositories/user_repository.dart';
import '../../../../data/repositories/firestore_repository.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  UserRepository auth = UserRepository();
  FireStoreRepository fireStore = FireStoreRepository();
  final RxString searchText = ''.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    searchController.addListener(() {
      searchText.value = searchController.text;
    },);
    update();
  }


  Stream<PatientModel?> getUserStream() {
    return fireStore.getDataByUserID(
      collectionName: "healthCare_hub",
      fromJson: PatientModel.fromMap,
    );
  }
  Stream<List<DoctorModel>?> getDoctorsStream() {
    return fireStore.getAllData(
      collectionName: "healthCare_hub_Doctor",
      fromJson: DoctorModel.fromMap,
    );
  }

  String getGreetings() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning...!  ☀️';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Afternoon...!  🌤️';
    } else if (hour >= 16 && hour < 20) {
      return 'Good Evening...!  🌇';
    } else {
      return 'Good Night...!  🌙';
    }
  }
}
