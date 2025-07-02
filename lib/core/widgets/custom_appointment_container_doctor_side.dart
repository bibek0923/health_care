import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:intl/intl.dart';
import '../Const/app_colors.dart';
import '../utils/app_sizes.dart';
import 'custom_text_widget.dart';
import 'package:get/get.dart';

class CustomAppointmentContainerDoctorSide extends StatelessWidget {
  const CustomAppointmentContainerDoctorSide({
    super.key,
    required this.appSizes,
    this.isDoctor = false,
    this.isExamined = false,
    required this.appointment,
    this.patientModel,
  });

  final AppSizes appSizes;
  final bool isDoctor;
  final PatientModel? patientModel;
  final bool isExamined;
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.DRAPPOINTMENTDETAILSSCREEN,
          arguments: {"patient": patientModel, "appointment": appointment},
        );
      },
      child: Container(
        width: appSizes.getWidthPercentage(100),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.blue, width: 0.8),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackish,
              blurRadius: 6,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(CupertinoIcons.calendar_today),
            Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                  text: appointment.title,
                  fontWeight: FontWeight.w500,
                ),
                CustomTextWidget(
                  text:
                      "${DateFormat('dd-MM-yyyy').format(appointment.date)} . ${appointment.timeSlot}",
                ),
                CustomTextWidget(text: "Mr.${patientModel!.firstName}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
