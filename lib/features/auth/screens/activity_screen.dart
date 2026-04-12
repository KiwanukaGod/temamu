import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Activity", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text("This Month", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // --- ACTIVITY ITEM 1 (The one we just finished) ---
          _buildActivityCard(
            title: "Friday Pork Joint",
            date: "Today, 4:30 AM",
            amount: "14,500",
            status: "Settled",
            icon: Icons.celebration,
            iconColor: const Color(0xFF2563EB),
          ),
          
          const SizedBox(height: 12),
          
          // --- ACTIVITY ITEM 2 ---
          _buildActivityCard(
            title: "Boda Boda Ride",
            date: "Yesterday",
            amount: "6,000",
            status: "Settled",
            icon: Icons.moped_outlined,
            iconColor: const Color(0xFF06B6D4),
          ),

          const SizedBox(height: 32),
          const Text("Last Month", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          _buildActivityCard(
            title: "KFC Lunch",
            date: "24 Mar 2026",
            amount: "25,000",
            status: "Settled",
            icon: Icons.fastfood_outlined,
            iconColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String date,
    required String amount,
    required String status,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("UGX $amount", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(4)),
                child: Text(status, style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}