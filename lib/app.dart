import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/post_bloc.dart';
import 'blocs/user_auth_bloc.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Listen to auth state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final bool isUserLoggedIn = snapshot.hasData && snapshot.data != null;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => UserAuthBloc()),
            BlocProvider(create: (_) => PostBloc()..add(FetchPostsEvent())),
          ],
          child: MaterialApp(
            initialRoute: isUserLoggedIn ? '/home' : '/login',
            routes: {
              '/login': (_) => NewLoginScreen(),
              '/signup': (_) => const NewSignUpScreen(),
              '/home': (_) => const NewHomeScreen(),
            },
          ),
        );
      },
    );
  }
}
