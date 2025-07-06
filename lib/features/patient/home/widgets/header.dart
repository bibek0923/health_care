import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:marquee/marquee.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widgets/custom_header_shimmer.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../controllers/home_controller.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.appSizes, required this.controller});

  final AppSizes appSizes;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: appSizes.getWidthPercentage(100),
      padding: appSizes.getCustomPadding(top: 4),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(color: AppColors.black, spreadRadius: -1, blurRadius: 8),
        ],
      ),
      child: StreamBuilder(
        stream: controller.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HeaderShimmer();
          } else if (snapshot.hasData) {
            PatientModel? patient = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: controller.getGreetings(),
                      textColor: AppColors.whitish,
                      fontSize: 16,
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.white,
                      ),
                      onSelected: (value) {
                        if (value == 'sync') {
                        } else if (value == 'logout') {
                          controller.auth.signOut();
                        }
                      },
                      offset: Offset(-22, 16),
                      itemBuilder:
                          (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'sync',
                              child: CustomTextWidget(text: 'Sync'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'logout',
                              child: CustomTextWidget(text: 'Logout'),
                            ),
                          ],
                    ),
                  ],
                ),
                Gap(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.PATIENTPROFILESCREEN);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: patient!.imageUrl != null && patient.imageUrl!.isNotEmpty
      ? NetworkImage(patient.imageUrl!)
      : AssetImage(patient.gender?.toLowerCase() == 'female'
              ? AppImages.femalePatient
              : AppImages.malePatient,),
                      ),
                    ),
                    Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text: "Mr. ${patient.firstName}",
                          textColor: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          limitedCharacters: true,
                          noOfCharacter: 15,
                        ),
                        CustomTextWidget(
                          text: patient.email!,
                          textColor: AppColors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(28),
                SizedBox(
                  height: 30,
                  child: Marquee(
                    text: "Caring for Life, Every Step of the Way.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.yellow,
                    ),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 50.0,
                    velocity: 50.0,
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CustomTextWidget(
              text: "User not fount",
              textColor: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}
