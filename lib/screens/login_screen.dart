import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisocial/constants/app_colors.dart';

import '../blocs/user_auth_bloc.dart';
import '../constants/app_text_style.dart';
import '../widgets/custome_button.dart';
import '../widgets/custome_textfield.dart';

class NewLoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  NewLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Login",
                  style: AppTextStyles.airbnbCerealText(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  isPasswordVisible: false,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  child: BlocConsumer<UserAuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomLoginButton(
                        text: 'Sign In',
                        onPressed: () {
                          context.read<UserAuthBloc>().add(LogInEvent(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ));
                        },
                        backgroundColor: AppColors.customBlue,
                        borderRadius: 50.0,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
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
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: AppTextStyles.airbnbCerealText(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
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
}
