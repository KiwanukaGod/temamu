import 'package:flutter/material.dart';
import 'package:temamu/core/services/session_service.dart';
import 'package:temamu/features/home/screens/my_pools_screen.dart';
import 'package:temamu/features/home/screens/activity_screen.dart';
import 'package:temamu/features/home/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Tabs for the Bottom Navigation
  late final List<Widget> _screens = [
    _buildHomeBody(),
    const MyPoolsScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: "My Pools",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Activity"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- DYNAMIC GREETING ---
            FutureBuilder<String>(
              future: SessionService.getUserName(),
              builder: (context, snapshot) {
                String name = snapshot.data ?? "username";
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, $name",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Ready to split the bill?",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),

            // --- CREATE POOL CARD ---
            _buildActionCard(
              title: "Create a Pool",
              subtitle: "Start a new session and invite friends",
              icon: Icons.add_circle_outline,
              color: const Color(0xFF2563EB),
              onTap: () => Navigator.pushNamed(context, '/create-pool'),
            ),

            const SizedBox(height: 16),

            // --- JOIN POOL CARD ---
            _buildActionCard(
              title: "Join a Pool",
              subtitle: "Enter a code or scan a QR to contribute",
              icon: Icons.qr_code_scanner,
              color: const Color(0xFF06B6D4),
              onTap: () => Navigator.pushNamed(context, '/join-pool'),
            ),

            const SizedBox(height: 40),

            // --- RECENT POOLS SECTION ---
            const Text(
              "Recent Pools",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),

            _buildRecentPoolItem(
              "Friday Pork Joint",
              "UGX 150,000",
              "Settled • 2 days ago",
            ),
            const SizedBox(height: 12),
            _buildRecentPoolItem(
              "Boda Boda Ride",
              "UGX 12,000",
              "Settled • 3 days ago",
            ),
          ],
        ),
      ),
    );
  }

  // Card Builder helper
  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.3,
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

  // Recent Pool Item helper
  Widget _buildRecentPoolItem(String name, String amount, String status) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF2563EB),
            ),
          ),
        ],
      ),
    );
  }
}
