import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/custom_toast_show.dart';

class PersonalInfoController extends GetxController {
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController insuranceCardController = TextEditingController();
  final RxString selectedBloodGroup = 'O+'.obs;
  final RxList<String> bloodGroups =
      ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', "Don't know"].obs;


  RxBool isAbove18 = false.obs;

  void setBirthDate(DateTime birthDate) {
    dobController.text = _formatDate(birthDate);
    isAbove18.value = _calculateAge(birthDate) >= 18;
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void updateBloodGroup(String value) => selectedBloodGroup.value = value;
  var pickedPDF = Rxn<File>();
  RxString selectedGender = 'Male'.obs;

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      pickedPDF.value = File(result.files.single.path!);
    }
  }

  RxBool isLoading = false.obs;

  void refreshField() {
    heightController.clear();
    weightController.clear();
    idCardController.clear();
    phoneNumberController.clear();
    formKey = GlobalKey<FormState>();
    dobController.clear();
    selectedBloodGroup.value = 'O+';
    selectedGender.value = 'Male';
    pickedPDF = Rxn<File>();
    aboutController.clear();
    insuranceCardController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
