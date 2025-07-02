import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_app/services/member_provider.dart';
import 'package:sacco_app/widgets/quick_action_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: kIsWeb
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed('/login'),
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.green[100],
              child: const Icon(
                Icons.person,
                color: Colors.green,
                size: 24,
              ),
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
                    // Balance Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildBalanceCard(
                            'Savings',
                            'KSH ${memberData.savingsBalance.toStringAsFixed(2)}',
                            const Color.fromARGB(255, 146, 241, 154),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildBalanceCard(
                            'Loans',
                            'KSH ${memberData.loansBalance.toStringAsFixed(2)}',
                            const Color.fromARGB(230, 234, 177, 148),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildBalanceCard(
                            'Capital Share',
                            '${memberData.sharePercent.toStringAsFixed(2)}%\n${memberData.capitalShares.toInt()} Shares',
                            const Color.fromARGB(255, 141, 180, 208),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildBalanceCard(
                            'Guarantee-able',
                            'KSH ${memberData.guaranteeableAmount.toStringAsFixed(2)}',
                            const Color.fromARGB(255, 248, 250, 135),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Quick Actions Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green[200]!),
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
                          Row(
                            children: [
                              QuickActionButton(
                                title: 'SAVE',
                                icon: Icons.savings,
                                onPressed: () => Navigator.pushNamed(context, '/savings-payment'),
                              ),
                              const SizedBox(width: 8),
                              QuickActionButton(
                                title: 'LOAN REQUEST',
                                icon: Icons.request_quote,
                                onPressed: () => Navigator.pushNamed(context, '/loan-request'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              QuickActionButton(
                                title: 'PAY LOAN',
                                icon: Icons.payment,
                                onPressed: () => Navigator.pushNamed(context, '/loan-payment'),
                              ),
                              const SizedBox(width: 8),
                              QuickActionButton(
                                title: 'TOP-UP CAPITAL SHARE',
                                icon: Icons.trending_up,
                                onPressed: () => Navigator.pushNamed(context, '/capital-topup'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              QuickActionButton(
                                title: 'MEMBER HISTORY',
                                icon: Icons.history,
                                onPressed: () => Navigator.pushNamed(context, '/transactions'),
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
            icon: Icon(Icons.history),
            label: 'My Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_support),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBalanceCard(String title, String value, Color backgroundColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}