import 'package:get/get.dart';

class AppointmentDetailsController extends GetxController {
  final doctorName = "Dr. Sarah Khan".obs;
  final specialty = "Cardiologist".obs;
  final date = DateTime.now().add(Duration(days: 2)).obs;
  final time = "10:30 AM".obs;
  final notes = "Routine check-up and heart pain consultation.".obs;
}
