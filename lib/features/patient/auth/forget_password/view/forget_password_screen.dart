import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/Const/app_images.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../controller/forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordController controller =
      Get.find<ForgetPasswordController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: appSizes.getCustomPadding(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: appSizes.getWidthPercentage(24),
                    height: appSizes.getHeightPercentage(20),
                  ),
                  const CustomTextWidget(
                    text: "Reset Password!",
                    textColor: AppColors.black,
                    textOverflow: TextOverflow.visible,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  const Gap(16),
                  SizedBox(
                    width: appSizes.getWidthPercentage(80),
                    child: const CustomTextWidget(
                      text:
                          "Please enter your account email to reset your password!",
                      textColor: AppColors.blackish,
                      textOverflow: TextOverflow.visible,
                    ),
                  ),
                  const Gap(16),
                  CustomInputTextField(
                    hintText: "Enter your email",
                    textEditingController: controller.emailController,
                  ),
                  const Gap(18),
                  Obx(
                    () => CustomElevatedButton(
                      isLoading: controller.isLoading.value,
                      onPress: () async {
                        if (controller.emailController.text.isNotEmpty) {
                         await controller.resetPassword();
                        } else {
                          controller.toast.showCustomToast(
                            "Please enter your email",
                          );
                        }
                      },
                      text: "Reset Password",
                    ),
                  ),
                  Gap(appSizes.getHeightPercentage(2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextWidget(
                        text: "Don't forget password",
                        fontSize: 12,
                        textColor: AppColors.blackish,
                      ),
                      Gap(4),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const CustomTextWidget(
                          text: "Back to Login",
                          fontSize: 13,
                          textColor: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
