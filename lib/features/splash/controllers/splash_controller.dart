// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/data/shared_preference/shared_preference_services.dart';
// import '../../../core/app_routes/routes.dart';
// class SplashController extends GetxController {
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   @override
//   void onInit() {
//     super.onInit();
    
//     navigateToSignIn();
//   }

//   void navigateToSignIn() async {
//     Future.delayed(const Duration(seconds: 3), () {
//       User? user = _auth.currentUser;

//       Get.offAllNamed(AppRoutes.USERTYPESCREEN);
//     });
//   }
// }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../core/app_routes/routes.dart';

// class SplashController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   void onInit() {
//     super.onInit();
//     checkUserLoginStatus();
//   }

//   void checkUserLoginStatus() async {
//     Future.delayed(const Duration(seconds: 3), () async {
//       User? user = _auth.currentUser;

//       if (user != null) {
//         // Fetch user document from Firestore
//         DocumentSnapshot userDoc = await _firestore.collection("healthCare_hub_Doctor").doc(user.uid).get();

//         if (userDoc.exists) {
//           Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

//           // Check if doctorId field exists and is not empty
//           if (data.containsKey('doctorId') && (data['doctorId'] as String).isNotEmpty) {
//             // User is a doctor
//             Get.offAllNamed(AppRoutes.DRHOMESCREEN);
//           } else {
//             // Assume patient if no doctorId found
//             Get.offAllNamed(AppRoutes.HOMESCREEN);
//           }
//         } else {
//           // User doc not found, fallback to user type selection screen
//           Get.offAllNamed(AppRoutes.USERTYPESCREEN);
//         }
//       } else {
//         // No user logged in, navigate to user type selection
//         Get.offAllNamed(AppRoutes.USERTYPESCREEN);
//       }
//     });
//   }
// }
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
