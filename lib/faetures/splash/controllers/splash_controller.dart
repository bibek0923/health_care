import 'package:get/get.dart';
import 'package:healthcare_hub/data/shared_preference/shared_preference_services.dart';
import '../../../core/app_routes/routes.dart';
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToSignIn();
  }

  void navigateToSignIn() async {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.USERTYPESCREEN);
    });
  }
}
