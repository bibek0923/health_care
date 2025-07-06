import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';

import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/patient_model.dart';
import '../../../../data/repositories/firestore_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/shared_preference/shared_preference_services.dart';
class DrHomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  UserRepository auth = UserRepository();
  FireStoreRepository fireStore = FireStoreRepository();

  Stream<DoctorModel?> getUserStream() {
    return fireStore.getDataByUserID(
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

  @override
  void onInit() async{
    await getUserId();
    super.onInit();
  }
  late String userId = '';
  Future<void> getUserId()async{
    userId =  (await PreferenceHelper.getString("userID"))!;
  }

  Stream<List<AppointmentModel>> getAppointmentsStream() {
    return fireStore.getAllData(
      collectionName: "appointments",
      fromJson: AppointmentModel.fromJson,
    );
  }
  Stream<PatientModel?> getPatient(String doctorId) {
    return fireStore.getDataById(
      collectionName: "healthCare_hub",
      documentId: doctorId,
      fromJson: PatientModel.fromMap,
    );
  }


}
