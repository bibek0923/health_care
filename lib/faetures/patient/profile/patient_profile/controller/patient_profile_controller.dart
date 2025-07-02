import 'package:get/get.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import 'package:healthcare_hub/data/shared_preference/shared_preference_services.dart';
import '../../../../../data/models/patient_model.dart';
import '../../../../../data/repositories/firestore_repository.dart';
import '../../../../../data/repositories/user_repository.dart';

class PatientProfileController extends GetxController {
  UserRepository auth = UserRepository();
  FireStoreRepository fireStore = FireStoreRepository();
  late String userId = '';

  Stream<PatientModel?> getUserStream() {
    return fireStore.getDataByUserID(
      collectionName: "healthCare_hub",
      fromJson: PatientModel.fromMap,
    );
  }

  @override
  void onInit() async {
    await getUserId();
    super.onInit();
  }

  String formatIdCardNumber(String id) {
    if (id.length < 6) return id;
    String firstPart = id.substring(0, 4);
    String middlePart = id.substring(4, id.length - 1);
    String lastChar = id.substring(id.length - 1);

    return '$firstPart-$middlePart-$lastChar';
  }

  Future<void> getUserId() async {
    userId = (await PreferenceHelper.getString("userID"))!;
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
