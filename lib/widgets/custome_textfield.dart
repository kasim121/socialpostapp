import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  final bool isPassword;
  final bool isPasswordVisible;

  final VoidCallback? onTogglePasswordVisibility;
  final TextInputType keyboardType;
  final TextAlign textAlign;

  const CustomTextField({
    Key? key,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePasswordVisibility,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    required String hintText, required TextEditingController controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      style: AppTextStyles.airbnbCerealText(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: AppColors.darkBackground,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  size: 16,
                  color: AppColors.textPrimary,
                ),
                onPressed: onTogglePasswordVisibility,
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
