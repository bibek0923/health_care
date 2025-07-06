import 'package:get/get.dart';
import 'package:healthcare_hub/data/repositories/firestore_repository.dart';

import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/doctor_model.dart';

class PatientDetailsController extends GetxController{
  FireStoreRepository fireStore = FireStoreRepository();
  String formatIdCardNumber(String id) {
    if (id.length < 6) return id;
    String firstPart = id.substring(0, 4);
    String middlePart = id.substring(4, id.length - 1);
    String lastChar = id.substring(id.length - 1);

    return '$firstPart-$middlePart-$lastChar';
  }

  Stream<List<AppointmentModel>> getAppointmentsStream() {
    return fireStore.getAllData(
      collectionName: "appointments",
      fromJson: AppointmentModel.fromJson,
    );
  }

  Stream<DoctorModel?> getDoctorData(String doctorId) {
    return fireStore.getDataById(
      collectionName: "healthCare_hub_Doctor",
      documentId: doctorId,
      fromJson: DoctorModel.fromMap,
    );
  }
}