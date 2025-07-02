import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../../../../../core/widgets/custom_outline_button.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../controller/other_info_controller.dart';

class DrOtherInfoScreen extends StatelessWidget {
  DrOtherInfoScreen({super.key});

  final DrOtherInfoController controller = Get.find<DrOtherInfoController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    final String license = Get.arguments["license"];
    final String phoneNumber = Get.arguments["phoneNumber"];
    final String experience = Get.arguments["experience"];
    final String about = Get.arguments["about"];
    final String gender = Get.arguments["gender"];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: appSizes.getCustomPadding(
                    left: 6,
                    right: 6,
                    top: 14,
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
                    child: Column(
                      children: [
                        CustomTextWidget(
                          text: "OTHER INFORMATION",
                          textColor: AppColors.yellow,
                          fontSize: 22,
                        ),
                        const Gap(16),
                        CustomInputTextField(
                          hintText: "Enter hospital name",
                          textEditingController: controller.hospitalNameController,
                          isFilled: true,
                          filledColor: AppColors.white,
                        ),
                        Gap(12),
                        CustomInputTextField(
                          hintText: "Enter dept. name",
                          textEditingController: controller.departmentController,
                          isFilled: true,
                          filledColor: AppColors.white,
                        ),
                        Gap(12),
                        CustomInputTextField(
                          hintText: "Enter specialization",
                          textEditingController: controller.specializationController,
                          isFilled: true,
                          filledColor: AppColors.white,
                        ),
                        Gap(12),
                        CustomInputTextField(
                          hintText: "Enter your address",
                          textEditingController: controller.addressController,
                          isFilled: true,
                          filledColor: AppColors.white,
                        ),
                        const Gap(12),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children:
                                controller.degreesNameList.map((name) {
                                  return Chip(
                                    label: CustomTextWidget(
                                      text: name,
                                      textColor: AppColors.white,
                                    ),
                                    backgroundColor: AppColors.blue,
                                    deleteIcon: Icon(
                                      Icons.close,
                                      color: AppColors.white,
                                    ),
                                    onDeleted:
                                        () => controller.removeDegreeName(name),
                                  );
                                }).toList(),
                          ),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: CustomInputTextField(
                                textEditingController:
                                    controller.degreesNameTextController,
                                hintText: "Enter degree name",
                                isFilled: true,
                                filledColor: AppColors.white,
                              ),
                            ),
                            Gap(8),
                            CustomElevatedButton(
                              width: 80,
                              backgroundColor: AppColors.white,
                              textColor: AppColors.blue,
                              onPress: controller.addDegreeName,
                              text: "Add",
                            ),
                          ],
                        ),
                        Divider(height: 50),
                        CustomElevatedButton(
                          onPress: controller.addDocument,
                          text: "Pick File",
                          backgroundColor: AppColors.white,
                          textColor: AppColors.blue,
                        ),
                        Gap(12),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children:
                                controller.documentList.map((file) {
                                  return Chip(
                                    label: CustomTextWidget(
                                      text: path.basename(file.name),
                                      textColor: AppColors.white,
                                    ),
                                    deleteIcon: Icon(
                                      Icons.close,
                                      color: AppColors.white,
                                    ),
                                    backgroundColor: AppColors.blue,
                                    onDeleted:
                                        () => controller.removeDocument(file),
                                  );
                                }).toList(),
                          ),
                        ),
                        Gap(23),
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
                            Gap(10),
                            Expanded(
                              child: Obx(
                                () => CustomElevatedButton(
                                  backgroundColor: AppColors.yellow,
                                  isLoading: controller.isLoading.value,
                                  textColor: AppColors.blue,
                                  onPress: () async {
                                    await controller.doctorRegistration(
                                      phoneNumber: phoneNumber,
                                      experience: experience,
                                      about: about,
                                      gender: gender,
                                      license: license
                                    );
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
              ],
            ),
          ),
        );
      },
    );
  }
}
