import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate button width as 75% of screen width, capped for larger screens
    final buttonWidth = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to the Home of Collective Prosperity, Individual Growth',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    color: Colors.green[50], // Light green tint
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            'Welcome to Anfal Sacco',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: buttonWidth,
                            child: ElevatedButton(
                              onPressed: () => context.go('/register'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700], // Algae-like green
                                minimumSize: const Size(0, 50), // Height only, width controlled by SizedBox
                              ),
                              child: const Text(
                                'Sign Up/Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: buttonWidth,
                            child: ElevatedButton(
                              onPressed: () => context.go('/login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 134, 149, 135), // Green mixed with gray
                                minimumSize: const Size(0, 50), // Height only, width controlled by SizedBox
                              ),
                              child: const Text(
                                'Sign In/Log In',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
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