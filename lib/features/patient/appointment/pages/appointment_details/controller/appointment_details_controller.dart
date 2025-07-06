// import 'package:get/get.dart';

// class AppointmentDetailsController extends GetxController {
//   final doctorName = "Dr. Sarah Khan".obs;
//   final specialty = "Cardiologist".obs;
//   final date = DateTime.now().add(Duration(days: 2)).obs;
//   final time = "10:30 AM".obs;
//   final notes = "Routine check-up and heart pain consultation.".obs;







// }
// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/data/models/appointment_model.dart';
// import 'package:healthcare_hub/data/models/patient_model.dart';
// import 'package:healthcare_hub/data/repositories/firestore_repository.dart';

// class AppointmentDetailsController extends GetxController {
//   final FireStoreRepository _firestoreRepository = FireStoreRepository();

//   // Store the fetched patient data
//   Rxn<PatientModel> patient = Rxn<PatientModel>();

//   /// Call this method using the patient UID (from appointment.patientId)
//   Future<void> fetchPatientByUid(String uid) async {
//     try {
//       final fetchedPatient = await _firestoreRepository.getDataById<PatientModel>(
//         collectionName: 'patients',
//         documentId: uid,
//         fromJson: (json) => PatientModel.fromMap(json),
//       );

//       if (fetchedPatient != null) {
//         patient.value = fetchedPatient as PatientModel?;
//       } else {
//         log("Patient not found for UID: $uid");
//       }
//     } catch (e) {
//       log("Error fetching patient: $e");
//     }
//   }
// }


import 'package:get/get.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';

class AppointmentDetailsController extends GetxController {
  final FireStoreRepository _repo = FireStoreRepository();

  Rxn<PatientModel> patient = Rxn<PatientModel>();

  Future<void> fetchPatient(String patientId) async {
    final fetchedPatient = await _repo.getPatientById(patientId);
    if (fetchedPatient != null) {
      patient.value = fetchedPatient;
    }
  }
}
