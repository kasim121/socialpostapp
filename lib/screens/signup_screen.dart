import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_auth_bloc.dart';
import 'package:tisocial/constants/app_colors.dart';

import '../constants/app_text_style.dart';
import '../widgets/custome_button.dart';
import '../widgets/custome_textfield.dart';

class NewSignUpScreen extends StatefulWidget {
  const NewSignUpScreen({super.key});

  @override
  State<NewSignUpScreen> createState() => _NewSignUpScreenState();
}

class _NewSignUpScreenState extends State<NewSignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Create Account",
                    style: AppTextStyles.airbnbCerealText(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                    hintText: 'Username',
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 16),

                  // Password TextField
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  BlocConsumer<UserAuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Sign Up Successful!")),
                        );
                        Navigator.pushReplacementNamed(context, '/login');
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is AuthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              height: 55,
                              child: CustomLoginButton(
                                text: 'Sign Up',
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context
                                        .read<UserAuthBloc>()
                                        .add(SignUpEvent(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                          usernameController.text.trim(),
                                        ));
                                  }
                                },
                                backgroundColor: AppColors.customBlue,
                                borderRadius: 50.0,
                              ),
                            );
                    },
                  ),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Already have an account? ",
                              style: AppTextStyles.airbnbCerealText(
                                color: AppColors.grayShade,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
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
      ),
    );
  }
}
