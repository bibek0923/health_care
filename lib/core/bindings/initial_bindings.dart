import 'package:get/get.dart';
import 'package:healthcare_hub/features/ai/controller/ai_controller.dart';
import 'package:healthcare_hub/features/doctor/auth/forget_password/controller/forget_password_controller.dart';
// import 'package:healthcare_hub/features/doctor/auth/personal_info/controller/personal_info_controller.dart';
import 'package:healthcare_hub/features/doctor/auth/sign_up/controller/signup_controller.dart';
import 'package:healthcare_hub/features/doctor/auth/signin/controller/signIn_controller.dart';
import 'package:healthcare_hub/features/doctor/home/controllers/home_controller.dart';
import 'package:healthcare_hub/features/doctor/patient_details/controller/patient_details_controller.dart';
import 'package:healthcare_hub/features/doctor/profile/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:healthcare_hub/features/doctor/profile/edit_doctor_profile/controller/edit_doctor_profile_controller.dart';
import 'package:healthcare_hub/features/patient/home/navbar_appointment_screen/controllers/navbar_appointment_controller.dart';
import '../../features/doctor/appointment_details/controller/appointment_details_controller.dart';
// import '../../features/doctor/auth/other_info/controller/other_info_controller.dart';
import '../../features/patient/appointment/controller/appointment_controller.dart';
import '../../features/patient/appointment/pages/appointment_details/controller/appointment_details_controller.dart';
import '../../features/patient/auth/forget_password/controller/forget_password_controller.dart';
// import '../../features/patient/auth/guardian_info/controller/guardian_info_controller.dart';
// import '../../features/patient/auth/personal_info/controller/personal_info_controller.dart';
import '../../features/patient/auth/sign_up/controller/signup_controller.dart';
import '../../features/patient/auth/signin/controller/signIn_controller.dart';
import '../../features/patient/doctor_details/controller/doctor_details_controller.dart';
import '../../features/patient/home/controllers/home_controller.dart';
import '../../features/patient/profile/patient_profile/controller/patient_profile_controller.dart';
import '../../features/user_type/controller/user_type_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgetPasswordController());
    Get.lazyPut(() => ForgetPasswordController(),);

    Get.put(UserTypeController());
    Get.lazyPut(() => UserTypeController());

    Get.put(SignUpController());
    Get.lazyPut(() => SignUpController(),);

    Get.put(SignInController());
    Get.lazyPut(() => SignInController());

    // Get.put(PersonalInfoController());
    // Get.lazyPut(() => PersonalInfoController());

    Get.put(HomeController());
    Get.lazyPut(() => HomeController());

    Get.put(PatientProfileController());
    Get.lazyPut(() => PatientProfileController());

    Get.put(DoctorDetailsController());
    Get.lazyPut(() => DoctorDetailsController());

    Get.put(AppointmentController());
    Get.lazyPut(() => AppointmentController());

    Get.put(DrAppointmentDetailsController());
    Get.lazyPut(() => DrAppointmentDetailsController());

    Get.put(AppointmentDetailsController());
    Get.lazyPut(() => AppointmentDetailsController());

    // Get.put(GuardianInfoController());
    // Get.lazyPut(() => GuardianInfoController());

    Get.put(DrSignInController());
    Get.lazyPut(() => DrSignInController());

    Get.put(DrSignUpController());
    Get.lazyPut(() => DrSignUpController());

    // Get.put(DrPersonalInfoController());
    // Get.lazyPut(() => DrPersonalInfoController());

    // Get.put(DrOtherInfoController());
    // Get.lazyPut(() => DrOtherInfoController());

    Get.put(DrForgetPasswordController());
    Get.lazyPut(() => DrForgetPasswordController());

    Get.put(DrHomeController());
    Get.lazyPut(() => DrHomeController());

    Get.put(PatientDetailsController());
    Get.lazyPut(() => PatientDetailsController());

    Get.put(DoctorProfileController());
    Get.lazyPut(() => DoctorProfileController());

    Get.put(AiChatController());
    Get.lazyPut(() => AiChatController());

    Get.put(NavbarAppointmentController());
    Get.lazyPut(()=>NavbarAppointmentController());
  }
}
