import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
import 'package:healthcare_hub/features/doctor/profile/edit_doctor_profile/controller/edit_doctor_profile_controller.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_input_textfield.dart';

class DoctorEditProfileScreen extends StatelessWidget {
  final controller = Get.put(DoctorEditProfileController());
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
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
              labelText: "First Name",
              textCapitalization: TextCapitalization.words,
              hintText: "First Name",
              textEditingController: controller.firstNameController,
              emptyValueErrorText: "Enter first name",
              isValidator: true,
            ),
            Gap(12),
            CustomInputTextField(
              labelText: "Middle Name",
              textCapitalization: TextCapitalization.words,
              hintText: "Middle Name",
              textEditingController: controller.middleNameController,
              emptyValueErrorText: "Enter middle name",
              isValidator: false,
            ),
            Gap(12),
            CustomInputTextField(
              labelText: "Last Name",
              textCapitalization: TextCapitalization.words,
              hintText: "Last Name",
              textEditingController: controller.lastNameController,
              emptyValueErrorText: "Enter last name",
              isValidator: true,
            ),
            Gap(12),
            CustomInputTextField(
              labelText: "License Number",
              hintText: "License Number",
              textEditingController: controller.licenseNumberController,
              emptyValueErrorText: "Enter license number",
              isValidator: false,
              numberKeyboard: true,
            ),
            Gap(12),

            CustomInputTextField(
              labelText: "Experience",
              hintText: "Experience (Years)",
              textEditingController: controller.experienceController,
              emptyValueErrorText: "Enter experience",
              isValidator: false,
              numberKeyboard: true,
              // maxLength: 2,
              counterColor: AppColors.blackish,
            ),

            Gap(12),

            Obx(
              () => DropdownButtonFormField<String>(
                value:
                    controller.selectedHospital.value.isNotEmpty
                        ? controller.selectedHospital.value
                        : null,
                decoration: InputDecoration(
                  labelText: "Hospital",
                  // filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),

                  hintText: "Select Hospital",
                ),
                validator:
                    (value) => controller.validateDropdown(value, "hospital"),
                items:
                    controller.dummyHospitals
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged:
                    (value) => controller.selectedHospital.value = value ?? '',
              ),
            ),
            Gap(12),
            Obx(
              () => DropdownButtonFormField<String>(
                value:
                    controller.selectedSpecialization.value.isNotEmpty
                        ? controller.selectedSpecialization.value
                        : null,
                decoration: InputDecoration(
                  labelText: "Specialization",
                  filled: false,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Select Specialization",
                ),
                validator:
                    (value) =>
                        controller.validateDropdown(value, "specialization"),
                items:
                    controller.dummySpecializations
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged:
                    (value) =>
                        controller.selectedSpecialization.value = value ?? '',
              ),
            ),

            Gap(12),

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
                  filled: false,
                  fillColor: AppColors.white,
                  labelText: "Department",
                  hintText: "Select Department",
                ),
                validator:
                    (value) => controller.validateDropdown(value, "department"),
                items:
                    controller.dummyDepartments
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged:
                    (value) =>
                        controller.selectedDepartment.value = value ?? '',
              ),
            ),

            Gap(12),

            Obx(
              () => DropdownButtonFormField<String>(
                value:
                    controller.selectedDegree.value.isNotEmpty
                        ? controller.selectedDegree.value
                        : null,
                decoration: InputDecoration(
                  filled: false,
                  labelText: "Degree",
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Select Degree",
                ),
                items:
                    controller.dummyDegrees
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
                            onDeleted: () => controller.removeDegreeName(name),
                          ),
                        )
                        .toList(),
              ),
            ),

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
              hintText: "About",
              maxLines: 4,
              textEditingController: controller.aboutController,
              emptyValueErrorText: "About",
              isValidator: false,
            ),
            SizedBox(height: 30),
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
