import 'package:get/get.dart';
class UserTypeController extends GetxController {
  var selectedType = 'Doctor'.obs;

  void selectType(String type) {
    selectedType.value = type;
  }

  bool get isDoctor => selectedType.value == 'Doctor';

  bool get isPatient => selectedType.value == 'Patient';
}