import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/app_routes/routes.dart';
import 'package:healthcare_hub/core/widgets/custom_appointment_container_doctor_side.dart';
import 'package:healthcare_hub/core/widgets/custom_input_textfield.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../data/models/appointment_model.dart';
import '../controllers/home_controller.dart';
import '../widgets/header.dart';

class DrHomeScreen extends StatelessWidget {
  DrHomeScreen({super.key});

  DrHomeController controller = Get.find();
  AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Get.toNamed(AppRoutes.AICHATSCREEN);
            },
            child: Image.asset(AppImages.ai),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(appSizes: appSizes, controller: controller),
              Expanded(
                child: Padding(
                  padding: appSizes.getCustomPadding(),
                  child: Column(
                    children: [
                      CustomInputTextField(
                        hintText: "Search here...",
                        prefixIcon: true,
                        borderRadius: 8,
                        textEditingController: controller.searchController,
                      ),
                      Gap(8),
                      SizedBox(
                        width: double.infinity,
                        child: CustomTextWidget(
                          text: "Today's appointments:",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Gap(6),
                      Expanded(
                        child: StreamBuilder<List<AppointmentModel>>(
                          stream: controller.getAppointmentsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.blue,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: CustomTextWidget(
                                  text: "Error loading appointments",
                                ),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
                                child: CustomTextWidget(
                                  text: "No appointments found",
                                ),
                              );
                            }

                            /// Filter appointments where patientId == '12waq'
                            List<AppointmentModel> allAppointments =
                                snapshot.data!;
                            List<AppointmentModel> filteredAppointments =
                                allAppointments
                                    .where(
                                      (appointment) =>
                                          appointment.doctorId ==
                                              controller.userId &&
                                              appointment.date.year == DateTime.now().year &&
                                              appointment.date.month == DateTime.now().month &&
                                              appointment.date.day == DateTime.now().day
                                    )
                                    .toList();

                            if (filteredAppointments.isEmpty) {
                              return Center(
                                child: CustomTextWidget(
                                  text: "No appointments found today",
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredAppointments.length,
                              itemBuilder: (context, index) {
                                final appointment = filteredAppointments[index];
                                return StreamBuilder(
                                  stream: controller.getPatient(
                                    appointment.patientId,
                                  ),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Center(
                                        child: Text(
                                          'Doctor information not available.',
                                        ),
                                      );
                                    }

                                    return CustomAppointmentContainerDoctorSide(
                                      appSizes: appSizes,
                                      appointment: appointment,
                                      patientModel: snapshot.data!,
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => Gap(8),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
