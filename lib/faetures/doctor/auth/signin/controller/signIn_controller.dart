import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/widgets/custom_toast_show.dart';
import '../../../../../data/repositories/user_repository.dart';

class DrSignInController extends GetxController {
  ToastClass toast = ToastClass();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  UserRepository auth = UserRepository();

  Future<void> userSignIn() async {
    try {
      isLoading.value = true;
      await auth
          .signIn(emailController.text.trim(), passwordController.text.trim())
          .then(
            (value) {
          emailController.clear();
          passwordController.clear();
          Get.offNamed(AppRoutes.DRHOMESCREEN);
        },
      );
    } catch (e) {
      log("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
}
