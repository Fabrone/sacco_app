import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/member_provider.dart';
import '../widgets/quick_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load member data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final memberProvider = Provider.of<MemberProvider>(context, listen: false);
      memberProvider.loadMemberData('MEM001'); // Mock member number
      memberProvider.loadCurrentLoan('MEM001');
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        Navigator.pushNamed(context, '/transactions');
        break;
      case 2:
        Navigator.pushNamed(context, '/contact');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Handle back button - navigate to welcome screen instead of exiting
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'HOME',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          // Remove back button for non-web platforms
          automaticallyImplyLeading: kIsWeb,
          leading: kIsWeb
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed('/login'),
                )
              : null,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  // Menu action - can be implemented later
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer<MemberProvider>(
            builder: (context, memberProvider, child) {
              if (memberProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final memberData = memberProvider.memberData;
              if (memberData == null) {
                return const Center(child: Text('Failed to load member data'));
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Balance Cards Row - All four in one row
                      Row(
                        children: [
                          Expanded(
                            child: _buildBalanceCard(
                              'Savings',
                              _formatCurrency(memberData.savingsBalance),
                              null,
                              const Color.fromARGB(255, 146, 241, 154),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: _buildBalanceCard(
                              'Loans',
                              _formatCurrency(memberData.loansBalance),
                              null,
                              const Color.fromARGB(230, 234, 177, 148),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: _buildCapitalShareCard(
                              memberData.capitalShares.toInt(),
                              memberData.sharePercent,
                              const Color.fromARGB(255, 141, 180, 208),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: _buildBalanceCard(
                              'Guarantee-able',
                              _formatCurrency(memberData.guaranteeableAmount),
                              null,
                              const Color.fromARGB(255, 248, 250, 135),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Custom Separator Bar
                      _buildSeparatorBar(),
                      const SizedBox(height: 24),
                      
                      // Quick Actions Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Quick Actions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // First row - 3 buttons
                            Row(
                              children: [
                                QuickActionButton(
                                  title: 'SAVE',
                                  icon: Icons.savings,
                                  onPressed: () => Navigator.pushNamed(context, '/savings-payment'),
                                  backgroundColor: const Color.fromARGB(255, 200, 245, 210), // Watery green
                                ),
                                const SizedBox(width: 8),
                                QuickActionButton(
                                  title: 'LOAN REQUEST',
                                  icon: Icons.request_quote,
                                  onPressed: () => Navigator.pushNamed(context, '/loan-request'),
                                  backgroundColor: const Color.fromARGB(255, 200, 245, 210), // Watery green
                                ),
                                const SizedBox(width: 8),
                                QuickActionButton(
                                  title: 'PAY LOAN',
                                  icon: Icons.payment,
                                  onPressed: () => Navigator.pushNamed(context, '/loan-payment'),
                                  backgroundColor: const Color.fromARGB(255, 200, 245, 210), // Watery green
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Second row - 2 buttons
                            Row(
                              children: [
                                QuickActionButton(
                                  title: 'TOP-UP CAPITAL SHARE',
                                  icon: Icons.trending_up,
                                  onPressed: () => Navigator.pushNamed(context, '/capital-topup'),
                                  backgroundColor: const Color.fromARGB(255, 200, 245, 210), // Watery green
                                ),
                                const SizedBox(width: 8),
                                QuickActionButton(
                                  title: 'MEMBER HISTORY',
                                  icon: Icons.history,
                                  onPressed: () => Navigator.pushNamed(context, '/transactions'),
                                  backgroundColor: const Color.fromARGB(255, 200, 245, 210), // Watery green
                                ),
                                const SizedBox(width: 8),
                                const Expanded(child: SizedBox()), // Empty space for alignment
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), // Better icon for transactions
              label: 'My Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), // Better icon for contact
              label: 'Contact',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  // Helper method to format currency with thousands separators
  String _formatCurrency(double amount) {
    String amountStr = amount.toStringAsFixed(2);
    List<String> parts = amountStr.split('.');
    String integerPart = parts[0];
    String decimalPart = parts[1];
    
    // Add commas for thousands separator
    String formattedInteger = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger += ',';
      }
      formattedInteger += integerPart[i];
    }
    
    return 'KSH $formattedInteger.$decimalPart';
  }

  // Custom separator bar widget with improved styling
  Widget _buildSeparatorBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        int diamondCount = (screenWidth / 80).floor().clamp(3, 4); // 3-4 diamonds based on screen width
        
        return SizedBox(
          height: 30, // Increased height to accommodate wider separation
          width: double.infinity,
          child: Stack(
            children: [
              // Top horizontal line (black)
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.black, // Changed to black
                ),
              ),
              // Bottom horizontal line (black)
              Positioned(
                top: 20, // Increased separation (was 12, now 20)
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: Colors.black, // Changed to black
                ),
              ),
              // Yellow diamonds - darker, shorter height, wider
              ...List.generate(diamondCount, (index) {
                double spacing = screenWidth / (diamondCount + 1);
                double leftPosition = spacing * (index + 1) - 10; // Adjusted for wider diamond
                
                return Positioned(
                  top: 9, // Centered between the lines
                  left: leftPosition,
                  child: Transform.rotate(
                    angle: 0.785398, // 45 degrees in radians
                    child: Container(
                      width: 20, // Increased width (was 16)
                      height: 12, // Decreased height (was 16)
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 165, 32), // Darker yellow (goldenrod)
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBalanceCard(String title, String value, String? subtitle, Color backgroundColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Special card for Capital Share with two columns
  Widget _buildCapitalShareCard(int shares, double percent, Color backgroundColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Capital Share',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Two columns with underlined headers
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Shares',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        shares.toString(),
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Percent',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${percent.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}