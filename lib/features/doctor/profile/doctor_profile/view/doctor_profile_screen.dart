import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/core/widgets/custom_outline_button.dart';
import 'package:healthcare_hub/data/models/doctor_model.dart';
import 'package:healthcare_hub/faetures/doctor/profile/edit_doctor_profile/controller/edit_doctor_profile_controller.dart';
import 'package:healthcare_hub/faetures/pdf_viewer/pdf_viewer_screen.dart';
import '../../../../../core/Const/app_images.dart';
import '../../../../../core/widgets/custom_appointment_container_doctor_side.dart';
import '../../../../../core/widgets/custom_row.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../../../../../core/widgets/horizontal_string_wrapped.dart';
import '../../../../../data/models/appointment_model.dart';
import '../../edit_doctor_profile/view/edit_doctor_profile_screen.dart';
import '../controller/doctor_profile_controller.dart';

class DoctorProfileScreen extends StatelessWidget {
  DoctorProfileScreen({super.key});

  final DoctorProfileController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(title: "Doctor Profile", goBack: true),
          body: SingleChildScrollView(
            padding: appSizes.getCustomPadding(),
            child: StreamBuilder(
              stream: controller.getUserStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.blue,),);
                } else if (snapshot.hasData) {
                  DoctorModel? doctor = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: doctor!.imageUrl == ''?AssetImage(
                                doctor.gender == "Male"
                                    ? AppImages.maleDr
                                    : AppImages.femaleDr,
                              ):NetworkImage(doctor.imageUrl!),
                            ),
                            Gap(12),
                            CustomTextWidget(
                              text: "${doctor.firstName} ${doctor.middleName} ${doctor.lastName}",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                            CustomTextWidget(text: "Specialist: ${doctor.specialization}",fontSize: 16, fontWeight: FontWeight.w400,),
                            CustomTextWidget(text: "Experience: ${doctor.experience}+ years",fontSize: 16, fontWeight: FontWeight.w400,),
                            CustomTextWidget(text: "License: ${doctor.liceneceNumber}",fontSize: 16, fontWeight: FontWeight.w400,),
                            CustomTextWidget(text: "Gender: ${doctor.gender}",fontSize: 16, fontWeight: FontWeight.w400,),
                          (doctor.degreesName!.isNotEmpty)  ? HorizontalWrappedStrings(items: doctor.degreesName!,) : SizedBox(),
                            Gap(6),
                            CustomTextWidget(
                              text: doctor.about!,
                              textColor: AppColors.blackish,
                              textOverflow: TextOverflow.visible,
                              fontSize: 16, fontWeight: FontWeight.w400,
                            ),
                            Gap(12),
                            CustomOutlineButton(onPress: () {
                              Get.to(() => DoctorEditProfileScreen(), binding: BindingsBuilder(() {
                                Get.put(DoctorEditProfileController());
                              }), arguments: doctor);

                            }, text: "Edit Profile")
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
                      CustomRow(
                        text: doctor.email,
                        icon: CupertinoIcons.mail,
                      ),
                      Gap(8),
                      // CustomRow(text: doctor.phoneNumber!, icon: CupertinoIcons.phone),
                      // Gap(12),
                      Divider(),
                      CustomTextWidget(
                        text: "Hospital Info:",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(12),
                      CustomRow(
                        text: doctor.hospitalName!,
                        icon: CupertinoIcons.location_solid,
                      ),
                      Gap(8),
                      CustomRow(
                        text: "Department: ${doctor.department}",
                        // icon: CupertinoIcons.building_2_fill,
                        icon: CupertinoIcons.heart,
                      ),
                      // Gap(12),
                      // Divider(),
                      // CustomTextWidget(
                      //   text: "Certificates:",
                      //   fontSize: 17,
                      //   fontWeight: FontWeight.w500,
                      // ),
                      Gap(8),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: doctor.degreesUrl!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
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
                                  Icon(Icons.picture_as_pdf, color: AppColors.white, size: 32),
                                  Gap(12),
                                  Expanded(
                                    child: CustomTextWidget(
                                      textAlign: TextAlign.start,
                                      text: "${index} - View Certificate PDF",
                                      fontSize: 16,
                                      textColor: AppColors.white,
                                    ),
                                  ),
                                  Icon(Icons.open_in_new, color: AppColors.white),
                                ],
                              ),
                            ),
                          );
                      }, separatorBuilder: (BuildContext context, int index) { return Gap(6); },),

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
                              .where((appointment) => appointment.doctorId== controller.userId)
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
                      ,
                    ],
                  );
                }
                return Center(child: CustomTextWidget(
                  text: "user not found", textColor: AppColors.white,));
              },
            ),
          ),
        );
      },
    );
  }
}
