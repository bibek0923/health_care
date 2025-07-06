// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
// import '../../../../../core/Const/app_colors.dart';
// import '../../../../../core/app_routes/routes.dart';
// import '../../../../../core/utils/app_sizes.dart';
// import '../../../../../core/widgets/custom_elevated_button.dart';
// import '../../../../../core/widgets/custom_input_textfield.dart';
// import '../../../../../core/widgets/custom_text_widget.dart';
// import '../controller/personal_info_controller.dart';

// class DrPersonalInfoScreen extends StatelessWidget {
//   DrPersonalInfoScreen({super.key});

//   final DrPersonalInfoController controller = Get.find<DrPersonalInfoController>();
//   final AppSizes appSizes = AppSizes();

//   @override
//   Widget build(BuildContext context) {
//   //   void _showExperiencePicker(BuildContext context) {
//   // final List<String> years = List.generate(51, (index) => index.toString());

//   // // showModalBottomSheet(
//   //   context: context,
//   //   backgroundColor: Colors.white,
//   //   builder: (_) {
//   //     return Container(
//   //       height: 250,
//   //       child: Column(
//   //         children: [
//   //           SizedBox(
//   //             height: 40,
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.end,
//   //               children: [
//   //                 CupertinoButton(
//   //                   child: Text("Done",style: TextStyle(fontSize: 20),),
//   //                   onPressed: () {
//   //                     Navigator.pop(context);
//   //                   },
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           Expanded(
//   //             child: CupertinoPicker(
//   //               backgroundColor: Colors.white,
//   //               itemExtent: 40,
//   //               scrollController: FixedExtentScrollController(
//   //                 initialItem: int.tryParse(controller.experienceController.text) ?? 0,
//   //               ),
//   //               onSelectedItemChanged: (index) {
//   //                 controller.experienceController.text = years[index];
//   //               },
//   //               children: years.map((e) => Center(child: Text(e))).toList(),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     );
//   //   },
//   // );


//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scaffold(
//           body: Center(
//             child: Container(
//               margin: appSizes.getCustomPadding(
//                 left: 6,
//                 right: 6,
//                 top: 8,
//                 bottom: 6,
//               ),
//               width: appSizes.getWidthPercentage(100),
//               padding: appSizes.getCustomPadding(right: 6, left: 6),
//               decoration: BoxDecoration(
//                 color: AppColors.blue,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.black,
//                     spreadRadius: -1,
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Form(
//                 key: controller.formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomTextWidget(
//                         text: "PERSONAL INFORMATION",
//                         textColor: AppColors.yellow,
//                         fontSize: 22,
//                       ),
//                       const Gap(16),
//                       CustomInputTextField(
//                         validator: controller.validateLicense,
//                         textEditingController: controller.licenseController,
//                         hintText: "Enter License number",
//                         isValidator: true,
//                         isFilled: true,
//                         numberKeyboard: false,
                        
//                         filledColor: AppColors.white,
//                         emptyValueErrorText: "Please enter your License number",
//                       ),
//                       const Gap(16),
//                       // CustomInputTextField(
//                       //   textEditingController: controller.phoneNumberController,
//                       //   hintText: "Enter phone number",
//                       //   isValidator: true,
//                       //   isFilled: true,
//                       //   maxLength: 10,
//                       //   numberKeyboard: true,
//                       //   filledColor: AppColors.white,
//                       //   emptyValueErrorText: "Please enter your phone number",
//                       // ),
//                       // const Gap(4),
//                       // CustomInputTextField(
//                       //   textEditingController: controller.experienceController,
//                       //   hintText: "Enter experience (Years)",
//                       //   isValidator: true,
//                       //   isFilled: true,
//                       //   numberKeyboard: true,
//                       //   filledColor: AppColors.white,
//                       //   emptyValueErrorText: "Please enter your experience",
//                       //   maxLength: 2,
//                       // ),
// //                       GestureDetector(
// //   onTap: () => _showExperiencePicker(context),
// //   child: AbsorbPointer(
// //     child: CustomInputTextField(
// //       textEditingController: controller.experienceController,
// //       hintText: "Enter experience (Years)",
// //       isValidator: true,
// //       isFilled: true,
// //       numberKeyboard: false,
// //       filledColor: AppColors.white,
// //       emptyValueErrorText: "Please enter your experience",
// //     ),
// //   ),
// // ),

//   CustomInputTextField(
//                         textEditingController: controller.experienceController,
//                         hintText: "Enter experience (Years)",
//                         isValidator: true,
//                         isFilled: true,
//                         numberKeyboard: true,
//                         filledColor: AppColors.white,
//                         emptyValueErrorText: "Please enter your experience",
//                         maxLength: 3,
//                       ),



//                       const Gap(4),
//                       CustomInputTextField(
//                         textEditingController: controller.aboutController,
//                         hintText: "About",
//                         isValidator: false,
//                         isFilled: true,
//                         maxLines: 4,
//                         filledColor: AppColors.white,
//                         emptyValueErrorText: "Please enter about you",
//                       ),
//                       const Gap(16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Obx(
//                             () => Radio(
//                               value: 'Male',
//                               activeColor: AppColors.white,
//                               groupValue: controller.selectedGender.value,
//                               onChanged:
//                                   (value) =>
//                                       controller.selectedGender.value = value!,
//                             ),
//                           ),
//                           const CustomTextWidget(
//                             textAlign: TextAlign.start,
//                             text: 'Male',
//                             textColor: AppColors.white,
//                           ),
//                           const Gap(16),
//                           Obx(
//                             () => Radio(
//                               value: 'Female',
//                               activeColor: AppColors.white,
//                               groupValue: controller.selectedGender.value,
//                               onChanged:
//                                   (value) =>
//                                       controller.selectedGender.value = value!,
//                             ),
//                           ),
//                           const CustomTextWidget(
//                             textAlign: TextAlign.start,
//                             text: 'Female',
//                             textColor: AppColors.white,
//                           ),
//                         ],
//                       ),
//  CustomTextWidget(
//                           text: "OTHER INFORMATION",
//                           textColor: AppColors.yellow,
//                           fontSize: 22,
//                         ),
//                         const Gap(16),
//                         CustomInputTextField(
//                           hintText: "Enter hospital name",
//                           textEditingController: controller.hospitalNameController,
//                           isFilled: true,
//                           filledColor: AppColors.white,
//                         ),
//                         Gap(12),
//                         CustomInputTextField(
//                           hintText: "Enter dept. name",
//                           textEditingController: controller.departmentController,
//                           isFilled: true,
//                           filledColor: AppColors.white,
//                         ),
//                         Gap(12),
//                         CustomInputTextField(
//                           hintText: "Enter specialization",
//                           textEditingController: controller.specializationController,
//                           isFilled: true,
//                           filledColor: AppColors.white,
//                         ),
//                         Gap(12),
//                         // CustomInputTextField(
//                         //   hintText: "Enter your address",
//                         //   textEditingController: controller.addressController,
//                         //   isFilled: true,
//                         //   filledColor: AppColors.white,
//                         // ),
//                         // const Gap(12),
//                         // const Gap(12),
//                         Obx(
//                           () => Wrap(
//                             spacing: 8,
//                             children:
//                                 controller.degreesNameList.map((name) {
//                                   return Chip(
//                                     label: CustomTextWidget(
//                                       text: name,
//                                       textColor: AppColors.white,
//                                     ),
//                                     backgroundColor: AppColors.blue,
//                                     deleteIcon: Icon(
//                                       Icons.close,
//                                       color: AppColors.white,
//                                     ),
//                                     onDeleted:
//                                         () => controller.removeDegreeName(name),
//                                   );
//                                 }).toList(),
//                           ),
//                         ),
//                         Gap(4),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: CustomInputTextField(
//                                 textEditingController:
//                                     controller.degreesNameTextController,
//                                 hintText: "Enter degree name",
//                                 isFilled: true,
//                                 filledColor: AppColors.white,
//                               ),
//                             ),
//                             Gap(8),
//                             CustomElevatedButton(
//                               width: 80,
//                               backgroundColor: AppColors.white,
//                               textColor: AppColors.blue,
//                               onPress: controller.addDegreeName,
//                               text: "Add",
//                             ),
//                           ],
//                         ),
//                       const Gap(32),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomOutlineButton(
//                               borderColor: AppColors.white,
//                               textColor: AppColors.white,
//                               onPress: () {
//                                 Get.back();
//                               },
//                               text: "BACK",
//                             ),
//                           ),
//                           Gap(8),

//                           // Expanded(
//                           //   child: Obx(
//                           //     () => CustomElevatedButton(
//                           //       isLoading: controller.isLoading.value,
//                           //       backgroundColor: AppColors.yellow,
//                           //       textColor: AppColors.blue,
//                           //       onPress: () {
//                           //         if (controller.formKey.currentState!
//                           //             .validate()) {
//                           //           Get.toNamed(AppRoutes.DROTHERINFOSCREEN,arguments: {
//                           //             "license":controller.licenseController.text.trim(),
//                           //           // "phoneNumber":controller.phoneNumberController.text.trim(),
//                           //           "experience":controller.experienceController.text.trim(),
//                           //           "about":controller.aboutController.text.trim(),
//                           //           "gender":controller.selectedGender.value,
//                           //           });
//                           //           controller.refreshField();
//                           //         }
//                           //       },
//                           //       text: "NEXT",
//                           //     ),
//                           //   ),
//                           // ),
//                           Expanded(
//                             child: Obx(
//                               () => CustomElevatedButton(
//                                 isLoading: controller.isLoading.value,
//                                 backgroundColor: AppColors.yellow,
//                                 textColor: AppColors.blue,
//                                 onPress: () async{
//                                   if (controller.formKey.currentState!
//                                       .validate()) {
//                                   await controller.doctorRegistration();
//                                                                      controller.refreshField();
//                                   }
//                                 },
//                                 text: "Register",
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// 📁 DrPersonalInfoScreen.dart  //working
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gap/gap.dart';
// import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
// import 'package:healthcare_hub/core/widgets/custom_input_textfield.dart';
// import 'package:healthcare_hub/core/widgets/custom_elevated_button.dart';
// import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
// import '../../../../../core/Const/app_colors.dart';
// import '../../../../../core/utils/app_sizes.dart';
// import '../controller/personal_info_controller.dart';

// class DrPersonalInfoScreen extends StatelessWidget {
//   DrPersonalInfoScreen({super.key});
//   final DrPersonalInfoController controller = Get.find<DrPersonalInfoController>();
//   final AppSizes appSizes = AppSizes();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           margin: appSizes.getCustomPadding(left: 6, right: 6, top: 8, bottom: 6),
//           padding: appSizes.getCustomPadding(right: 6, left: 6),
//           decoration: BoxDecoration(
//             color: AppColors.blue,
//             borderRadius: BorderRadius.circular(18),
//             boxShadow: [BoxShadow(color: AppColors.black, spreadRadius: -1, blurRadius: 8)],
//           ),
//           child: Form(
//             key: controller.formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Gap(16),
//                   CustomTextWidget(
//                     text: "PERSONAL INFORMATION",
//                     textColor: AppColors.yellow,
//                     fontSize: 22,
//                   ),
//                   const Gap(16),

//                   /// License Number
//                   CustomInputTextField(
//                     validator: controller.validateLicense,
//                     textEditingController: controller.licenseController,
//                     hintText: "Enter License number",
//                     isValidator: true,
//                     isFilled: true,
//                     filledColor: AppColors.white,
//                     emptyValueErrorText: "Please enter your License number",
//                   ),

//                   const Gap(16),

//                   /// Experience
//                   CustomInputTextField(
//                     textEditingController: controller.experienceController,
//                     hintText: "Enter experience (Years)",
//                     isValidator: true,
//                     isFilled: true,
//                     numberKeyboard: true,
//                     filledColor: AppColors.white,
//                     maxLength: 3,
//                     emptyValueErrorText: "Please enter your experience",
//                   ),

//                   const Gap(16),

//                   /// About (Optional)
//                   CustomInputTextField(
//                     textEditingController: controller.aboutController,
//                     hintText: "About (Optional)",
//                     isValidator: false,
//                     isFilled: true,
//                     maxLines: 4,
//                     filledColor: AppColors.white,
//                   ),

//                   const Gap(16),

//                   /// Gender
//                   Row(
//                     children: [
//                       Obx(() => Radio(
//                             value: 'Male',
//                             groupValue: controller.selectedGender.value,
//                             onChanged: (value) => controller.selectedGender.value = value!,
//                             activeColor: AppColors.white,
//                           )),
//                       const CustomTextWidget(text: 'Male', textColor: AppColors.white),
//                       const Gap(12),
//                       Obx(() => Radio(
//                             value: 'Female',
//                             groupValue: controller.selectedGender.value,
//                             onChanged: (value) => controller.selectedGender.value = value!,
//                             activeColor: AppColors.white,
//                           )),
//                       const CustomTextWidget(text: 'Female', textColor: AppColors.white),
//                     ],
//                   ),

//                   const Gap(24),
//                   CustomTextWidget(
//                     text: "OTHER INFORMATION",
//                     textColor: AppColors.yellow,
//                     fontSize: 22,
//                   ),

//                   const Gap(16),

//                   /// Hospital Dropdown
//                   Obx(() => DropdownButtonFormField<String>(
//                         value: controller.selectedHospital.value.isNotEmpty
//                             ? controller.selectedHospital.value
//                             : null,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: AppColors.white,
//                           border: OutlineInputBorder(),
//                           hintText: "Select Hospital",
//                         ),
//                         items: controller.dummyHospitals
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (value) => controller.selectedHospital.value = value ?? '',
//                       )),

//                   const Gap(12),

//                   /// Department Dropdown
//                   Obx(() => DropdownButtonFormField<String>(
//                         value: controller.selectedDepartment.value.isNotEmpty
//                             ? controller.selectedDepartment.value
//                             : null,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: AppColors.white,
//                           border: OutlineInputBorder(),
//                           hintText: "Select Department",
//                         ),
//                         items: controller.dummyDepartments
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (value) => controller.selectedDepartment.value = value ?? '',
//                       )),

//                   const Gap(12),

//                   /// Specialization Dropdown
//                   Obx(() => DropdownButtonFormField<String>(
//                         value: controller.selectedSpecialization.value.isNotEmpty
//                             ? controller.selectedSpecialization.value
//                             : null,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: AppColors.white,
//                           border: OutlineInputBorder(),
//                           hintText: "Select Specialization",
//                         ),
//                         items: controller.dummySpecializations
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (value) => controller.selectedSpecialization.value = value ?? '',
//                       )),

//                   const Gap(12),

//                   /// Degrees Chips
//                   Obx(() => Wrap(
//                         spacing: 8,
//                         children: controller.degreesNameList
//                             .map((name) => Chip(
//                                   label: Text(name),
//                                   backgroundColor: AppColors.white,
//                                   deleteIcon: Icon(Icons.close),
//                                   onDeleted: () => controller.removeDegreeName(name),
//                                 ))
//                             .toList(),
//                       )),

//                   const Gap(8),

//                   /// Add Degree
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomInputTextField(
//                           textEditingController: controller.degreesNameTextController,
//                           hintText: "Add Degree",
//                           isFilled: true,
//                           filledColor: AppColors.white,
//                         ),
//                       ),
//                       Gap(8),
//                       CustomElevatedButton(
//                         width: 80,
//                         backgroundColor: AppColors.white,
//                         textColor: AppColors.blue,
//                         onPress: controller.addDegreeName,
//                         text: "Add",
//                       ),
//                     ],
//                   ),

//                   const Gap(32),

//                   /// Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomOutlineButton(
//                           borderColor: AppColors.white,
//                           textColor: AppColors.white,
//                           onPress: () => Get.back(),
//                           text: "BACK",
//                         ),
//                       ),
//                       Gap(8),
//                       Expanded(
//                         child: Obx(() => CustomElevatedButton(
//                               isLoading: controller.isLoading.value,
//                               backgroundColor: AppColors.yellow,
//                               textColor: AppColors.blue,
//                               onPress: () async {
//                                 if (controller.formKey.currentState!.validate()) {
//                                   await controller.doctorRegistration();
//                                 }
//                               },
//                               text: "Register",
//                             )),
//                       ),
//                     ],
//                   ),

//                   const Gap(24),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
// import '../../../../../core/Const/app_colors.dart';
// import '../../../../../core/app_routes/routes.dart';
// import '../../../../../core/utils/app_sizes.dart';
// import '../../../../../core/widgets/custom_elevated_button.dart';
// import '../../../../../core/widgets/custom_input_textfield.dart';
// import '../../../../../core/widgets/custom_text_widget.dart';
// import '../controller/personal_info_controller.dart';

// class DrPersonalInfoScreen extends StatelessWidget {
//   DrPersonalInfoScreen({super.key});

//   final DrPersonalInfoController controller = Get.find<DrPersonalInfoController>();
//   final AppSizes appSizes = AppSizes();

//   @override
//   Widget build(BuildContext context) {
//     final List<String> experienceYears = List.generate(51, (index) => index.toString());
//     final List<String> degreeOptions = ['MBBS', 'MD', 'MS', 'BDS', 'MDS'];

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scaffold(
//           body: Center(
//             child: Container(
//               margin: appSizes.getCustomPadding(
//                 left: 6,
//                 right: 6,
//                 top: 8,
//                 bottom: 6,
//               ),
//               width: appSizes.getWidthPercentage(100),
//               padding: appSizes.getCustomPadding(right: 6, left: 6),
//               decoration: BoxDecoration(
//                 color: AppColors.blue,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.black,
//                     spreadRadius: -1,
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Form(
//                 key: controller.formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomTextWidget(
//                         text: "PERSONAL INFORMATION",
//                         textColor: AppColors.yellow,
//                         fontSize: 22,
//                       ),
//                       const Gap(16),
//                       CustomInputTextField(
//                         validator: controller.validateLicense,
//                         textEditingController: controller.licenseController,
//                         hintText: "Enter License number",
//                         isValidator: true,
//                         isFilled: true,
//                         numberKeyboard: false,
//                         filledColor: AppColors.white,
//                         emptyValueErrorText: "Please enter your License number",
//                       ),
//                       const Gap(16),
//                       DropdownButtonFormField<String>(
//                         value: controller.experienceController.text.isNotEmpty
//                             ? controller.experienceController.text
//                             : null,
//                         items: experienceYears
//                             .map((year) => DropdownMenuItem(
//                                   value: year,
//                                   child: Text("$year years"),
//                                 ))
//                             .toList(),
//                         onChanged: (value) => controller.experienceController.text = value ?? '',
//                         decoration: InputDecoration(
//                           hintText: "Select experience (Years)",
//                           filled: true,
//                           fillColor: AppColors.white,
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                         ),
//                         validator: (value) =>
//                             value == null || value.isEmpty ? "Please select your experience" : null,
//                       ),
//                       const Gap(16),
//                       CustomInputTextField(
//                         textEditingController: controller.aboutController,
//                         hintText: "About (Optional)",
//                         isValidator: false,
//                         isFilled: true,
//                         maxLines: 4,
//                         filledColor: AppColors.white,
//                         emptyValueErrorText: "",
//                       ),
//                       const Gap(16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Obx(
//                             () => Radio(
//                               value: 'Male',
//                               activeColor: AppColors.white,
//                               groupValue: controller.selectedGender.value,
//                               onChanged: (value) =>
//                                   controller.selectedGender.value = value!,
//                             ),
//                           ),
//                           const CustomTextWidget(
//                             textAlign: TextAlign.start,
//                             text: 'Male',
//                             textColor: AppColors.white,
//                           ),
//                           const Gap(16),
//                           Obx(
//                             () => Radio(
//                               value: 'Female',
//                               activeColor: AppColors.white,
//                               groupValue: controller.selectedGender.value,
//                               onChanged: (value) =>
//                                   controller.selectedGender.value = value!,
//                             ),
//                           ),
//                           const CustomTextWidget(
//                             textAlign: TextAlign.start,
//                             text: 'Female',
//                             textColor: AppColors.white,
//                           ),
//                         ],
//                       ),
//                       CustomTextWidget(
//                         text: "OTHER INFORMATION",
//                         textColor: AppColors.yellow,
//                         fontSize: 22,
//                       ),
//                       const Gap(16),
//                       CustomInputTextField(
//                         hintText: "Enter hospital name",
//                         textEditingController: controller.hospitalNameController,
//                         isFilled: true,
//                         filledColor: AppColors.white,
//                       ),
//                       Gap(12),
//                       CustomInputTextField(
//                         hintText: "Enter dept. name",
//                         textEditingController: controller.departmentController,
//                         isFilled: true,
//                         filledColor: AppColors.white,
//                       ),
//                       Gap(12),
//                       CustomInputTextField(
//                         hintText: "Enter specialization",
//                         textEditingController: controller.specializationController,
//                         isFilled: true,
//                         filledColor: AppColors.white,
//                       ),
//                       Gap(12),
//                       Obx(
//                         () => Wrap(
//                           spacing: 8,
//                           children: controller.degreesNameList.map((name) {
//                             return Chip(
//                               label: CustomTextWidget(
//                                 text: name,
//                                 textColor: AppColors.white,
//                               ),
//                               backgroundColor: AppColors.blue,
//                               deleteIcon: Icon(
//                                 Icons.close,
//                                 color: AppColors.white,
//                               ),
//                               onDeleted: () => controller.removeDegreeName(name),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Gap(4),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: DropdownButtonFormField<String>(
//                               value: null,
//                               items: degreeOptions
//                                   .map((degree) => DropdownMenuItem(
//                                         value: degree,
//                                         child: Text(degree),
//                                       ))
//                                   .toList(),
//                               onChanged: (value) {
//                                 if (value != null) {
//                                   controller.degreesNameTextController.text = value;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintText: "Select degree",
//                                 filled: true,
//                                 fillColor: AppColors.white,
//                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                               ),
//                             ),
//                           ),
//                           Gap(8),
//                           CustomElevatedButton(
//                             width: 80,
//                             backgroundColor: AppColors.white,
//                             textColor: AppColors.blue,
//                             onPress: controller.addDegreeName,
//                             text: "Add",
//                           ),
//                         ],
//                       ),
//                       const Gap(32),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomOutlineButton(
//                               borderColor: AppColors.white,
//                               textColor: AppColors.white,
//                               onPress: () {
//                                 Get.back();
//                               },
//                               text: "BACK",
//                             ),
//                           ),
//                           Gap(8),
//                           Expanded(
//                             child: Obx(
//                               () => CustomElevatedButton(
//                                 isLoading: controller.isLoading.value,
//                                 backgroundColor: AppColors.yellow,
//                                 textColor: AppColors.blue,
//                                 onPress: () async {
//                                   if (controller.formKey.currentState!.validate()) {
//                                     await controller.doctorRegistration();
//                                     controller.refreshField();
//                                   }
//                                 },
//                                 text: "Register",
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gap/gap.dart';
// import '../../../../../core/Const/app_colors.dart';
// import '../../../../../core/widgets/custom_text_widget.dart';
// import '../../../../../core/widgets/custom_input_textfield.dart';
// import '../../../../../core/widgets/custom_outline_button.dart';
// import '../../../../../core/widgets/custom_elevated_button.dart';
// import '../controller/personal_info_controller.dart';

// class DrPersonalInfoScreen extends StatelessWidget {
//   DrPersonalInfoScreen({super.key});

//   final DrPersonalInfoController controller = Get.find<DrPersonalInfoController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: controller.formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Gap(10),
//                 CustomTextWidget(
//                   text: "License Number",
//                   textColor: Colors.black,
//                   fontSize: 16,
//                 ),
//                 const Gap(8),
//                 CustomInputTextField(
//                   validator: controller.validateLicense,
//                   textEditingController: controller.licenseController,
//                   hintText: "Enter License Number",
//                   isValidator: true,
//                   filledColor: Colors.white,
//                 ),
//                 const Gap(16),
//                 CustomTextWidget(
//                   text: "Experience (Years)",
//                   textColor: Colors.black,
//                   fontSize: 16,
//                 ),
//                 const Gap(8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                         hint: const Text("Select Years"),
//                         value: null,
//                         items: controller.experienceOptions
//                             .map((year) => DropdownMenuItem(
//                                   value: year,
//                                   child: Text(year),
//                                 ))
//                             .toList(),
//                         onChanged: (value) {
//                           controller.experienceController.text = value ?? '';
//                         },
//                       ),
//                     ),
//                     const Gap(8),
//                     SizedBox(
//                       width: 80,
//                       child: TextFormField(
//                         controller: controller.experienceController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: "or type",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const Gap(16),
//                 CustomTextWidget(text: "Hospital Name", textColor: Colors.black),
//                 const Gap(8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                         hint: const Text("Select Hospital"),
//                         items: controller.hospitalOptions
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (value) {
//                           controller.hospitalNameController.text = value ?? '';
//                         },
//                       ),
//                     ),
//                     const Gap(8),
//                     Expanded(
//                       child: TextFormField(
//                         controller: controller.hospitalNameController,
//                         decoration: InputDecoration(
//                           hintText: "or type",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const Gap(16),
//                 CustomTextWidget(text: "Department Name", textColor: Colors.black),
//                 const Gap(8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                         hint: const Text("Select Department"),
//                         items: controller.departmentOptions
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (value) {
//                           controller.departmentController.text = value ?? '';
//                         },
//                       ),
//                     ),
//                     const Gap(8),
//                     Expanded(
//                       child: TextFormField(
//                         controller: controller.departmentController,
//                         decoration: InputDecoration(
//                           hintText: "or type",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const Gap(16),
//                 CustomTextWidget(text: "Specialization", textColor: Colors.black),
//                 const Gap(8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                         hint: const Text("Select Specialization"),
//                         items: controller.specializationOptions
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (value) {
//                           controller.specializationController.text = value ?? '';
//                         },
//                       ),
//                     ),
//                     const Gap(8),
//                     Expanded(
//                       child: TextFormField(
//                         controller: controller.specializationController,
//                         decoration: InputDecoration(
//                           hintText: "or type",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const Gap(32),
//                 Obx(() => CustomElevatedButton(
//                       isLoading: controller.isLoading.value,
//                       onPress: () async {
//                         if (controller.formKey.currentState!.validate()) {
//                           await controller.doctorRegistration();
//                           controller.refreshField();
//                         }
//                       },
//                       text: "Submit",
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
import 'package:healthcare_hub/core/widgets/custom_input_textfield.dart';
import 'package:healthcare_hub/core/widgets/custom_elevated_button.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
import '../../../../../core/Const/app_colors.dart';
import '../../../../../core/utils/app_sizes.dart';
import '../controller/personal_info_controller.dart';

class DrPersonalInfoScreen extends StatelessWidget {
  DrPersonalInfoScreen({super.key});
  final DrPersonalInfoController controller = Get.find<DrPersonalInfoController>();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: appSizes.getCustomPadding(left: 6, right: 6, top: 8, bottom: 6),
          padding: appSizes.getCustomPadding(right: 6, left: 6),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: AppColors.black, spreadRadius: -1, blurRadius: 8)],
          ),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(16),
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
                    maxLength: 4,
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    emptyValueErrorText: "Please enter your experience",
                  ),

                  const Gap(16),

                  /// About (Optional)
                  CustomInputTextField(
                    textEditingController: controller.aboutController,
                    hintText: "About (Optional)",
                    isValidator: false,
                    isFilled: true,
                    maxLines: 4,
                    filledColor: AppColors.white,
                  ),

                  const Gap(16),

                  /// Gender
                  Row(
                    children: [
                      Obx(() => Radio(
                            value: 'Male',
                            groupValue: controller.selectedGender.value,
                            onChanged: (value) => controller.selectedGender.value = value!,
                            activeColor: AppColors.white,
                          )),
                      const CustomTextWidget(text: 'Male', textColor: AppColors.white),
                      const Gap(12),
                      Obx(() => Radio(
                            value: 'Female',
                            groupValue: controller.selectedGender.value,
                            onChanged: (value) => controller.selectedGender.value = value!,
                            activeColor: AppColors.white,
                          )),
                      const CustomTextWidget(text: 'Female', textColor: AppColors.white),
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
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedHospital.value.isNotEmpty
                            ? controller.selectedHospital.value
                            : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                          hintText: "Select Hospital",
                        ),
                        validator: (value) => controller.validateDropdown(value, "hospital"),
                        items: controller.dummyHospitals
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) => controller.selectedHospital.value = value ?? '',
                      )),

                  const Gap(12),
// Obx(() => CustomDropdownButtonFormField<String>(
//       hintText: "Select Category",
//       hintStyle: TextStyle(fontSize: 10 , fontWeight: FontWeight.w800),
//       value: controller.selectedCategory.value.isNotEmpty
//           ? controller.selectedCategory.value
//           : null,
//       items: controller.categories
//           .map((e) => DropdownMenuItem(
//                 value: e,
//                 child: Text(e),
//               ))
//           .toList(),
//       onChanged: (value) => controller.selectedCategory.value = value ?? '',
//       validator: controller.validateCategory,
// )),
                  /// Department Dropdown
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedDepartment.value.isNotEmpty
                            ? controller.selectedDepartment.value
                            : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                          filled: true,
                          fillColor: AppColors.white,
                         
                          hintText: "Select Department",
                        ),
                        validator: (value) => controller.validateDropdown(value, "department"),
                        items: controller.dummyDepartments
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) => controller.selectedDepartment.value = value ?? '',
                      )),

                  const Gap(12),

                  /// Specialization Dropdown
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedSpecialization.value.isNotEmpty
                            ? controller.selectedSpecialization.value
                            : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                          hintText: "Select Specialization",
                        ),
                        validator: (value) => controller.validateDropdown(value, "specialization"),
                        items: controller.dummySpecializations
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) => controller.selectedSpecialization.value = value ?? '',
                      )),

                  const Gap(12),

                  /// Degree Dropdown
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedDegree.value.isNotEmpty
                            ? controller.selectedDegree.value
                            : null,
                        decoration: InputDecoration(
                          
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                          hintText: "Select Degree",
                        ),
                        items: controller.dummyDegrees
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedDegree.value = value ?? '';
                          if (value != null && value.isNotEmpty) {
                            controller.degreesNameList.add(value);
                            controller.selectedDegree.value = '';
                          }
                        },
                      )),

                  const Gap(12),

                  /// Degrees Chips
                  Obx(() => Wrap(
                        spacing: 8,
                        children: controller.degreesNameList
                            .map((name) => Chip(
                                  label: Text(name),
                                  backgroundColor: AppColors.white,
                                  deleteIcon: Icon(Icons.close),
                                  onDeleted: () => controller.removeDegreeName(name),
                                ))
                            .toList(),
                      )),

                  const Gap(32),

                  /// Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomOutlineButton(
                          borderColor: AppColors.white,
                          textColor: AppColors.white,
                          onPress: () => Get.back(),
                          text: "BACK",
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        child: Obx(() => CustomElevatedButton(
                              isLoading: controller.isLoading.value,
                              backgroundColor: AppColors.yellow,
                              textColor: AppColors.blue,
                              onPress: () async {
                                if (controller.formKey.currentState!.validate()) {
                                  await controller.doctorRegistration(context);
                                }
                              },
                              text: "Register",
                            )),
                      ),
                    ],
                  ),

                  const Gap(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



