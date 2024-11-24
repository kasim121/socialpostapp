import 'package:flutter/material.dart';

import '../../features/auth/presentaion/screens/login_screen.dart';
import '../../features/auth/presentaion/screens/signup_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignUpScreen(),
      // '/home': (context) => const MainHomeScreen(),
      // '/sampleshoe': (context) => const SampleShoeScreen(),
      // '/myCart': (context) => const MyCartScreen(),
    };
  }
}
