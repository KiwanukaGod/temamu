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
              const SizedBox(height: 24),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedIndex == 0 ? "Hello, @username" : _titles[_selectedIndex],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      if (_selectedIndex == 0)
                        Text(
                          "Ready to split the bill?",
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFFE2E8F0),
                    child: Icon(Icons.person, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),

              // The IF Statement block you were working on
              if (_selectedIndex == 0) ...[
                _buildMainActionCard(
                  context,
                  title: "Create a Pool",
                  subtitle: "Start a new session and invite friends",
                  icon: Icons.add_circle_outline,
                  gradient: const [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                  onTap: () {
                    // We will link this to the Create Pool screen next
                  },
                ),
                const SizedBox(height: 16),
                _buildMainActionCard(
                  context,
                  title: "Join a Pool",
                  subtitle: "Enter a code or scan a QR to contribute",
                  icon: Icons.qr_code_scanner,
                  gradient: const [Color(0xFF06B6D4), Color(0xFF0891B2)],
                  onTap: () {},
                ),
                const SizedBox(height: 48),
                const Text(
                  "Recent Pools",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildRecentPoolItem("Friday Pork Joint", "Settled • 2 days ago", "UGX 150,000"),
                _buildRecentPoolItem("Boda Boda Ride", "Settled • Yesterday", "UGX 12,000"),
              ],

              if (_selectedIndex != 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      "Your ${_titles[_selectedIndex]} will appear here.",
                      style: TextStyle(color: Colors.grey[400]),
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
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'My Pools'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  // --- HELPER METHODS (These were missing in your screenshot) ---

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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: gradient),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
            ],
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
        ],
      ),
    );
  }
}