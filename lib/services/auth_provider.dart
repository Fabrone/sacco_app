import 'package:flutter/material.dart';
import 'api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login(String emailOrId, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Mock API call - replace with real API endpoint
      await _apiService.login(emailOrId, password);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> register(String fullName, String applicantType, String idNumber, String gender, String dob) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Mock API call - replace with real API endpoint
      await _apiService.register(fullName, applicantType, idNumber, gender, dob);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}