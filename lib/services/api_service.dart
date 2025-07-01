class ApiService {
  final String baseUrl = 'https://api.anfalsacco.com';

  Future<void> login(String emailOrId, String password) async {
    // Example: POST $baseUrl/login with { emailOrId, password }
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API response parsing
    return;
  }

  Future<void> register(String fullName, String applicantType, String idNumber, String gender, String dob) async {
    // Example: POST $baseUrl/register with { fullName, applicantType, idNumber, gender, dob }
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API response parsing
    return;
  }
}