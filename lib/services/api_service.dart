import 'package:sacco_app/models/member_data.dart';

class ApiService {
  final String baseUrl = 'https://api.anfalsacco.com';

  // Authentication APIs
  Future<Map<String, dynamic>> login(String emailOrId, String password) async {
    // POST $baseUrl/auth/login
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'token': 'mock_jwt_token',
      'user': {
        'id': '12345',
        'name': 'Fabron Naligu',
        'memberNumber': 'MEM001'
      }
    };
  }

  Future<Map<String, dynamic>> register(String fullName, String applicantType, String idNumber, String gender, String dob) async {
    // POST $baseUrl/auth/register
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'message': 'Registration successful',
      'memberNumber': 'MEM${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}'
    };
  }

  // Member Data APIs
  Future<MemberData> getMemberData(String memberNumber) async {
    // GET $baseUrl/members/{memberNumber}
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return MemberData(
      memberName: 'Fabron Naligu',
      memberNumber: memberNumber,
      savingsBalance: 116000.00,
      loansBalance: 46000.00,
      capitalShares: 2000,
      sharePercent: 13.69,
      guaranteeableAmount: 70000.00,
    );
  }

  Future<List<TransactionData>> getTransactionHistory(String memberNumber) async {
    // GET $baseUrl/members/{memberNumber}/transactions
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return [
      TransactionData(
        id: 'TXN001',
        type: 'Savings Deposit',
        amount: 5000.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Completed',
        description: 'Monthly savings deposit',
      ),
      TransactionData(
        id: 'TXN002',
        type: 'Loan Payment',
        amount: 3000.00,
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: 'Completed',
        description: 'Loan installment payment',
      ),
    ];
  }

  // Savings APIs
  Future<Map<String, dynamic>> initiateSavingsPayment(String memberNumber, double amount) async {
    // POST $baseUrl/savings/deposit
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'transactionId': 'SAV${DateTime.now().millisecondsSinceEpoch}',
      'paybill': '8751990',
      'accountNumber': memberNumber,
      'amount': amount,
    };
  }

  Future<Map<String, dynamic>> confirmSavingsPayment(String transactionId) async {
    // POST $baseUrl/savings/confirm
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'message': 'Savings payment confirmed',
      'newBalance': 121000.00,
    };
  }

  // Loan APIs
  Future<Map<String, dynamic>> calculateLoanEligibility(String memberNumber) async {
    // GET $baseUrl/loans/eligibility/{memberNumber}
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'maxLoanAmount': 150000.00,
      'interestRate': 1.0, // 1% per month
      'maxTerm': 36, // months
    };
  }

  Future<List<GuarantorData>> getAvailableGuarantors(String memberNumber) async {
    // GET $baseUrl/guarantors/available/{memberNumber}
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return [
      GuarantorData(
        memberName: 'Jane Smith',
        memberNumber: 'MEM002',
        guaranteedAmount: 0,
        availableAmount: 50000.00,
      ),
      GuarantorData(
        memberName: 'Bob Johnson',
        memberNumber: 'MEM003',
        guaranteedAmount: 0,
        availableAmount: 75000.00,
      ),
      GuarantorData(
        memberName: 'Alice Brown',
        memberNumber: 'MEM004',
        guaranteedAmount: 0,
        availableAmount: 60000.00,
      ),
    ];
  }

  Future<Map<String, dynamic>> submitLoanRequest(
    String memberNumber,
    double requestedAmount,
    List<Map<String, dynamic>> guarantors,
  ) async {
    // POST $baseUrl/loans/request
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'loanRequestNumber': 'LRQ${DateTime.now().millisecondsSinceEpoch}',
      'message': 'Loan request submitted successfully',
      'estimatedProcessingTime': '2-3 business days',
    };
  }

  Future<LoanData> getCurrentLoan(String memberNumber) async {
    // GET $baseUrl/loans/current/{memberNumber}
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return LoanData(
      loanId: 'LOAN001',
      requestedAmount: 50000.00,
      approvedAmount: 46000.00,
      outstandingBalance: 38000.00,
      installmentAmount: 2500.00,
      nextPaymentDate: DateTime.now().add(const Duration(days: 15)),
      monthsLeft: 15,
      status: 'Active',
      guarantors: [],
    );
  }

  Future<Map<String, dynamic>> initiateLoanPayment(String memberNumber, double amount) async {
    // POST $baseUrl/loans/payment
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'transactionId': 'LP${DateTime.now().millisecondsSinceEpoch}',
      'paybill': '8751990',
      'accountNumber': '$memberNumber - loan payment',
      'amount': amount,
    };
  }

  Future<Map<String, dynamic>> confirmLoanPayment(String transactionId) async {
    // POST $baseUrl/loans/payment/confirm
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'message': 'Loan payment confirmed',
      'newBalance': 35500.00,
      'nextPaymentDate': DateTime.now().add(const Duration(days: 30)),
      'nextInstallmentAmount': 2500.00,
      'monthsLeft': 14,
    };
  }

  // Capital Share APIs
  Future<Map<String, dynamic>> topUpCapitalShare(String memberNumber, double amount) async {
    // POST $baseUrl/capital-shares/topup
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'transactionId': 'CS${DateTime.now().millisecondsSinceEpoch}',
      'newShareBalance': 2500,
      'newSharePercent': 15.2,
    };
  }

  // Contact APIs
  Future<Map<String, dynamic>> submitContactMessage(String memberNumber, String subject, String message) async {
    // POST $baseUrl/contact/message
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // Mock response - replace with actual API call
    return {
      'success': true,
      'ticketNumber': 'TKT${DateTime.now().millisecondsSinceEpoch}',
      'message': 'Your message has been submitted successfully',
    };
  }
}