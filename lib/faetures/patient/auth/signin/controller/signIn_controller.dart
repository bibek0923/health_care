import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/widgets/custom_toast_show.dart';
import '../../../../../data/repositories/user_repository.dart';

class SignInController extends GetxController {
  ToastClass toast = ToastClass();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserRepository auth = UserRepository();
  RxBool isLoading = false.obs;

  Future<void> userSignIn() async {
    try {
      isLoading.value = true;
      await auth
          .signIn(emailController.text.trim(), passwordController.text.trim())
          .then(
            (value) {
          emailController.clear();
          passwordController.clear();
          Get.offNamed(AppRoutes.HOMESCREEN);
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
