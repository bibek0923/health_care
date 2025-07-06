import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/Const/app_images.dart';
import '../../../../core/app_routes/routes.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../controller/user_type_controller.dart';

class UserTypeScreen extends StatelessWidget {
  UserTypeScreen({super.key});

  UserTypeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
          child: Padding(
            padding: AppSizes().getCustomPadding(),
            child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(AppSizes().getHeightPercentage(10)),
                Image(
                  image: AssetImage(AppImages.logo),
                  height: AppSizes().getHeightPercentage(23),
                  width: AppSizes().getWidthPercentage(60),
                ),
                Gap(AppSizes().getHeightPercentage(1)),
                Gap(46),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.selectType('Doctor'),
                      child: Container(
                        width: AppSizes().getWidthPercentage(31),
                        height: 170,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: controller.isDoctor
                              ? AppColors.blue
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: controller.isDoctor?AppColors.blue:AppColors.blackish,
                                spreadRadius: -1,
                                blurRadius: 8
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CustomTextWidget(
                            text: "Doctor",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            textColor: controller.isDoctor?AppColors.white:AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    Gap(16),
                    GestureDetector(
                      onTap: () => controller.selectType('Patient'),
                      child: Container(
                        width: AppSizes().getWidthPercentage(30),
                        height: 170,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: controller.isPatient
                              ? AppColors.blue
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: controller.isPatient?AppColors.blue:AppColors.blackish,
                              spreadRadius: -1,
                              blurRadius: 8
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CustomTextWidget(
                            text: "Patient",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            textColor: controller.isPatient?AppColors.white:AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(AppSizes().getHeightPercentage(15)),
                CustomElevatedButton(
                  width: AppSizes().getWidthPercentage(75),
                  borderRadius: 36,
                  onPress: () {
                    if (controller.selectedType.value == '') return;
                    if (controller.isDoctor) {
                      Get.toNamed(AppRoutes.DRSIGNINSCREEN);
                    } else {
                      Get.toNamed(AppRoutes.SIGNINSCREEN);
                    }
                  },
                  text: "Continue",
                  backgroundColor: AppColors.blue,
                )
              ],
            )),
          )),
    );
  }
}
