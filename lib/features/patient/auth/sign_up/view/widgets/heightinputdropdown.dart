import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/faetures/patient/auth/sign_up/controller/signup_controller.dart';

class HeightDropdown extends StatelessWidget {
  HeightDropdown({super.key});

  final controller = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: 30,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            color: AppColors.white,
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
                    controller: controller.heightController,
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
                      hintText: "Enter height",
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
                    validator: (value) => controller.heightValidator(value),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => DropdownButton<String>(
                    value: controller.selectedHeightUnit.value,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 2,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    underline: Container(
                      height: 0,
                      color: const Color.fromARGB(255, 104, 70, 70),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        controller.selectedHeightUnit.value = value;
                        print(value);
                       
                      }
                    },
                    items:
                        controller.heightUnitsList.map<DropdownMenuItem<String>>((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () =>
              controller.showHeightError.value
                  ? Padding(
                    padding: const EdgeInsets.only(top: 5, left: 12),
                    child: Text(
                      controller.heightErrorMessage,
                      style: TextStyle(color: const Color.fromARGB(255, 244, 67, 54), fontSize: 11),
                    ),
                  )
                  : SizedBox(),
        ),
      ],
    );
  }
}
