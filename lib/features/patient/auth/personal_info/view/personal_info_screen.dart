import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../../core/widgets/custom_dropdown.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../controller/personal_info_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final PersonalInfoController controller = Get.find<PersonalInfoController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: appSizes.getCustomPadding(
                left: 3,
                right: 3,
                top: 6,
                bottom: 6,
              ),
              width: appSizes.getWidthPercentage(100),
              padding: appSizes.getCustomPadding(right: 3, left: 3),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black,
                    spreadRadius: -1,
                    blurRadius: 10,
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
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now().subtract(
                                    const Duration(days: 365 * 18),
                                  ),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null) {
                                  controller.setBirthDate(pickedDate);
                                }
                              },
                              child: AbsorbPointer(
                                child: CustomInputTextField(
                                  
                                  textEditingController:
                                      controller.dobController,
                                  hintText: "Select your date of birth",
                                  isValidator: true,
                                  isFilled: true,
                                  numberKeyboard: false,
                                  filledColor: AppColors.white,
                                  emptyValueErrorText:
                                      "Please select your date of birth",
                                ),
                              ),
                            ),
                            const Gap(16),
                            if (controller.isAbove18.value)
                              CustomInputTextField(
                                textEditingController:
                                    controller.idCardController,
                                hintText: "Enter ID card number",
                                isValidator: true,
                                isFilled: true,
                                numberKeyboard: true,
                                filledColor: AppColors.white,
                                emptyValueErrorText:
                                    "Please enter your ID Card number",
                              ),
                            if (controller.isAbove18.value) Gap(16),
                          ],
                        ),
                      ),

                      CustomInputTextField(
                        textEditingController:
                            controller.insuranceCardController,
                        hintText: "Enter insurance card ",
                        isValidator: true,
                        isFilled: true,
                        numberKeyboard: true,
                        filledColor: AppColors.white,
                        validator: controller.validateInsuranceCard,
                        // emptyValueErrorText: "Please enter your insurance card",
                      ),
                      Gap(16),
                      // CustomInputTextField(
                      //   textEditingController: controller.phoneNumberController,
                      //   hintText: "Enter phone number",
                      //   isValidator: true,
                      //   isFilled: true,
                      //   numberKeyboard: true,
                      //   maxLength: 10,
                      //   filledColor: AppColors.white,
                      //   emptyValueErrorText: "Please enter your phone number",
                      // ),
                      const Gap(4),
                      // Obx(
                      //   () => CustomDropdown(
                      //     items: controller.bloodGroups,
                      //     selectedValue: controller.selectedBloodGroup.value,
                      //     haveBorders: true,
                      //     onChanged: (selectedValue) {
                      //       controller.updateBloodGroup(selectedValue!);
                      //     },
                      //     hintText: "Your blood group",
                      //   ),
                      // ),
                      // const Gap(16),
                      CustomInputTextField(
                        textEditingController: controller.heightController,
                        hintText: "Enter your Height (Feet)",
                        isValidator: true,
                        isFilled: true,
                        maxLength: 2,
                        numberKeyboard: true,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your height",
                      ),
                      const Gap(4),
                      CustomInputTextField(
                        textEditingController: controller.weightController,
                        hintText: "Enter your Weight (KG)",
                        isValidator: true,
                        isFilled: true,
                        numberKeyboard: true,
                        maxLength: 3,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your weight",
                      ),
                      const Gap(4),
                      CustomInputTextField(
                        textEditingController: controller.aboutController,
                        hintText: "About",
                        isValidator: false,
                        isFilled: true,
                        maxLines: 4,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter about you",
                      ),
                      // Gap(16),
                      // CustomOutlineButton(
                      //   onPress: controller.pickPDF,
                      //   borderColor: AppColors.white,
                      //   text: "Select Reports",
                      //   textColor: AppColors.white,
                      // ),
                      // Gap(18),
                      // Obx(() {
                      //   final pdfFile = controller.pickedPDF.value;
                      //   if (pdfFile != null) {
                      //     return Container(
                      //       padding: EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //         color: AppColors.whitish2,
                      //         borderRadius: BorderRadius.circular(12),
                      //         border: Border.all(color: AppColors.whitish),
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.picture_as_pdf,
                      //             color: AppColors.red,
                      //             size: 32,
                      //           ),
                      //           Gap(4),
                      //           Expanded(
                      //             child: CustomTextWidget(
                      //               text: pdfFile.path.split('/').last,
                      //               textColor: AppColors.white,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   } else {
                      //     return CustomTextWidget(
                      //       text: "No Report selected",
                      //       textColor: AppColors.white,
                      //     );
                      //   }
                      // }),
                      // const Gap(16),
                      const Gap(4),
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
                                     
                                      Get.toNamed(
                                        AppRoutes.GUARDIANINFOSCREEN,
                                        arguments: {
                                          "idCardNumber":
                                              controller.idCardController.text
                                                  .trim(),
                                          "insuranceCardNumber":
                                              controller
                                                  .insuranceCardController
                                                  .text
                                                  .trim(),
                                          "phoneNumber":
                                              controller
                                                  .phoneNumberController
                                                  .text
                                                  .trim(),
                                          "dob":
                                              controller.dobController.text
                                                  .trim(),
                                          // "bloodGroup":
                                          //     controller
                                          //         .selectedBloodGroup
                                          //         .value,
                                          "about":
                                              controller.aboutController.text
                                                  .trim(),
                                          "gender":
                                              controller.selectedGender.value,
                                          // "report": controller.pickedPDF.value,
                                          "height":
                                              controller.heightController.text
                                                  .trim(),
                                          "weight":
                                              controller.weightController.text
                                                  .trim(),
                                        },
                                      );
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
