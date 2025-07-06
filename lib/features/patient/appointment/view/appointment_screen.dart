import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_elevated_button.dart';
import 'package:healthcare_hub/core/widgets/custom_input_textfield.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/Const/app_colors.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../controller/appointment_controller.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({super.key});

  AppointmentController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor = Get.arguments["doctor"];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: "Book Appointment", goBack: true),
      body: SingleChildScrollView(
        padding: appSizes.getCustomPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: appSizes.getCustomPadding(),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                   backgroundImage: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
      ? NetworkImage(doctor.imageUrl!)
      : AssetImage(doctor.gender?.toLowerCase() == 'female'
              ? AppImages.femalePatient
              : AppImages.malePatient,),// use doctor image
                  ),
                  Gap(18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: "Dr ${doctor.firstName} ${doctor.lastName}",
                        fontSize: 18,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomTextWidget(
                        text: doctor.specialization!,
                        fontSize: 14,
                        textColor: AppColors.whitish,
                      ),
                       CustomTextWidget(
                            text: "Experience:  ${doctor.experience}+ Years",
                            textColor: AppColors.whitish,
                          ),
                      // Row(
                      //   children: [
                      //     CustomTextWidget(
                      //       text: "Experience: ${doctor.experience}",
                      //       textColor: AppColors.white,
                      //     ),
                      //     Gap(8),
                      //     CustomTextWidget(
                      //       text: "${doctor.experience} + Years",
                      //       textColor: AppColors.whitish,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(16),
            CustomTextWidget(
              text: "Appointment Details",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            Gap(8),
            Form(
              key: controller.formKey,
              child: CustomInputTextField(
                isValidator: true,
                validator: controller.titleValidator,
                hintText: "Title",
                textEditingController: controller.titleController,
              ),
            ),
            Gap(16),
            CustomTextWidget(
              text: "Select Date:",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            Gap(8),
            Obx(() {
              return GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  );
                  if (picked != null) {
                    controller.selectedDate.value = picked;
                  }
                },
                child: Container(
                  padding: appSizes.getCustomPadding(),
                  decoration: BoxDecoration(
                    color: AppColors.blueish,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month, color: AppColors.black),
                      Gap(18),
                      CustomTextWidget(
                        text: DateFormat(
                          'EEEE, dd MMM yyyy',
                        ).format(controller.selectedDate.value),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Gap(16),
            CustomTextWidget(
              text: "Select Time Slot:",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            Gap(8),
            Obx(() {
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    controller.timeSlots.map((slot) {
                      final isSelected =
                          controller.selectedTimeSlot.value == slot;
                      return GestureDetector(
                        onTap: () => controller.selectedTimeSlot.value = slot,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? AppColors.blue : AppColors.blueish,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.blueish
                                      : AppColors.blackish,
                            ),
                          ),
                          child: CustomTextWidget(
                            text: slot,
                            textColor:
                                isSelected ? AppColors.white : AppColors.black,
                          ),
                        ),
                      );
                    }).toList(),
              );
            }),
            Gap(16),
            CustomTextWidget(
              text: "Add Notes (Optional)",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            Gap(8),
            CustomInputTextField(
              hintText: "Write any health concern or message...",
              textEditingController: controller.notesController,
              maxLines: 4,
            ),
            Gap(20),
            Obx(
              () =>  CustomElevatedButton(
                isLoading: controller.isLoading.value,
                onPress: () async{
                 if( controller.formKey.currentState!.validate()){
await controller.bookAppointment(doctor.doctorId!);
                  }
                  
                },
                text: "Book Now",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
