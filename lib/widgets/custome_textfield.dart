import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePasswordVisibility;
  final TextInputType keyboardType;
  final TextAlign textAlign;

  final String hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    Key? key,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePasswordVisibility,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    required this.hintText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible =
        widget.isPasswordVisible; // Initialize with the passed value
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
    if (widget.onTogglePasswordVisibility != null) {
      widget.onTogglePasswordVisibility!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword && !_isPasswordVisible,
      keyboardType: widget.keyboardType,
      style: AppTextStyles.airbnbCerealText(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.airbnbCerealText(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: AppColors.darkBackground,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
