import 'package:flutter/material.dart';
import 'package:tisocial/features/auth/presentaion/widgets/custome_login_textfield.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../config/themes/app_text_style.dart';
import '../widgets/custom_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                _buildHeading('Login'),
                const SizedBox(height: 100),
                _buildInputLabel('Email Address'),
                const SizedBox(height: 8),
                const CustomTextField(
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildInputLabel('Password'),
                const SizedBox(height: 8),
                const CustomTextField(
                  hintText: 'Enter your password',
                  isPassword: true,
                  isPasswordVisible: false,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add password recovery functionality here
                    },
                    child: Text(
                      'Recovery Password',
                      style: AppTextStyles.airbnbCerealText(
                        color: AppColors.grayShade,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  child: CustomLoginButton(
                    text: 'Sign In',
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    backgroundColor: AppColors.customBlue,
                    borderRadius: 50.0,
                  ),
                ),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Don't have an account? ",
                            style: AppTextStyles.airbnbCerealText(
                              color: AppColors.grayShade,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: AppTextStyles.airbnbCerealText(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
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
      ),
    );
  }

  // Reusable method for building text labels
  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.airbnbCerealText(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      textAlign: TextAlign.start,
    );
  }

  // Reusable method for building the screen heading
  Widget _buildHeading(String title) {
    return Text(
      title,
      style: AppTextStyles.airbnbCerealText(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 28,
      ),
      textAlign: TextAlign.center,
    );
  }
}
