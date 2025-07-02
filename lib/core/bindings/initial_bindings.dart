import 'package:get/get.dart';
import 'package:healthcare_hub/faetures/ai/controller/ai_controller.dart';
import 'package:healthcare_hub/faetures/doctor/auth/forget_password/controller/forget_password_controller.dart';
import 'package:healthcare_hub/faetures/doctor/auth/personal_info/controller/personal_info_controller.dart';
import 'package:healthcare_hub/faetures/doctor/auth/sign_up/controller/signup_controller.dart';
import 'package:healthcare_hub/faetures/doctor/auth/signin/controller/signIn_controller.dart';
import 'package:healthcare_hub/faetures/doctor/home/controllers/home_controller.dart';
import 'package:healthcare_hub/faetures/doctor/patient_details/controller/patient_details_controller.dart';
import 'package:healthcare_hub/faetures/doctor/profile/doctor_profile/controller/doctor_profile_controller.dart';
import 'package:healthcare_hub/faetures/doctor/profile/edit_doctor_profile/controller/edit_doctor_profile_controller.dart';
import '../../faetures/doctor/appointment_details/controller/appointment_details_controller.dart';
import '../../faetures/doctor/auth/other_info/controller/other_info_controller.dart';
import '../../faetures/patient/appointment/controller/appointment_controller.dart';
import '../../faetures/patient/appointment/pages/appointment_details/controller/appointment_details_controller.dart';
import '../../faetures/patient/auth/forget_password/controller/forget_password_controller.dart';
import '../../faetures/patient/auth/guardian_info/controller/guardian_info_controller.dart';
import '../../faetures/patient/auth/personal_info/controller/personal_info_controller.dart';
import '../../faetures/patient/auth/sign_up/controller/signup_controller.dart';
import '../../faetures/patient/auth/signin/controller/signIn_controller.dart';
import '../../faetures/patient/doctor_details/controller/doctor_details_controller.dart';
import '../../faetures/patient/home/controllers/home_controller.dart';
import '../../faetures/patient/profile/patient_profile/controller/patient_profile_controller.dart';
import '../../faetures/user_type/controller/user_type_controller.dart';

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

    Get.put(PersonalInfoController());
    Get.lazyPut(() => PersonalInfoController());

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

    Get.put(GuardianInfoController());
    Get.lazyPut(() => GuardianInfoController());

    Get.put(DrSignInController());
    Get.lazyPut(() => DrSignInController());

    Get.put(DrSignUpController());
    Get.lazyPut(() => DrSignUpController());

    Get.put(DrPersonalInfoController());
    Get.lazyPut(() => DrPersonalInfoController());

    Get.put(DrOtherInfoController());
    Get.lazyPut(() => DrOtherInfoController());

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
  }
}
