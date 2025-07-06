import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/widgets/horizontal_string_wrapped.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class DoctorContainer extends StatelessWidget {
  DoctorContainer({super.key, required this.doctor});

  final AppSizes appSizes = AppSizes();
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.DOCTORDETAILSSCREEN,
          arguments: {"doctor": doctor},
        );
      },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
      ? NetworkImage(doctor.imageUrl!)
      : AssetImage(doctor.gender?.toLowerCase() == 'female'
              ? AppImages.femaleDr
              : AppImages.maleDr,),),
                Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: "Dr.${doctor.firstName}",
                      textColor: AppColors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      limitedCharacters: true,
                      noOfCharacter: 12,
                    ),
                    SizedBox(
                      width: appSizes.getWidthPercentage(70),
                      child: CustomTextWidget(
                        text: doctor.about!,
                        textColor: AppColors.blackish,
                        textAlign: TextAlign.start,
                        textOverflow: TextOverflow.visible,

                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(8),
            HorizontalWrappedStrings(items: doctor.degreesName!),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: "Specialization:",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8),
                CustomTextWidget(
                  text: doctor.specialization!,
                  fontSize: 13,
                  textColor: AppColors.blackish,
                ),
              ],
            ),
            Gap(1),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  size: 18,
                  color: AppColors.blue,
                ),
                Gap(6),
                CustomTextWidget(
                  text: doctor.hospitalName!,
                  fontSize: 13,
                  textColor: AppColors.blackish,
                  textOverflow: TextOverflow.visible,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Gap(8),
            CustomElevatedButton(
              height: 30,
              borderRadius: 6,
              textSize: 10,
              onPress: () {
                Get.toNamed(
                  AppRoutes.APPOINTMENTSCREEN,
                  arguments: {"doctor": doctor},
                );
              },
              text: "Book Appointment",
            ),
          ],
        ),
      ),
    );
  }
}
