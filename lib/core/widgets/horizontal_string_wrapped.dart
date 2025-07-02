import 'package:flutter/material.dart';
import 'package:healthcare_hub/core/Const/app_colors.dart';
import 'package:healthcare_hub/core/widgets/custom_text_widget.dart';

class HorizontalWrappedStrings extends StatelessWidget {
  final List<String> items;

  const HorizontalWrappedStrings({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        items.length * 2 - 1,
            (index) {
          if (index.isEven) {
            return CustomTextWidget(
              text:items[index ~/ 2],
            );
          } else {
            // Odd index = separator
            return CustomTextWidget(
              text: "||",
              textColor: AppColors.blackish,
            );
          }
        },
      ),
    );
  }
}
