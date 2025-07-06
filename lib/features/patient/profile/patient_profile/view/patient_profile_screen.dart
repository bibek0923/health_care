import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
import 'package:healthcare_hub/data/models/appointment_model.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import 'package:healthcare_hub/faetures/patient/profile/edit_patient_profile/controller/edit_patient_profile_controller.dart';
import '../../../../../core/widgets/custom_appointment_container.dart';
import '../../../../../core/widgets/custom_row.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../../../../pdf_viewer/pdf_viewer_screen.dart';
import '../../edit_patient_profile/view/edit_patient_profile_screen.dart';
import '../controller/patient_profile_controller.dart';

class PatientProfileScreen extends StatelessWidget {
  PatientProfileScreen({super.key});

  final PatientProfileController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(title: "Patient Profile", goBack: true),
          body: SingleChildScrollView(
            padding: appSizes.getCustomPadding(),
            child: StreamBuilder(
              stream: controller.getUserStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.blue),
                  );
                } else if (snapshot.hasData) {
                  PatientModel? patient = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  patient!.imageUrl != null &&
                                          patient.imageUrl!.isNotEmpty
                                      ? NetworkImage(patient.imageUrl!)
                                      : AssetImage(
                                        patient.gender?.toLowerCase() ==
                                                'female'
                                            ? AppImages.femalePatient
                                            : AppImages.malePatient,
                                      ),
                            ),
                            Gap(12),
                            CustomTextWidget(
                              text:
                                  "${patient.firstName} ${patient.middleName} ${patient.lastName}",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                            CustomTextWidget(
                              text: "Date of birth: ${patient.age}"
                              ,fontSize: 16, fontWeight: FontWeight.w400,
                            ),
                            // CustomTextWidget(
                            //   text:
                            //       patient.bloodGroup == "Don't know"
                            //           ? "Blood Type: N/A"
                            //           : "Blood Type: ${patient.bloodGroup}",
                            // ),
                            CustomTextWidget(text: "Height: ${patient.height} ${patient.heightUnit}",fontSize: 16, fontWeight: FontWeight.w400,),
                            CustomTextWidget(text: "Weight: ${patient.weight} ${patient.weightUnit}",fontSize: 16, fontWeight: FontWeight.w400,),
                            CustomTextWidget(text: "Gender: ${patient.gender}",fontSize: 16, fontWeight: FontWeight.w400,),
                            Gap(10),
                            CustomTextWidget(
                              text: patient.about!,
                              // textColor: AppColors.blackish,
                              fontSize: 16, fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      Gap(12),
                      CustomOutlineButton(
                        onPress: () {
                          Get.to(
                            () => PatientEditProfileScreen(),
                            binding: BindingsBuilder(() {
                              Get.put(PatientEditProfileController());
                            }),
                            arguments: patient,
                          );
                        },
                        text: "Edit Profile",
                      ),
                      Gap(12),
                      Divider(),
                      CustomTextWidget(
                        text: "Personal Info:",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(12),
                      CustomRow(
                        text: patient.email!,
                        icon: CupertinoIcons.mail,
                      ),
                      Gap(8),
                      CustomRow(
                        text: controller.formatIdCardNumber(
                          patient.idCardNumber!,
                        ),
                        icon: CupertinoIcons.person_2,
                      ),
                      Gap(8),
                      // CustomRow(
                      //   text: patient.phoneNumber!,
                      //   icon: CupertinoIcons.phone,
                      // ),
                      Gap(8),
                      CustomRow(
                        text: patient.insuranceCard!,
                        icon: CupertinoIcons.creditcard,
                      ),
                      Gap(12),
                      // Divider(),
                      // CustomTextWidget(
                      //   text: "Emergency Contact Info:",
                      //   fontSize: 17,
                      //   fontWeight: FontWeight.w500,
                      // ),
                      // Gap(12),
                      // CustomRow(
                      //   text: patient.guardianName!,
                      //   icon: CupertinoIcons.person,
                      // ),
                      // Gap(8),
                      // CustomRow(
                      //   text: controller.formatIdCardNumber(
                      //     patient.guardianIdCard!,
                      //   ),
                      //   icon: CupertinoIcons.creditcard,
                      // ),
                      // Gap(8),
                      // CustomRow(
                      //   text: patient.guardianGender!,
                      //   icon:
                      //       patient.guardianGender! == "Male"
                      //           ? Icons.male
                      //           : Icons.female,
                      // ),
                      // Gap(8),
                      // CustomRow(
                      //   text: patient.guardianRelationShip!,
                      //   icon: CupertinoIcons.person_2,
                      // ),
                      // Gap(8),
                      // CustomRow(
                      //   text: patient.guardianPhoneNumber!,
                      //   icon: CupertinoIcons.phone,
                      // ),
                      Gap(12),
                      Divider(),
                      CustomTextWidget(
                        text: "Medical Reports:",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(8),
                      GestureDetector(
                        onTap: () async {
                          Get.to(PdfViewerScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.blueish,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.blackish),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.picture_as_pdf,
                                color: AppColors.white,
                                size: 32,
                              ),
                              Gap(12),
                              Expanded(
                                child: CustomTextWidget(
                                  textAlign: TextAlign.start,
                                  text: "View Medical PDF",
                                  fontSize: 16,
                                  textColor: AppColors.white,
                                ),
                              ),
                              Icon(Icons.open_in_new, color: AppColors.white),
                            ],
                          ),
                        ),
                      ),
                      Gap(12),
                      Divider(),
                      CustomTextWidget(
                        text: "Appointments:",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(8),
                      StreamBuilder<List<AppointmentModel>>(
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
                                        appointment.patientId ==
                                        controller.userId,
                                  )
                                  .toList();
                          if (filteredAppointments.isEmpty) {
                            return Center(
                              child: CustomTextWidget(
                                text: "No appointments found",
                              ),
                            );
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredAppointments.length,
                            itemBuilder: (context, index) {
                              final appointment = filteredAppointments[index];
                              return StreamBuilder(
                                stream: controller.getDoctorData(
                                  appointment.doctorId,
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
                    ],
                  );
                }
                return Center(
                  child: CustomTextWidget(
                    text: "user not found",
                    textColor: AppColors.white,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
