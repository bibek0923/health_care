
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/app_routes/routes.dart';
class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    checkUserLoginStatus();
  }

  void checkUserLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    User? user = _auth.currentUser;

    if (user != null) {
      final uid = user.uid;

      // First check in 'doctors' collection
      DocumentSnapshot doctorDoc = await _firestore.collection('healthCare_hub_Doctor').doc(uid).get();

      if (doctorDoc.exists) {
        Get.offAllNamed(AppRoutes.DRHOMESCREEN);
        return;
      }

      // Then check in 'patients' collection
      DocumentSnapshot patientDoc = await _firestore.collection('healthCare_hub').doc(uid).get();

      if (patientDoc.exists) {
        Get.offAllNamed(AppRoutes.HOMESCREEN);
        return;
      }

      // If neither exists, fallback
      Get.offAllNamed(AppRoutes.USERTYPESCREEN);
    } else {
      // User not logged in
      Get.offAllNamed(AppRoutes.USERTYPESCREEN);
    }
  }
}
