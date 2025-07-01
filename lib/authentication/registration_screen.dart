import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _applicantTypeController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  bool _termsAccepted = false;
  bool _navigateToLogin = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Perform registration and update state
  Future<void> _performRegistration(AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      try {
        await authProvider.register(
          _fullNameController.text,
          _applicantTypeController.text,
          _idNumberController.text,
          _genderController.text,
          _dobController.text,
        );
        if (mounted) {
          setState(() {
            _navigateToLogin = true;
          });
        }
      } catch (e) {
        // Handle error if needed (e.g., show a message later with APIs)
      }
    }
  }

  @override
  void didUpdateWidget(RegistrationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Perform navigation in a synchronous context after state update
    if (_navigateToLogin && mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN UP/REGISTER'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _applicantTypeController,
                    decoration: const InputDecoration(labelText: 'Applicant Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter applicant type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _idNumberController,
                    decoration: const InputDecoration(labelText: 'Identification Number'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter identification number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter gender';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(labelText: 'Date of Birth'),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select date of birth';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _termsAccepted = value ?? false;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () => context.go('/terms'),
                        child: const Text(
                          'I agree to the Terms & Conditions',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _termsAccepted && !authProvider.isLoading
                          ? () {
                              _performRegistration(authProvider);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(200, 50),
                      ),
                      child: authProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Sign Up/Register',
                              style: TextStyle(color: Colors.white),
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