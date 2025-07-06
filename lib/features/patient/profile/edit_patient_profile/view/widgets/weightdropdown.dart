import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';

import 'package:healthcare_hub/faetures/patient/profile/edit_patient_profile/controller/edit_patient_profile_controller.dart';

class WeightInputDropdown extends StatelessWidget {
  WeightInputDropdown({super.key});

  final controller = Get.find<PatientEditProfileController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          

          // height: 30,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            
            border: Border.all(color: AppColors.blackish, width: 0.5),

            // color: const Color.fromARGB(255, 52, 37, 37),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextFormField(
                    controller: controller.weightController,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: false,
                    ),

                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    cursorErrorColor: const Color.fromARGB(255, 244, 67, 54),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter weight",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackish,
                      ),
                      errorStyle: TextStyle(
                        height: 0,
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                    ),
                    validator: (value) => controller.weightValidator(value),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedWeightUnit.value,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 2,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    underline: Container(
                      height: 0,
                      color: const Color.fromARGB(255, 104, 70, 70),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        controller.selectedWeightUnit.value = value;
                        print(value);
                      }
                    },
                    items:
                        controller.weightUnitsList
                            .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () =>
              controller.showWeightError.value
                  ? Padding(
                    padding: const EdgeInsets.only(top: 5, left: 12),
                    child: Text(
                      controller.weightErrorMessage,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 244, 67, 54),
                        fontSize: 11,
                      ),
                    ),
                  )
                  : SizedBox(),
        ),
      ],
    );
  }
}
