import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../../../../../core/widgets/custom_outline_button.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../controller/guardian_info_controller.dart';

class GuardianInfoScreen extends StatelessWidget {
  GuardianInfoScreen({super.key});

  final GuardianInfoController controller = Get.find<GuardianInfoController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    final String idCardNumber = Get.arguments["idCardNumber"];
    final String insuranceCardNumber = Get.arguments["insuranceCardNumber"];
    final String phoneNumber = Get.arguments["phoneNumber"];
    final String dob = Get.arguments["dob"];
    final String height = Get.arguments["height"];
    final String weight = Get.arguments["weight"];
    final String bloodGroup = Get.arguments["bloodGroup"];
    final String about = Get.arguments["about"];
    final String gender = Get.arguments["gender"];
    final File report = Get.arguments["report"];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: appSizes.getCustomPadding(
                    left: 6,
                    right: 6,
                    top: 20,
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
                  child: Center(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomTextWidget(
                              text: "Emergency\nContact Detail".toUpperCase(),
                              textColor: AppColors.yellow,
                              textAlign: TextAlign.center,
                              fontSize: 22,
                            ),
                          ),
                          const Gap(16),
                          CustomInputTextField(
                            textEditingController:
                                controller.guardianNameController,
                            hintText: "Enter guardian name",
                            isFilled: true,
                            filledColor: AppColors.white,
                          ),
                          const Gap(16),
                          CustomInputTextField(
                            textEditingController:
                                controller.relationShipController,
                            hintText: "Enter relationship",
                            isFilled: true,
                            filledColor: AppColors.white,
                          ),
                          const Gap(16),
                          CustomInputTextField(
                            textEditingController:
                                controller.guardianIdCardController,
                            hintText: "Enter Guardian ID card number",
                            isFilled: true,
                            numberKeyboard: true,
                            filledColor: AppColors.white,
                          ),
                          const Gap(16),
                          CustomInputTextField(
                            textEditingController:
                                controller.guardianPhoneController,
                            hintText: "Enter Guardian phone number",
                            isFilled: true,
                            numberKeyboard: true,
                            maxLength: 10,
                            filledColor: AppColors.white,
                          ),
                          const Gap(4),
                          CustomTextWidget(
                            text: "Gender:",
                            textColor: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          const Gap(2),
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
                                          controller.selectedGender.value =
                                              value!,
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
                                          controller.selectedGender.value =
                                              value!,
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
                                    onPress: () async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        await controller.patientDataSave(
                                          insuranceCardNumber:
                                              insuranceCardNumber,
                                          weight: weight,
                                          height: height,
                                          report: report,
                                          idCardNumber: idCardNumber,
                                          phoneNumber: phoneNumber,
                                          age: dob,
                                          bloodGroup: bloodGroup,
                                          about: about,
                                          gender: gender,
                                        );
                                      }
                                    },
                                    text: "REGISTER",
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
              ],
            ),
          ),
        );
      },
    );
  }
}
