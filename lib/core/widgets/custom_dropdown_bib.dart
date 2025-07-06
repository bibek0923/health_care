import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Const/app_colors.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {
  const CustomDropdownButtonFormField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.isFilled = true,
    this.filledColor = AppColors.white,
    this.borderColor = AppColors.blackish,
    this.borderRadius = 13,
    this.hintStyle,
    this.itemStyle,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    this.isDense = true,
    this.borderRestriction = true,
  });

  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final T? value;
  final String? Function(T?)? validator;
  final bool isFilled;
  final Color filledColor;
  final Color borderColor;
  final double borderRadius;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final EdgeInsetsGeometry contentPadding;
  final bool isDense;
  final bool borderRestriction;

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: isFilled && borderRestriction ? BorderSide.none : BorderSide(color: color, width: 0.6),
      );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        filled: isFilled,
        fillColor: filledColor,
        border: _buildBorder(borderColor),
        enabledBorder: _buildBorder(borderColor),
        focusedBorder: _buildBorder(borderColor),
        errorBorder: _buildBorder(AppColors.red),
        focusedErrorBorder: _buildBorder(AppColors.red),
        hintText: hintText,
        hintStyle: hintStyle ??
            GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.blackish,
            ),
        contentPadding: contentPadding,
        isDense: isDense,
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
      style: itemStyle ??
          GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.black,
          ),
    );
  }
}