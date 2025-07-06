import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/custom_toast_show.dart';
import '../../../../../data/repositories/user_repository.dart';

class ForgetPasswordController extends GetxController {
  final ToastClass toast = ToastClass();
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  UserRepository auth = UserRepository();
  Future<void> resetPassword() async{
    try{
      isLoading.value = true;
      await auth.resetPassword(emailController.text.trim()).then((value) {
        emailController.clear();
        return Get.back();
      });
    }catch(e){
      log("Exception : $e");
    }finally{
      isLoading.value = false;

    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
  }
}
