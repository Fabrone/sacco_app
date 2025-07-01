import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildCard(
                        context,
                        title: 'Savings',
                        value: 'KSH 00.00',
                        backgroundColor: const Color.fromARGB(255, 146, 241, 154),
                        textTheme: textTheme,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: _buildCard(
                        context,
                        title: 'Loans',
                        value: 'KSH 00.00',
                        backgroundColor: const Color.fromARGB(230, 234, 177, 148),
                        textTheme: textTheme,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: _buildCard(
                        context,
                        title: 'Capital Share',
                        value: 'Shares 00.00',
                        subtitle: 'Percent 0.00%',
                        backgroundColor: const Color.fromARGB(255, 141, 180, 208),
                        textTheme: textTheme,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: _buildCard(
                        context,
                        title: 'Guarantee-able',
                        value: 'KSH 00.00',
                        backgroundColor: const Color.fromARGB(255, 248, 250, 135),
                        textTheme: textTheme,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32), // Padding for future items
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String value,
    String? subtitle,
    required Color backgroundColor,
    required TextTheme textTheme,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Container(
        height: 100, // Reduced height to prevent overflow
        padding: const EdgeInsets.all(8.0), // Reduced padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black, // Changed to black
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: textTheme.bodySmall?.copyWith(color: Colors.black), // Changed to black
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: 10, // Smaller font for subtitle
                  color: Colors.black, // Changed to black
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}