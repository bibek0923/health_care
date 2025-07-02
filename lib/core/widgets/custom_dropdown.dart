import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Const/app_colors.dart';
import '../utils/app_sizes.dart';
import 'custom_text_widget.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String hintText;
  final String buttonText;
  final bool showButton;
  final bool haveBorders;
  final bool onWhite;
  final VoidCallback? onButtonPressed;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hintText,
    this.showButton = false,
    this.onButtonPressed,
    this.buttonText = "Add New",
    this.haveBorders = false,this.onWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: haveBorders ? AppSizes().getWidthPercentage(100) : null,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        border: haveBorders ? Border.all(color: onWhite?AppColors.blackish:AppColors.white) : null,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: IntrinsicWidth(
          child: DropdownButton<String>(
            dropdownColor: onWhite?AppColors.white:AppColors.blue,
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
            value: selectedValue,
            hint: CustomTextWidget(
              textAlign: TextAlign.start,
              text: hintText,
              fontSize: 14,
              textColor: onWhite?AppColors.blue:AppColors.white,
            ),
            icon: Icon(Icons.arrow_drop_down, color: AppColors.whitish),
            onChanged: onChanged,
            items: [
              ...items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: CustomTextWidget(
                    textAlign: TextAlign.start,
                    text: item,
                    fontSize: 14,
                    textColor: onWhite?AppColors.blue:AppColors.white,
                  ),
                );
              }),
              if (showButton)
                DropdownMenuItem<String>(
                  value: null,
                  enabled: false,
                  child: GestureDetector(
                    onTap: onButtonPressed,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline_sharp,
                            color: AppColors.black,
                            size: 20,
                          ),
                          Gap(8),
                          CustomTextWidget(
                            textAlign: TextAlign.start,
                            text: buttonText,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
