import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_appointment_container.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';

import 'package:healthcare_hub/features/patient/profile/patient_profile/controller/patient_profile_controller.dart';

class NavAppointmentScreen extends StatelessWidget {
  NavAppointmentScreen({super.key});
  //  NavbarAppointmentController controller = Get.find();
  PatientProfileController controller = Get.find();
  final AppSizes appSizes = AppSizes();
  @override
  Widget build(BuildContext context) {
    controller.onInit();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: CustomAppBar(title: "Your Appointments",goBack: true,),
          body: SingleChildScrollView(
            padding: appSizes.getCustomPadding(),

            child: StreamBuilder<List<AppointmentModel>>(
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

                /// Filter appointments where patientId == '12waq'
                List<AppointmentModel> allAppointments = snapshot.data!;
                List<AppointmentModel> filteredAppointments =
                    allAppointments
                        .where(
                          (appointment) =>
                              appointment.patientId == controller.userId,
                        )
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
                      stream: controller.getDoctorData(appointment.doctorId),
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
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                            child: Text('Doctor information not available.'),
                          );
                        }

                        return CustomAppointmentContainer(
                          appSizes: appSizes,
                          appointment: appointment,
                          doctor: snapshot.data!,
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Gap(8),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
