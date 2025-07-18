

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Const/app_colors.dart';

class CustomInputTextField extends StatefulWidget {
  const CustomInputTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.hasSuffixIcon = false,
    this.numberKeyboard = false,
    this.isFilled = false,
    this.prefixIcon = false,
    this.filledColor = AppColors.white,
    required this.textEditingController,
    this.emptyValueErrorText = "Please fill this field",
    this.isValidator = true,
    this.isObsecure = false,
    this.validator,
    this.width,
    this.maxLines = 1,
    this.borderRadius = 13,
    this.borderRestriction = true,
    this.borderColor = AppColors.blackish,
    this.onChange,
    this.maxLength = 0,
    this.counterColor = AppColors.whitish,
    this.textCapitalization=TextCapitalization.none,

  });

  final String hintText;
  final String? labelText;
  final bool hasSuffixIcon;
  final int? maxLength;
  final bool numberKeyboard;
  final bool prefixIcon;
  final bool isFilled;
  final Color borderColor;
  final Color filledColor;
  final TextEditingController textEditingController;
  final String emptyValueErrorText;
  final bool isValidator;
  final bool isObsecure;
  final Function(String)? onChange;
  final double borderRadius;
  final String? Function(String?)? validator;
  final double? width;
  final int maxLines;
  final bool borderRestriction;
  final Color counterColor;
final TextCapitalization textCapitalization;

  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.isObsecure;
  }

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.borderRadius),
    borderSide:
        widget.isFilled && widget.borderRestriction
            ? BorderSide.none
            : BorderSide(color: color, width: 0.6),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: widget.textCapitalization,
      controller: widget.textEditingController,
      onChanged: widget.onChange,
      maxLength: widget.maxLength == 0 ? null : widget.maxLength,
      keyboardType:
          widget.numberKeyboard
              ? TextInputType.number
              : TextInputType.visiblePassword,
      obscureText: widget.isObsecure ? isObscured : false,
      maxLines: widget.maxLines,
      cursorColor: AppColors.blue,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: AppColors.blackish,
        ),
        filled: widget.isFilled,
        fillColor: widget.filledColor,
        counterStyle: GoogleFonts.poppins(color: widget.counterColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 18,
        ),
        isDense: true,
        prefixIcon:
            widget.prefixIcon
                ? const Icon(Icons.search, color: AppColors.blackish)
                : null,
        suffixIcon:
            widget.isObsecure
                ? IconButton(
                  icon: Icon(
                    isObscured ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    color: AppColors.blackish,
                  ),
                  onPressed: () => setState(() => isObscured = !isObscured),
                )
                : null,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.blackish,
        ),
        border: _buildBorder(widget.borderColor),
        enabledBorder: _buildBorder(widget.borderColor),
        focusedBorder: _buildBorder(widget.borderColor),
        errorBorder: _buildBorder(AppColors.red),
        focusedErrorBorder: _buildBorder(AppColors.red),
      ),
      validator:
          widget.isValidator
              ? widget.validator ??
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return widget.emptyValueErrorText;
                    }
                    return null;
                  }
              : null,
    );
  }
}
