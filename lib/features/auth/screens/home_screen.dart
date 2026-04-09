import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> _titles = ["Home", "My Pools", "Activity", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. UPDATED HEADER (Simplified and Balanced)
              const SizedBox(height: 48), // Increased space for a premium feel
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedIndex == 0 ? "Hello, @username" : _titles[_selectedIndex],
                    style: const TextStyle(
                      fontSize: 28, // Slightly larger for better balance
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5, // Tighter spacing for a modern look
                    ),
                  ),
                  if (_selectedIndex == 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Ready to split the bill?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ],
              ),
              
              const SizedBox(height: 56), // More breathing room before actions

              // Main Actions (Home Tab only)
              if (_selectedIndex == 0) ...[
                _buildMainActionCard(
                  context,
                  title: "Create a Pool",
                  subtitle: "Start a new session and invite friends",
                  icon: Icons.add_circle_outline,
                  gradient: const [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                  onTap: () {
                    Navigator.pushNamed(context, '/create-pool');
                  },
                ),
                const SizedBox(height: 20), // Increased card spacing
                _buildMainActionCard(
                  context,
                  title: "Join a Pool",
                  subtitle: "Enter a code or scan a QR to contribute",
                  icon: Icons.qr_code_scanner,
                  gradient: const [Color(0xFF06B6D4), Color(0xFF0891B2)],
                  onTap: () {},
                ),
                const SizedBox(height: 56),
                const Text(
                  "Recent Pools",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 20),
                _buildRecentPoolItem("Friday Pork Joint", "Settled • 2 days ago", "UGX 150,000"),
                _buildRecentPoolItem("Boda Boda Ride", "Settled • Yesterday", "UGX 12,000"),
              ],

              // Content for other tabs
              if (_selectedIndex != 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Column(
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.grey[300], size: 64),
                        const SizedBox(height: 16),
                        Text(
                          "Your ${_titles[_selectedIndex]} will appear here.",
                          style: TextStyle(color: Colors.grey[400], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        elevation: 0, // Flat design for modern look
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'My Pools'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // --- HELPER METHODS ---

  Widget _buildMainActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: gradient),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, 
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle, 
                    style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 14)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPoolItem(String title, String subtitle, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B))),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
            ],
          ),
          Text(
            amount, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2563EB))
          ),
        ],
      ),
    );
  }
}