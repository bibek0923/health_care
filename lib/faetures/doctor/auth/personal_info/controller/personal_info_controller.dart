import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/custom_toast_show.dart';

class DrPersonalInfoController extends GetxController {
  ToastClass toast = ToastClass();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
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
    licenseController.clear();
    phoneNumberController.clear();
    experienceController.clear();
    aboutController.clear();
    selectedGender.value = "Male";
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    refreshField();
  }
}
