import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
import 'package:healthcare_hub/features/patient/profile/edit_patient_profile/view/widgets/heightdropdown.dart';
import 'package:healthcare_hub/features/patient/profile/edit_patient_profile/view/widgets/weightdropdown.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';
import '../controller/edit_patient_profile_controller.dart';

class PatientEditProfileScreen extends StatelessWidget {
  final controller = Get.put(PatientEditProfileController());
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile", goBack: true),
      body: SingleChildScrollView(
        padding: appSizes.getCustomPadding(),
        child: Column(
          children: [
            Obx(() {
              final file = controller.imagePicker.selectedImage.value;
              final imageUrl = controller.imageUrl.value;
              ImageProvider imageProvider;
              if (file != null) {
                imageProvider = FileImage(file);
              } else if (imageUrl.isNotEmpty) {
                imageProvider = NetworkImage(imageUrl);
              } else {
                imageProvider = AssetImage(AppImages.maleDr);
              }
              return GestureDetector(
                onTap: () {
                  controller.imagePicker.showImagePickerDialog();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: imageProvider,
                ),
              );
            }),

            Gap(18),
            CustomInputTextField(
              textCapitalization: TextCapitalization.words,
              labelText: "First Name",
              hintText: "First Name",
              textEditingController: controller.firstNameController,
              emptyValueErrorText: "Enter first name",
              isValidator: true,
            ),
            Gap(12),
            CustomInputTextField(
              textCapitalization: TextCapitalization.words,
              labelText: "Middle name",
              hintText: "Middle Name",
              textEditingController: controller.middleNameController,
              emptyValueErrorText: "Enter middle name",
              isValidator: false,
            ),
            Gap(12),
            CustomInputTextField(
              textCapitalization: TextCapitalization.words,
              labelText: "Last Name",
              hintText: "Last Name",
              textEditingController: controller.lastNameController,
              emptyValueErrorText: "Enter last name",
              isValidator: true,
            ),
            Gap(12),
            Column(
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
                      labelText: "Date of Birth",
                      textEditingController: controller.ageController,
                      hintText: "Select your date of birth",
                      isValidator: true,
                      numberKeyboard: false,
                      filledColor: AppColors.white,
                      emptyValueErrorText: "Please select your date of birth",
                    ),
                  ),
                ),
                const Gap(16),
                CustomInputTextField(
                  labelText: "Id Card Number",
                  textEditingController: controller.idCardController,
                  hintText: "Enter ID card number",
                  isValidator: true,
                  numberKeyboard: true,
                  filledColor: AppColors.white,
                  emptyValueErrorText: "Please enter your ID Card number",
                ),
              ],
            ),
            Gap(12),
            CustomInputTextField(
              labelText: "Insurance Card Number",
              textEditingController: controller.insuranceCardController,
              hintText: "Enter insurance card number",
              isValidator: true,
              numberKeyboard: true,
              filledColor: AppColors.white,
              emptyValueErrorText: "Please enter your insurance card number",
            ),
            Gap(12),

            HeightInputDropdown(),
            Gap(12),

            WeightInputDropdown(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => Radio(
                    value: 'Male',
                    activeColor: AppColors.blue,
                    groupValue: controller.gender.value,
                    onChanged: (value) => controller.gender.value = value!,
                  ),
                ),
                const CustomTextWidget(
                  textAlign: TextAlign.start,
                  text: 'Male',
                  textColor: AppColors.blue,
                ),
                const Gap(16),
                Obx(
                  () => Radio(
                    value: 'Female',
                    activeColor: AppColors.blue,
                    groupValue: controller.gender.value,
                    onChanged: (value) => controller.gender.value = value!,
                  ),
                ),
                const CustomTextWidget(
                  textAlign: TextAlign.start,
                  text: 'Female',
                  textColor: AppColors.blue,
                ),
              ],
            ),
            Gap(12),
            CustomInputTextField(
              textCapitalization: TextCapitalization.sentences,
              labelText: "About",
              hintText: "About",
              maxLines: 4,
              textEditingController: controller.aboutController,
              emptyValueErrorText: "About",
              isValidator: false,
            ),

            Gap(26),

            Obx(
              () => CustomElevatedButton(
                isLoading: controller.isLoading.value,
                text: "Update Now",
                onPress: () async {
                  await controller.updateProfile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
