import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/faetures/patient/auth/sign_up/view/widgets/heightinputdropdown.dart';
import 'package:healthcare_hub/faetures/patient/auth/sign_up/view/widgets/weightinputdropdown.dart';
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/Const/app_images.dart';
import '../../../../../core/app_routes/routes.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.find<SignUpController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
      if (!controller.isInitialized1.value) {
    controller.refreshField();
    controller.isInitialized1.value = true;
  }
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
                      const Gap(32),

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
                        filledColor: AppColors.white,
                        isValidator: true,
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
                        hintText: "Enter Email",
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
                        hintText: "Create your Password",
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
                        hintText: "Confirm your Password",
                        hasSuffixIcon: true,
                        isObsecure: true,
                        isFilled: true,
                        filledColor: AppColors.white,
                        isValidator: true,
                        emptyValueErrorText: "Please enter confirm password",
                        validator: (value) {
                          return controller.validateConfirmPassword(
                            value,
                            controller.createPasswordController.text,
                          );
                        },
                      ),
                      const Gap(22),
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
                                numberKeyboard: false,
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
                        
                        numberKeyboard: false,
                        filledColor: AppColors.white,
                        validator: controller.validateInsuranceCard,
                        // emptyValueErrorText: "Please enter your insurance card",
                      ),
                      Gap(16),

                      // TextFormField(

                      //   decoration: InputDecoration(
                      //     hintText: "Enter Your Height",
                      //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                      //   fillColor: AppColors.white,
                      //   filled: true,

                      //     suffixIcon: GestureDetector(child: DropdownButton(value:controller.selectedHeightUnit.value,items: ["ft","in"].map((item){
                      //       return DropdownMenuItem(child: Text(item));
                      //     }).toList(), onChanged: (value){}) , onTap: (){},),
                      //   ),

                      // ),
                      // CustomInputTextField(hintText: "hi", textEditingController: controller.aboutController,isFilled: true, hasSuffixIcon: true,),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(Radius.circular(13)),
                      //     border: Border.all(
                      //       color: Colors.black,
                      //       style: BorderStyle.solid,
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Expanded(
                      //         // flex: 1,
                      //         child: TextFormField(

                      //           autofocus: false,
                      //           decoration: InputDecoration(
                      //             hintText: "enter height",
                      //             border: InputBorder.none,
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(width: 12),

                      //       Obx(
                      //         () => DropdownButtonFormField<String>(
                      //           iconSize: 24,
                      //           // padding: EdgeInsets.all(0),
                      //           // padding: EdgeInsets.all(0),
                      //           elevation: 2,
                      //           // itemHeight: 10,
                      //           value:
                      //               controller
                      //                       .selectedHeightUnit
                      //                       .value
                      //                       .isEmpty
                      //                   ? null
                      //                   : controller.selectedHeightUnit.value,
                      //           items:
                      //               ["ft", "in"].map((unit) {
                      //                 return DropdownMenuItem(
                      //                   value: unit,
                      //                   child: Text(
                      //                     unit,
                      //                     style: TextStyle(fontSize: 15),
                      //                   ),
                      //                 );
                      //               }).toList(),

                      //           decoration: InputDecoration(
                      //             // contentPadding: EdgeInsets.all(0),
                      //             // filled: true,
                      //             fillColor: AppColors.white,
                      //             border: OutlineInputBorder(
                      //               borderSide: BorderSide.none,
                      //               borderRadius: BorderRadius.circular(13),
                      //             ),
                      //           ),
                      //           onChanged: (val) {
                      //             controller.selectedHeightUnit.value = val!;
                      //           },
                      //         ),
                      //       ),

                      //     ],
                      //   ),
                      // ),
                      //seperate height and weight waala
                      // Gap(10),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 2,
                      //       child: CustomInputTextField(
                      //         textEditingController:
                      //             controller.heightController,
                      //         hintText: "Enter height",
                      //         isValidator: true,
                      //         isFilled: true,
                      //         numberKeyboard: true,
                      //         filledColor: AppColors.white,
                      //         emptyValueErrorText: "Please enter your height",
                      //       ),
                      //     ),
                      //     const Gap(8),
                      //     Expanded(
                      //       flex: 1,
                      //       child: Obx(
                      //         () => DropdownButtonFormField<String>(
                      //           padding: EdgeInsets.all(0),
                      //           elevation: 2,
                      //           // itemHeight: 10,
                      //           value:
                      //               controller.selectedHeightUnit.value.isEmpty
                      //                   ? null
                      //                   : controller.selectedHeightUnit.value,
                      //           items:
                      //               ["ft", "in", "cm"].map((unit) {
                      //                 return DropdownMenuItem(
                      //                   value: unit,
                      //                   child: Text(
                      //                     unit,
                      //                     style: TextStyle(fontSize: 15),
                      //                   ),
                      //                 );
                      //               }).toList(),
                      //           decoration: InputDecoration(
                      //             filled: true,
                      //             fillColor: AppColors.white,
                      //             border: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(13),
                      //             ),
                      //           ),
                      //           onChanged: (val) {
                      //             controller.selectedHeightUnit.value = val!;
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Gap(16),

                      // HeightInputWidget() ,
                      HeightDropdown(),
                      Gap(10),
                      // CustomInputTextField(
                      //   textEditingController: controller.heightController,
                      //   hintText: "Enter your Height (Feet)",
                      //   isValidator: true,
                      //   isFilled: true,
                      //   maxLength: 2,
                      //   numberKeyboard: true,
                      //   filledColor: AppColors.white,
                      //   emptyValueErrorText: "Please enter your height",
                      // ),
                      const Gap(4),
                      // CustomInputTextField(
                      //   textEditingController: controller.weightController,
                      //   hintText: "Enter your Weight (KG)",
                      //   isValidator: true,
                      //   isFilled: true,
                      //   numberKeyboard: true,
                      //   maxLength: 3,
                      //   filledColor: AppColors.white,
                      //   emptyValueErrorText: "Please enter your weight",
                      // ),
                      WeightDropdown(),
                      // const Gap(4),
                      const Gap(16),
                      CustomInputTextField(
                         textCapitalization: TextCapitalization.sentences,
                        validator: controller.validateAbout,
                        textEditingController: controller.aboutController,
                        hintText: "About",
                        isValidator: true,
                        isFilled: true,
                        maxLines: 4,
                        filledColor: AppColors.white,
                        emptyValueErrorText: "Please enter about you",
                      ),
                      Gap(16),
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

                      Obx(
                        () => CustomElevatedButton(
                          isLoading: controller.isLoading.value,
                          backgroundColor: AppColors.yellow,
                          textColor: AppColors.blue,
                          onPress: () async {
                            if (controller.formKey.currentState!.validate()) {
                              // if(controller.errorText.isEmpty){
                              //   controller.toast.showCustomToast("Please enter valid height");
                              // }
                              if (controller.createPasswordController.text ==
                                  controller.confirmPasswordController.text) {
                                await controller.patientRegistration();
                              }
                              // else {
                              //   controller.toast.showCustomToast(
                              //     "Passwords mismatch",
                              //   );
                              // }
                            } else {
                              controller.toast.showCustomToast(
                                "Please fill all fields ",
                              );
                            }
                          },
                          text: "Register",
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
                              Get.offAllNamed(AppRoutes.SIGNINSCREEN);
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
