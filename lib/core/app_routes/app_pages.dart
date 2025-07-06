import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import 'package:healthcare_hub/features/ai/view/ai_screen.dart';
// import 'package:healthcare_hub/faetures/appointment_confirmation/appointment_confirmation.dart';
import 'package:healthcare_hub/features/doctor/appointment_details/view/appointment_details_screen.dart';
import 'package:healthcare_hub/features/doctor/auth/forget_password/view/forget_password_screen.dart';
// import 'package:healthcare_hub/features/doctor/auth/personal_info/view/personal_info_screen.dart';
import 'package:healthcare_hub/features/doctor/auth/sign_up/view/sign_up_screen.dart';
import 'package:healthcare_hub/features/doctor/auth/signin/view/signin_screen.dart';
import 'package:healthcare_hub/features/doctor/home/view/home_screen.dart';
import 'package:healthcare_hub/features/doctor/patient_details/view/patient_details_screen.dart';
import 'package:healthcare_hub/features/doctor/profile/doctor_profile/view/doctor_profile_screen.dart';
import 'package:healthcare_hub/features/patient/auth/forget_password/view/forget_password_screen.dart';
import 'package:healthcare_hub/features/patient/home/navbar_appointment_screen/pages/nav_bar_appointmentScreen.dart';
// import '../../features/doctor/auth/other_info/view/other_info_screen.dart';
import '../../features/patient/appointment/pages/appointment_details/view/appointment_details_screen.dart';
import '../../features/patient/appointment/view/appointment_screen.dart';
// import '../../features/patient/auth/guardian_info/view/guardian_info_screen.dart';
// import '../../features/patient/auth/personal_info/view/personal_info_screen.dart';
import '../../features/patient/auth/sign_up/view/sign_up_screen.dart';
import '../../features/patient/auth/signin/view/signin_screen.dart';
import '../../features/patient/doctor_details/view/doctor_details_screen.dart';
import '../../features/patient/home/view/home_screen.dart';
import '../../features/patient/profile/patient_profile/view/patient_profile_screen.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/user_type/view/user_type_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASHSCREEN,
      page: () => SplashScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.USERTYPESCREEN,
      page: () => UserTypeScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.FORGETPASSWORDSCREEN,
      page: () => ForgetPasswordScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.SIGNINSCREEN,
      page: () => SignInScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.SIGNUPSCREEN,
      page: () => SignUpScreen(),
      transition: Transition.zoom,
      transitionDuration: const Duration(microseconds: 300),
    ),
    GetPage(
      name: AppRoutes.HOMESCREEN,
      page: () => HomeScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.PATIENTPROFILESCREEN,
      page: () => PatientProfileScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.DOCTORDETAILSSCREEN,
      page: () => DoctorDetailsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    // GetPage(
    //   name: AppRoutes.PERSONALINFOSCREEN,
    //   page: () => PersonalInfoScreen(),
    //   transition: Transition.fade,
    //   curve: Curves.linear,
    //   transitionDuration: const Duration(microseconds: 200),
    // ),
    GetPage(
      name: AppRoutes.APPOINTMENTSCREEN,
      page: () => AppointmentScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.APPOINTMENTDETAILSSCREEN,
      page: () => AppointmentDetailsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    // GetPage(
    //   name: AppRoutes.GUARDIANINFOSCREEN,
    //   page: () => GuardianInfoScreen(),
    //   transition: Transition.fade,
    //   curve: Curves.linear,
    //   transitionDuration: const Duration(microseconds: 200),
    // ),

    // GetPage(
    //   name: AppRoutes.DROTHERINFOSCREEN,
    //   page: () => DrOtherInfoScreen(),
    //   transition: Transition.fade,
    //   curve: Curves.linear,
    //   transitionDuration: const Duration(microseconds: 200),
    // ),
    GetPage(
      name: AppRoutes.DRSIGNINSCREEN,
      page: () => DrSignInScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.DRSIGNUPSCREEN,
      page: () => DrSignUpScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    // GetPage(
    //   name: AppRoutes.DRPERSONALINFOSCREEN,
    //   page: () => DrPersonalInfoScreen(),
    //   transition: Transition.fade,
    //   curve: Curves.linear,
    //   transitionDuration: const Duration(microseconds: 200),
    // ),
    GetPage(
      name: AppRoutes.DRFORGETPASSWORDSCREEN,
      page: () => DrForgetPasswordScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.DRFORGETPASSWORDSCREEN,
      page: () => DrForgetPasswordScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.DRHOMESCREEN,
      page: () => DrHomeScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.DOCTORPROFILESCREEN,
      page: () => DoctorProfileScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.PATIENTDETAILSSCREEN,
      page: () => PatientDetailsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.DRAPPOINTMENTDETAILSSCREEN,
      page: () => DrAppointmentDetailsScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
    GetPage(
      name: AppRoutes.AICHATSCREEN,
      page: () => AiChatScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),

    GetPage(
      name: AppRoutes.NAVAPPOINTMENTSCREEN,
      page: () => NavAppointmentScreen(),
      transition: Transition.fade,
      curve: Curves.linear,
      transitionDuration: const Duration(microseconds: 200),
    ),
  ];
}
