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
import '../controller/signup_controller.dart';

class DrSignUpScreen extends StatelessWidget {
  DrSignUpScreen({super.key});

  final DrSignUpController controller = Get.find<DrSignUpController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: appSizes.getCustomPadding(left: 6, right: 6, top: 12),
              width: appSizes.getWidthPercentage(100),
              padding: appSizes.getCustomPadding(
                right: 6,
                left: 6,
                bottom: 4,
                top: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black,
                    spreadRadius: -1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextWidget(
                        text: "REGISTRATION",
                        textColor: AppColors.yellow,
                        fontSize: 22,
                      ),
                      const Gap(6),
                      Obx(
                        () => Container(
                          height: appSizes.getHeightPercentage(12),
                          width: appSizes.getWidthPercentage(28),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                              color: AppColors.white,
                            ),
                            image:
                                controller.imagePicker.selectedImage.value ==
                                            null ||
                                        controller
                                                .imagePicker
                                                .selectedImage
                                                .value ==
                                            ''
                                    ? null
                                    : DecorationImage(
                                      image: FileImage(
                                        controller
                                            .imagePicker
                                            .selectedImage
                                            .value!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                          ),
                          child: Center(
                            child:
                                controller.imagePicker.selectedImage.value ==
                                            null ||
                                        controller
                                                .imagePicker
                                                .selectedImage
                                                .value ==
                                            ''
                                    ? GestureDetector(
                                      onTap: () {
                                        controller.imagePicker
                                            .showImagePickerDialog();
                                      },
                                      child: ClipOval(
                                        child: Padding(
                                          padding: const EdgeInsets.all(23),
                                          child: Image.asset(
                                            AppImages.image,
                                            fit: BoxFit.cover,
                                            color: AppColors.whitish,
                                          ),
                                        ),
                                      ),
                                    )
                                    : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController:
                        controller.firstNameController,
                        hintText: "First name",
                        isFilled: true,
                        filledColor: AppColors.white,
                        isValidator: true,
                        emptyValueErrorText: "Please enter first name",
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController:
                        controller.middleNameController,
                        hintText: "Middle name",
                        isFilled: true,
                        isValidator: false,
                        filledColor: AppColors.white,
                      ),
                      const Gap(16),
                    CustomInputTextField(
                      textEditingController:
                      controller.lastNameController,
                      hintText: "Last name",
                      isFilled: true,
                      filledColor: AppColors.white,
                      isValidator: true,
                      emptyValueErrorText: "Please enter last name",
                    ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController: controller.emailController,
                        hintText: "Enter email",
                        isValidator: true,
                        isFilled: true,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your email",
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController:
                            controller.createPasswordController,
                        hintText: "Create your password",
                        hasSuffixIcon: true,
                        isFilled: true,
                        filledColor: AppColors.white,
                        isObsecure: true,
                        isValidator: true,
                        emptyValueErrorText: "Please create password",
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController:
                            controller.confirmPasswordController,
                        hintText: "Confirm your password",
                        hasSuffixIcon: true,
                        isObsecure: true,
                        isFilled: true,
                        filledColor: AppColors.white,
                        isValidator: true,
                        emptyValueErrorText: "Please enter confirm password",
                      ),
                      const Gap(22),
                      Obx(
                        () => CustomElevatedButton(
                          isLoading: controller.isLoading.value,
                          backgroundColor: AppColors.yellow,
                          textColor: AppColors.blue,
                          onPress: () async{
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.createPasswordController.text ==
                                  controller.confirmPasswordController.text) {
                                await controller.doctorRegistration();
                                controller.refreshField();
                              } else {
                                controller.toast.showCustomToast(
                                  "Passwords mismatch",
                                );
                              }
                            } else {
                              controller.toast.showCustomToast(
                                "Please fill all fields",
                              );
                            }
                          },
                          text: "NEXT",
                        ),
                      ),
                      Gap(appSizes.getHeightPercentage(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomTextWidget(
                            text: "Already have an account?",
                            fontSize: 12,
                            textColor: AppColors.whitish,
                          ),
                          Gap(4),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.DRSIGNINSCREEN);
                            },
                            child: const CustomTextWidget(
                              text: "Sign In",
                              fontSize: 13,
                              textColor: AppColors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
