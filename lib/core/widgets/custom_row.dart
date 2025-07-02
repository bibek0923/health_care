import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'custom_text_widget.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Gap(8),
        CustomTextWidget(text: text, textAlign: TextAlign.start, fontSize: 16),
      ],
    );
  }
}
