import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/register'),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Placeholder for Terms & Conditions content.\n\n'
            'Please provide the actual terms and conditions to be displayed here.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}