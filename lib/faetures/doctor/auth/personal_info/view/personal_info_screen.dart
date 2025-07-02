import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../controller/personal_info_controller.dart';

class DrPersonalInfoScreen extends StatelessWidget {
  DrPersonalInfoScreen({super.key});

  final DrPersonalInfoController controller = Get.find<DrPersonalInfoController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Container(
              margin: appSizes.getCustomPadding(
                left: 6,
                right: 6,
                top: 8,
                bottom: 6,
              ),
              width: appSizes.getWidthPercentage(100),
              padding: appSizes.getCustomPadding(right: 6, left: 6),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: "PERSONAL INFORMATION",
                        textColor: AppColors.yellow,
                        fontSize: 22,
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController: controller.licenseController,
                        hintText: "Enter License number",
                        isValidator: true,
                        isFilled: true,
                        numberKeyboard: true,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your License number",
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController: controller.phoneNumberController,
                        hintText: "Enter phone number",
                        isValidator: true,
                        isFilled: true,
                        maxLength: 10,
                        numberKeyboard: true,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your phone number",
                      ),
                      const Gap(4),
                      CustomInputTextField(
                        textEditingController: controller.experienceController,
                        hintText: "Enter experience (Years)",
                        isValidator: true,
                        isFilled: true,
                        numberKeyboard: true,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your experience",
                        maxLength: 2,
                      ),
                      const Gap(4),
                      CustomInputTextField(
                        textEditingController: controller.aboutController,
                        hintText: "About",
                        isValidator: true,
                        isFilled: true,
                        maxLines: 4,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter about you",
                      ),
                      const Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => Radio(
                              value: 'Male',
                              activeColor: AppColors.white,
                              groupValue: controller.selectedGender.value,
                              onChanged:
                                  (value) =>
                                      controller.selectedGender.value = value!,
                            ),
                          ),
                          const CustomTextWidget(
                            textAlign: TextAlign.start,
                            text: 'Male',
                            textColor: AppColors.white,
                          ),
                          const Gap(16),
                          Obx(
                            () => Radio(
                              value: 'Female',
                              activeColor: AppColors.white,
                              groupValue: controller.selectedGender.value,
                              onChanged:
                                  (value) =>
                                      controller.selectedGender.value = value!,
                            ),
                          ),
                          const CustomTextWidget(
                            textAlign: TextAlign.start,
                            text: 'Female',
                            textColor: AppColors.white,
                          ),
                        ],
                      ),
                      const Gap(32),
                      Row(
                        children: [
                          Expanded(
                            child: CustomOutlineButton(
                              borderColor: AppColors.white,
                              textColor: AppColors.white,
                              onPress: () {
                                Get.back();
                              },
                              text: "BACK",
                            ),
                          ),
                          Gap(8),
                          Expanded(
                            child: Obx(
                              () => CustomElevatedButton(
                                isLoading: controller.isLoading.value,
                                backgroundColor: AppColors.yellow,
                                textColor: AppColors.blue,
                                onPress: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    Get.toNamed(AppRoutes.DROTHERINFOSCREEN,arguments: {
                                      "license":controller.licenseController.text.trim(),
                                    "phoneNumber":controller.phoneNumberController.text.trim(),
                                    "experience":controller.experienceController.text.trim(),
                                    "about":controller.aboutController.text.trim(),
                                    "gender":controller.selectedGender.value,
                                    });
                                    controller.refreshField();
                                  }
                                },
                                text: "NEXT",
                              ),
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
