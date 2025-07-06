import 'package:get/get.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';

import '../../../../data/models/appointment_model.dart';

class DoctorDetailsController extends GetxController{
FireStoreRepository fireStore = FireStoreRepository();

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