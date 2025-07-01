import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_app/authentication/login_screen.dart';
import 'package:sacco_app/authentication/registration_screen.dart';
import 'package:sacco_app/authentication/welcome_screen.dart';
import 'package:sacco_app/screens/home_screen.dart';
import 'package:sacco_app/screens/terms_and_conditions_screen.dart';
import 'package:sacco_app/services/auth_provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const SaccoApp());
}

class SaccoApp extends StatelessWidget {
  const SaccoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        title: 'Anfal Sacco',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const WelcomeScreen(),
            ),
            GoRoute(
              path: '/register',
              builder: (context, state) => const RegistrationScreen(),
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/terms',
              builder: (context, state) => const TermsAndConditionsScreen(),
            ),
          ],
          redirect: (context, state) {
            // Prevent app exit on back press by redirecting to WelcomeScreen if no previous route
            if (state.uri.toString() == '/' && state.matchedLocation == '/') {
              return null; // Allow WelcomeScreen to be the root
            }
            return null;
          },
        ),
      ),
    );
  }
}