import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import 'package:healthcare_hub/faetures/appointment_confirmation/appointment_confirmation.dart';
import 'package:intl/intl.dart';
import '../controller/appointment_details_controller.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final controller = Get.find<AppointmentDetailsController>();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor = Get.arguments["doctor"];
    final AppointmentModel appointment = Get.arguments["appointment"];
    controller.fetchPatient(appointment.patientId);
    // final PatientModel patient =Get.arguments["patient"];
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (controller.patient.value == null) {
    //     controller.fetchPatientByUid(appointment.patientId);
    //   }
    // }
    // );
    final patient = controller.patient.value;
    print("this is $patient");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Appointment Details", goBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.DOCTORDETAILSSCREEN,
                  arguments: {"doctor": doctor},
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
                              ? NetworkImage(doctor.imageUrl!)
                              : AssetImage(
                                doctor.gender?.toLowerCase() == 'female'
                                    ? AppImages.femalePatient
                                    : AppImages.malePatient,
                              ),
                    ),
                    Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: "Dr ${doctor.firstName} ${doctor.lastName}",
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.white,
                        ),
                        CustomTextWidget(
                          text: doctor.specialization!,
                          textColor: AppColors.whitish,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(18),
            CustomTextWidget(
              text: "Appointment Info",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            Gap(8),
            CustomTextWidget(text: appointment.title, fontSize: 20),
            Gap(12),
            buildInfoTile(
              icon: Icons.calendar_today,
              label: "Date",
              value: DateFormat('EEEE, dd MMM yyyy').format(appointment.date),
            ),
            buildInfoTile(
              icon: Icons.access_time,
              label: "Time",
              value: appointment.timeSlot,
            ),
            buildInfoTile(
              icon: Icons.notes,
              label: "Notes",
              value: appointment.notes!,
              // value:patient!.email!,
            ),

            Gap(30),

            // CustomElevatedButton(onPress: (){}, text: "Appointment Confirmation")
            // ElevatedButton.icon(
            //   onPressed: () {
            //     if (patient != null) {
            //       Get.toNamed(
            //         AppRoutes.APPOINTMENT_CONFIRMATION_SCREEN,
            //         arguments: {
            //           "doctor": doctor,
            //           "appointment": appointment,
            //           "patient": patient,
            //         },
            //       );
            //     }
            //     else{
            //       Get.snackbar("Please wait", "Details are still loading");
            //     }
            //     // Navigator.of(context).push(
            //     //   MaterialPageRoute(
            //     //     builder: (ctx) => AppointmentConfirmationScreen(),
            //     //   ),
            //     // );
            //   },
            //   label: Text("Appointment Confirmation"),
            //   icon: Icon(Icons.picture_as_pdf),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.blue,
            //     foregroundColor: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     elevation: 2,
            //   ),
            // ),
            // Obx(
            //   () => ElevatedButton.icon(
            //     onPressed:
            //         controller.patient.value != null
            //             ? () {
            //               Get.toNamed(
            //                 AppRoutes.APPOINTMENT_CONFIRMATION_SCREEN,
            //                 arguments: {
            //                   "doctor": doctor,
            //                   "appointment": appointment,
            //                   "patient": controller.patient.value,
            //                 },
            //               );
            //             }
            //             : null, // Disable button if patient is null
            //     label: Text(
            //       controller.patient.value != null
            //           ? "Appointment Confirmation"
            //           : "Loading...",
            //     ),
            //     icon: Icon(Icons.picture_as_pdf),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.blue,
            //       foregroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       elevation: 2,
            //     ),
            //   ),
            // ),
            ElevatedButton.icon(
              // onPressed:
              //     controller.patient.value != null
              //         ? () {
              //           Get.toNamed(
              //             AppRoutes.APPOINTMENT_CONFIRMATION_SCREEN,
              //             arguments: {
              //               "doctor": doctor,
              //               "appointment": appointment,
              //               "patient": controller.patient.value,
              //             },
              //           );
              //         }
              //         : null, // Disable button if patient is null
              onPressed: () {
                if (patient != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => AppointmentConfirmationScreen(
                            appointment: appointment,
                            doctor: doctor,
                            patient: patient,
                          ),
                    ),
                  );
                }
              },
              label: Text(
                patient != null
                    ? "Appointment Confirmation"
                    : "Loading...",
              ),
              icon: Icon(Icons.picture_as_pdf),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: appSizes.getCustomPadding(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.blue),
          Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(text: label, fontWeight: FontWeight.w500),
                CustomTextWidget(
                  text: value,
                  textOverflow: TextOverflow.visible,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
