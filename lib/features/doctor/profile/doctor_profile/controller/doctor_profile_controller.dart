import 'package:get/get.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';

import '../../../../../data/models/appointment_model.dart';
import '../../../../../data/models/patient_model.dart';
import '../../../../../data/repositories/firestore_repository.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../../../data/shared_preference/shared_preference_services.dart';

class DoctorProfileController extends GetxController{
  UserRepository auth = UserRepository();
  FireStoreRepository fireStore = FireStoreRepository();
  Stream<DoctorModel?> getUserStream() {
    return fireStore.getDataByUserID(
      collectionName: "healthCare_hub_Doctor",
      fromJson: DoctorModel.fromMap,
    );
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
  String formatIdCardNumber(String id) {
    if (id.length < 6) return id;
    String firstPart = id.substring(0, 4);
    String middlePart = id.substring(4, id.length - 1);
    String lastChar = id.substring(id.length - 1);

    return '$firstPart-$middlePart-$lastChar';
  }

  Stream<PatientModel?> getPatient(String doctorId) {
    return fireStore.getDataById(
      collectionName: "healthCare_hub",
      documentId: doctorId,
      fromJson: PatientModel.fromMap,
    );
  }
}