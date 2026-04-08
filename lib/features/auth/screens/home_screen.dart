import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Very light grey/blue background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // 1. HEADER: Personalized Greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, @username",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
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

              // 2. MAIN ACTIONS: Create & Join
              _buildMainActionCard(
                context,
                title: "Create a Pool",
                subtitle: "Start a new session and invite friends",
                icon: Icons.add_circle_outline,
                gradient: const [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                onTap: () {
                  // Navigate to Create Pool Flow later
                },
              ),
              const SizedBox(height: 16),
              _buildMainActionCard(
                context,
                title: "Join a Pool",
                subtitle: "Enter a code or scan a QR to contribute",
                icon: Icons.qr_code_scanner,
                gradient: const [Color(0xFF06B6D4), Color(0xFF0891B2)],
                onTap: () {
                  // Navigate to Join Pool Flow later
                },
              ),

              const SizedBox(height: 48),

              // 3. RECENT ACTIVITY SECTION
              const Text(
                "Recent Pools",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),
              
              // Placeholder for a list of recent pools
              _buildRecentPoolItem("Friday Pork Joint", "Settled • 2 days ago", "UGX 150,000"),
              _buildRecentPoolItem("Boda Boda Ride", "Settled • Yesterday", "UGX 12,000"),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      // 4. BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  // Helper Widget for the large buttons
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
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for the list items
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
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
          ),
        ],
      ),
    );
  }
}