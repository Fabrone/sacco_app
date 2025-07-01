import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_app/authentication/login_screen.dart';
import 'package:sacco_app/authentication/registration_screen.dart';
import 'package:sacco_app/authentication/welcome_screen.dart';
import 'package:sacco_app/screens/home_screen.dart';
import 'package:sacco_app/screens/terms_and_conditions_screen.dart';
import 'package:sacco_app/services/auth_provider.dart';

void main() {
  runApp(const SaccoApp());
}

class SaccoApp extends StatelessWidget {
  const SaccoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Anfal Sacco',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
        routes: {
          '/register': (context) => const RegistrationScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/terms': (context) => const TermsAndConditionsScreen(),
        },
      ),
    );
  }
}