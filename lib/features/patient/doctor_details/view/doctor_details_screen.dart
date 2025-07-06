import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_appointment_container_doctor_side.dart';
import 'package:healthcare_hub/core/widgets/horizontal_string_wrapped.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import '../../../../core/widgets/custom_appointment_container.dart';
import '../../../../core/widgets/custom_row.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../pdf_viewer/pdf_viewer_screen.dart';
import '../controller/doctor_details_controller.dart';

class DoctorDetailsScreen extends StatelessWidget {
  DoctorDetailsScreen({super.key});

  final DoctorDetailsController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor = Get.arguments["doctor"];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(title: "Doctor Profile", goBack: true),
          body: SingleChildScrollView(
            padding: appSizes.getCustomPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                       backgroundImage: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
      ? NetworkImage(doctor.imageUrl!)
      : AssetImage(doctor.gender?.toLowerCase() == 'female'
              ? AppImages.femaleDr
              : AppImages.maleDr,),// replace with actual doctor image
                      ),
                      Gap(12),
                      CustomTextWidget(
                        text: "${doctor.firstName} ${doctor.middleName} ${doctor.lastName}",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      CustomTextWidget(
                        text: "Specialist: ${doctor.specialization}",
                      ),
                      CustomTextWidget(
                        text: "Experience: ${doctor.experience}+ years",
                      ),
                      CustomTextWidget(
                        text: "License: ${doctor.liceneceNumber}",
                      ),
                      CustomTextWidget(text: "Gender: ${doctor.gender}"),
                      HorizontalWrappedStrings(items: doctor.degreesName!),
                      Gap(6),
                      CustomTextWidget(
                        text: doctor.about!,
                        textColor: AppColors.blackish,
                        textOverflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
                Gap(12),
                Divider(),
                CustomTextWidget(
                  text: "Contact Info:",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                Gap(12),
                CustomRow(text: doctor.email, icon: CupertinoIcons.mail),
               
                Gap(12),
                Divider(),
                CustomTextWidget(
                  text: "Hospital Info:",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                Gap(12),
                CustomRow(text: doctor.hospitalName!, icon: CupertinoIcons.location),
                Gap(8),
                CustomRow(
                  text: "Department: ${doctor.department}",
                  icon: CupertinoIcons.heart,
                ),
              
                Divider(),
                CustomTextWidget(
                  text: "Appointments",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8),
                StreamBuilder<List<AppointmentModel>>(
                  stream: controller.getAppointmentsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: AppColors.blue),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: CustomTextWidget(text: "Error loading appointments"),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: CustomTextWidget(text: "No appointments found"),
                      );
                    }

                    // Filter appointments where patientId == '12waq'
                    List<AppointmentModel> allAppointments = snapshot.data!;
                    List<AppointmentModel> filteredAppointments = allAppointments
                        .where((appointment) => appointment.doctorId == doctor.doctorId)
                        .toList();

                    if (filteredAppointments.isEmpty) {
                      return Center(
                        child: CustomTextWidget(text: "No appointments found"),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredAppointments.length,
                      itemBuilder: (context, index) {
                        final appointment = filteredAppointments[index];
                        return StreamBuilder(
                          stream: controller.getPatient(appointment.patientId),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(child: Text('Doctor information not available.'));
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
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
