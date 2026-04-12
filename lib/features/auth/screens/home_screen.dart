import 'package:flutter/material.dart';
import 'notifications_screen.dart'; // Ensure this file exists!

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // 1. THE TAB CONTROLLER
  late final List<Widget> _screens = [
    _buildHomeBody(),              // Index 0: Dashboard (Actions + Activity)
    const Center(child: Text("My Pools coming soon")), // Index 1
    const NotificationsScreen(),    // Index 2: THE NEW NOTIFICATIONS TAB
    const Center(child: Text("Profile coming soon")),  // Index 3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // IndexedStack keeps the state of each tab alive when you switch back and forth
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey[400],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: "My Pools"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // 2. THE DASHBOARD UI (Actions + Recent Activity)
  Widget _buildHomeBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello, @username", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const Text("Ready to split the bill?", style: TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 32),
            
            // --- ACTION CARDS ---
            _buildActionCard(
              title: "Create a Pool",
              subtitle: "Start a session and invite friends",
              icon: Icons.add_circle_outline,
              color: const Color(0xFF2563EB),
              onTap: () => Navigator.pushNamed(context, '/create-pool'),
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              title: "Join a Pool",
              subtitle: "Enter a code or scan a QR",
              icon: Icons.qr_code_scanner,
              color: const Color(0xFF06B6D4),
              onTap: () => Navigator.pushNamed(context, '/join-pool'),
            ),
            
            const SizedBox(height: 40),

            // --- RECENT ACTIVITY SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {}, 
                  child: const Text("See All", style: TextStyle(color: Color(0xFF2563EB)))
                ),
              ],
            ),
            
            const SizedBox(height: 8),

            _buildRecentActivityItem(
              title: "Friday Pork Joint",
              amount: "14,500",
              date: "Today, 4:30 AM",
              icon: Icons.celebration_outlined,
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildRecentActivityItem(
              title: "Boda Boda Ride",
              amount: "6,000",
              date: "Yesterday",
              icon: Icons.moped_outlined,
              color: const Color(0xFF06B6D4),
            ),
            const SizedBox(height: 12),
            _buildRecentActivityItem(
              title: "KFC Lunch",
              amount: "25,000",
              date: "24 Mar 2026",
              icon: Icons.fastfood_outlined,
              color: const Color(0xFF2563EB),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI HELPERS ---

  Widget _buildActionCard({required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivityItem({required String title, required String amount, required String date, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0).withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(date, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          Text("UGX $amount", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        ],
      ),
    );
  }
}