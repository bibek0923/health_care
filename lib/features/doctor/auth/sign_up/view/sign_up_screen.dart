import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
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
                        text: "DOCTOR REGISTRATION",
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
                        textCapitalization: TextCapitalization.words,
                        textEditingController: controller.firstNameController,
                        hintText: "First name",
                        isFilled: true,
                        filledColor: AppColors.white,
                        isValidator: true,
                        emptyValueErrorText: "Please enter first name",
                        validator: controller.validateFirstName,
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textCapitalization: TextCapitalization.words,
                        textEditingController: controller.middleNameController,
                        hintText: "Middle name",
                        isFilled: true,
                        isValidator: false,
                        filledColor: AppColors.white,
                        validator: controller.validateMiddleName,
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textCapitalization: TextCapitalization.words,
                        textEditingController: controller.lastNameController,
                        hintText: "Last name",
                        isFilled: true,
                        filledColor: AppColors.white,
                        
                        isValidator: true,
                        emptyValueErrorText: "Please enter last name",
                        validator: controller.validateLastName,
                      ),
                      const Gap(16),
                      CustomInputTextField(
                        textEditingController: controller.emailController,
                        hintText: "Enter email",
                        isValidator: true,
                        isFilled: true,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your email",
                        validator: controller.validateEmail,
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
                        validator: controller.validatePassword,
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
                        validator:
                            (value) => controller.validateConfirmPassword(
                              value,
                              controller.createPasswordController.text,
                            ),
                      ),
                      const Gap(24),
                      CustomTextWidget(
                        text: "PERSONAL INFORMATION",
                        textColor: AppColors.yellow,
                        fontSize: 22,
                      ),
                      const Gap(16),

                      /// License Number
                      CustomInputTextField(
                        validator: controller.validateLicense,
                        textEditingController: controller.licenseController,
                        hintText: "Enter License number",
                        isValidator: true,
                        isFilled: true,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter your License number",
                      ),

                      const Gap(16),

                      /// Experience
                      CustomInputTextField(
                        validator: controller.validateExperience,
                        textEditingController: controller.experienceController,
                        hintText: "Enter experience (Years)",
                        isValidator: true,
                        isFilled: true,
                        numberKeyboard: true,
                        filledColor: AppColors.white,
                        // maxLength: 4,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        emptyValueErrorText: "Please enter your experience",
                      ),

                      const Gap(16),

                      /// About (Optional)
                      CustomInputTextField(
                        textCapitalization: TextCapitalization.sentences,
                        validator: controller.validateAbout,
                        textEditingController: controller.aboutController,
                        hintText: "About (Optional)",
                        isValidator: true,
                        isFilled: true,
                        maxLines: 4,
                        filledColor: AppColors.white,
                      ),

                      const Gap(16),

                      /// Gender
                      Row(
                        children: [
                          Obx(
                            () => Radio(
                              value: 'Male',
                              groupValue: controller.selectedGender.value,
                              onChanged:
                                  (value) =>
                                      controller.selectedGender.value = value!,
                              activeColor: AppColors.white,
                            ),
                          ),
                          const CustomTextWidget(
                            text: 'Male',
                            textColor: AppColors.white,
                          ),
                          const Gap(12),
                          Obx(
                            () => Radio(
                              value: 'Female',
                              groupValue: controller.selectedGender.value,
                              onChanged:
                                  (value) =>
                                      controller.selectedGender.value = value!,
                              activeColor: AppColors.white,
                            ),
                          ),
                          const CustomTextWidget(
                            text: 'Female',
                            textColor: AppColors.white,
                          ),
                        ],
                      ),

                      const Gap(24),
                      CustomTextWidget(
                        text: "OTHER INFORMATION",
                        textColor: AppColors.yellow,
                        fontSize: 22,
                      ),

                      const Gap(16),

                      /// Hospital Dropdown
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value:
                              controller.selectedHospital.value.isNotEmpty
                                  ? controller.selectedHospital.value
                                  : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),

                            hintText: "Select Hospital",
                          ),
                          validator:
                              (value) => controller.validateDropdown(
                                value,
                                "hospital",
                              ),
                          items:
                              controller.dummyHospitals
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (value) =>
                                  controller.selectedHospital.value =
                                      value ?? '',
                        ),
                      ),

                      const Gap(12),

                      Obx(
                        () => DropdownButtonFormField<String>(
                          value:
                              controller.selectedDepartment.value.isNotEmpty
                                  ? controller.selectedDepartment.value
                                  : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            filled: true,
                            fillColor: AppColors.white,

                            hintText: "Select Department",
                          ),
                          validator:
                              (value) => controller.validateDropdown(
                                value,
                                "department",
                              ),
                          items:
                              controller.dummyDepartments
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (value) =>
                                  controller.selectedDepartment.value =
                                      value ?? '',
                        ),
                      ),

                      const Gap(12),

                      /// Specialization Dropdown
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value:
                              controller.selectedSpecialization.value.isNotEmpty
                                  ? controller.selectedSpecialization.value
                                  : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: "Select Specialization",
                          
                          ),
                          validator:
                              (value) => controller.validateDropdown(
                                value,
                                "specialization",
                              ),
                          items:
                              controller.dummySpecializations
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (value) =>
                                  controller.selectedSpecialization.value =
                                      value ?? '',
                        ),
                      ),

                      const Gap(12),

                      /// Degree Dropdown
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value:
                              controller.selectedDegree.value.isNotEmpty
                                  ? controller.selectedDegree.value
                                  : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            hintText: "Select Degree",
                          ),
                          items:
                              controller.dummyDegrees
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            controller.selectedDegree.value = value ?? '';
                            if (value != null && value.isNotEmpty) {
                              controller.degreesNameList.add(value);
                              controller.selectedDegree.value = '';
                            }
                          },
                        ),
                      ),

                      const Gap(12),

                      /// Degrees Chips
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children:
                              controller.degreesNameList
                                  .map(
                                    (name) => Chip(
                                      label: Text(name),
                                      backgroundColor: AppColors.white,
                                      deleteIcon: Icon(Icons.close),
                                      onDeleted:
                                          () =>
                                              controller.removeDegreeName(name),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),

                      const Gap(32),

                      // const Gap(22),
                      Obx(
                        () => CustomElevatedButton(
                          isLoading: controller.isLoading.value,
                          backgroundColor: AppColors.yellow,
                          textColor: AppColors.blue,
                          onPress: () async {
                            if (controller.formKey.currentState!.validate()) {
                              print(
                                "firstname${controller.firstNameController.text}",
                              );
                              print("email ${controller.emailController.text}");
                              print(
                                "password${controller.createPasswordController.text}",
                              );
                              print("gender ${controller.selectedGender}");
                              print(
                                "license${controller.licenseController.text}",
                              );
                              print(
                                "exp${controller.experienceController.text}",
                              );
                              print("about ${controller.aboutController.text}");
                              print(
                                "hospital${controller.selectedHospital.value}",
                              );
                              print(
                                "specialization${controller.selectedSpecialization.value}",
                              );
                              print(
                                "department${controller.selectedDepartment.value}",
                              );
                              // print("selected degree${controller.selectedDegree.value}");
                              print(
                                "length of degree list${controller.degreesNameList[0]}",
                              );
                              print(
                                "length of degree list${controller.degreesNameList[1]}",
                              );
                              // print("length of degree list${controller.degreesNameList[2].length}");

                              await controller.doctorRegistration();
                                // controller.refreshField();
                            } else {
                              controller.toast.showCustomToast(
                                "Please fill correct values in each fields",
                              );
                            }
                          },
                          text: "REGISTER",
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
