import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/Const/app_images.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../controller/signIn_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController controller = Get.find<SignInController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: appSizes.getCustomPadding(left: 6,right: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(appSizes.getHeightPercentage(4)),
                  Image.asset(
                    AppImages.logo,
                    height: appSizes.getHeightPercentage(22),
                    width: appSizes.getWidthPercentage(50)
                  ),
                  Gap(appSizes.getHeightPercentage(6)),
                  Container(
                    width: appSizes.getWidthPercentage(100),
                    padding: appSizes.getCustomPadding(right: 6,left: 6,bottom: 4,top: 4),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black,
                              spreadRadius: -1,
                              blurRadius: 8
                          )
                        ]
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextWidget(
                          text: "LOGIN",
                          textColor: AppColors.yellow,
                          fontSize: 22
                        ),
                        const Gap(28),
                        CustomInputTextField(
                          textEditingController: controller.emailController,
                          hintText: "Enter Email",
                          filledColor: AppColors.white,
                          isFilled: true,
                          emptyValueErrorText: "Please enter your email"
                        ),
                        const Gap(16),
                        CustomInputTextField(
                          textEditingController:
                              controller.passwordController,
                          hintText: "Enter Password",
                          isObsecure: true,
                          borderColor: AppColors.whitish,
                          hasSuffixIcon: true,
                          filledColor: AppColors.white,
                          isFilled: true,
                          emptyValueErrorText: "Please enter your password"
                        ),
                        const Gap(6),
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.FORGETPASSWORDSCREEN);
                            },
                            child: const CustomTextWidget(
                              textAlign: TextAlign.end,
                              text: "Forget Password?",
                              fontSize: 14,
                              textColor: AppColors.whitish
                            ),
                          ),
                        ),
                        const Gap(28),
                        Obx(
                          () => CustomElevatedButton(
                            textColor: AppColors.blue,
                            backgroundColor: AppColors.yellow,
                            isLoading: controller.isLoading.value,
                            onPress: () async {
                              if (controller.passwordController.text != null) {
                                await controller.userSignIn();
                              } else {
                                controller.toast.showCustomToast("Please fill all fields");
                              }
                            },
                            text: "SIGN IN"
                          ),
                        ),
                        Gap(appSizes.getHeightPercentage(4)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomTextWidget(
                              text: "Don't have any account?",
                              fontSize: 12,
                              textColor: AppColors.whitish
                            ),
                            Gap(4),
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed(AppRoutes.SIGNUPSCREEN);
                              },
                              child: const CustomTextWidget(
                                text: "Create account",
                                fontSize: 13,
                                textColor: AppColors.yellow
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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