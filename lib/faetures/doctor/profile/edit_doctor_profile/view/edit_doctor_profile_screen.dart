import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
import 'package:healthcare_hub/faetures/doctor/profile/edit_doctor_profile/controller/edit_doctor_profile_controller.dart';
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
              hintText: "First Name",
              textEditingController: controller.firstNameController,
              emptyValueErrorText: "Enter first name",
              isValidator: true,
            ),
            Gap(12),
            CustomInputTextField(
              hintText: "Middle Name",
              textEditingController: controller.middleNameController,
              emptyValueErrorText: "Enter middle name",
              isValidator: false,
            ),
            Gap(12),
            CustomInputTextField(
              hintText: "Last Name",
              textEditingController: controller.lastNameController,
              emptyValueErrorText: "Enter last name",
              isValidator: true,
            ),
            Gap(12),
            CustomInputTextField(
              hintText: "License Number",
              textEditingController: controller.licenseNumberController,
              emptyValueErrorText: "Enter license number",
              isValidator: false,
              numberKeyboard: true,
            ),
            Gap(12),
            CustomInputTextField(
              hintText: "Phone Number",
              textEditingController: controller.phoneNumberController,
              emptyValueErrorText: "Enter phone number",
              isValidator: false,
              numberKeyboard: true,
              maxLength: 10,
              counterColor: AppColors.blackish,
            ),
            Gap(4),
            CustomInputTextField(
              hintText: "Experience (Years)",
              textEditingController: controller.experienceController,
              emptyValueErrorText: "Enter experience",
              isValidator: false,
              numberKeyboard: true,
              maxLength: 2,
              counterColor: AppColors.blackish,
            ),
            Gap(4),
            CustomInputTextField(
              hintText: "Specialization",
              textEditingController: controller.specializationController,
              emptyValueErrorText: "Enter specialization",
              isValidator: false,
            ),
            Gap(12),
            CustomInputTextField(
              hintText: "Hospital",
              textEditingController: controller.hospitalNameController,
              emptyValueErrorText: "Enter hospital name",
              isValidator: false,
            ),
            Gap(12),
            CustomInputTextField(
              hintText: "Department",
              textEditingController: controller.departmentController,
              emptyValueErrorText: "Enter department name",
              isValidator: false,
            ),
            Gap(12),
            CustomInputTextField(
              hintText: "Address",
              textEditingController: controller.addressController,
              emptyValueErrorText: "Enter address",
              isValidator: false,
            ),
            Gap(12),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextWidget(
                text: "Degrees Name",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(controller.degreesName.length, (index) {
                  final degree = controller.degreesName[index];
                  return Chip(
                    label: CustomTextWidget(text: degree),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () => controller.removeDegree(index),
                    backgroundColor: AppColors.whitish,
                    labelStyle: GoogleFonts.poppins(color: AppColors.blue),
                    deleteIconColor: Colors.red,
                  );
                }),
              ),
            ),
            Gap(16),

            // TextField + Add Button
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomInputTextField(
                    hintText: "Add a degree",
                    textEditingController: controller.degreeTextController,
                    emptyValueErrorText: "Please enter a degree",
                    isValidator: false,
                  ),
                ),
                Gap(8),
                Expanded(
                  child: CustomElevatedButton(
                    onPress: () {
                      controller.addDegree();
                    },
                    text: "Add",
                  ),
                ),
              ],
            ),
            Gap(16),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextWidget(
                text: "Certificates:",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8),

            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(controller.degreesUrl.length, (index) {
                    final url = controller.degreesUrl[index];
                    return Chip(
                      backgroundColor: AppColors.blueish,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.picture_as_pdf, color: AppColors.white),
                          Gap(6),
                          CustomTextWidget(
                            text: '${index + 1} Certificate ',
                          ),
                        ],
                      ),
                      deleteIcon: Icon(Icons.close, color: AppColors.white),
                      onDeleted: () => controller.removeCertificate(index),
                    );
                  }),
                ),
                Gap(12),
                CustomElevatedButton(
                    backgroundColor: AppColors.blueish,
                    onPress: () {

                  controller.pickAndAddCertificate();
                }, text: "Upload Certificate"),
              ],
            )),
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                      () => Radio(
                    value: 'Male',
                    activeColor: AppColors.blue,
                    groupValue: controller.gender.value,
                    onChanged:
                        (value) =>
                    controller.gender.value = value!,
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
                    onChanged:
                        (value) =>
                    controller.gender.value = value!,
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
             () =>  CustomElevatedButton(
                 isLoading:controller.isLoading.value,
                 text: "Update Now", onPress: () async{
                await controller.updateProfile();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
