import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/Const/app_images.dart';
import 'package:healthcare_hub/core/utils/app_sizes.dart';
import 'package:healthcare_hub/core/widgets/custom_appbar.dart';
import 'package:healthcare_hub/data/models/patient_model.dart';
import '../../../../core/widgets/custom_row.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../../pdf_viewer/pdf_viewer_screen.dart';
import '../controller/patient_details_controller.dart';

class PatientDetailsScreen extends StatelessWidget {
  PatientDetailsScreen({super.key});

  final PatientDetailsController controller = Get.find();
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    final PatientModel patient = Get.arguments["patient"];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(title: "Profile", goBack: true),
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
                        backgroundImage:
                            patient!.imageUrl != null &&
                                    patient.imageUrl!.isNotEmpty
                                ? NetworkImage(patient.imageUrl!)
                                : AssetImage(
                                  patient.gender?.toLowerCase() == 'female'
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
                      CustomTextWidget(text: "Date of birth: ${patient.age}"),

                      CustomTextWidget(
                        text: "Height: ${patient.height} ${patient.heightUnit}",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomTextWidget(
                        text: "Weight: ${patient.weight} ${patient.weightUnit}",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomTextWidget(
                        text: "Gender: ${patient.gender}",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      Gap(6),
                      CustomTextWidget(
                        text: patient.about!,
                        textColor: AppColors.blackish,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                CustomRow(text: patient.email!, icon: CupertinoIcons.mail),
                Gap(8),
                CustomRow(
                  text: controller.formatIdCardNumber(patient.idCardNumber!),
                  icon: CupertinoIcons.creditcard,
                ),

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
              ],
            ),
          ),
        );
      },
    );
  }
}
