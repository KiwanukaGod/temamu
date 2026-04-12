import 'package:flutter/material.dart';

class MyPoolsScreen extends StatelessWidget {
  const MyPoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("My Pools", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Color(0xFF2563EB),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF2563EB),
            indicatorWeight: 3,
            tabs: [
              Tab(text: "Active"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildActivePools(),
            _buildPoolHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildActivePools() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildPoolCard(
          name: "Friday Pork Joint",
          date: "Just now",
          total: "150,000",
          yourShare: "14,500",
          status: "In Lobby",
          role: "Host",
          statusColor: const Color(0xFF2563EB),
        ),
      ],
    );
  }

  Widget _buildPoolHistory() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildPoolCard(
          name: "Boda Boda Ride",
          date: "Yesterday",
          total: "12,000",
          yourShare: "6,000",
          status: "Settled",
          role: "Participant",
          statusColor: Colors.green,
        ),
        _buildPoolCard(
          name: "KFC Lunch",
          date: "24 Mar 2026",
          total: "80,000",
          yourShare: "20,000",
          status: "Settled",
          role: "Host",
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildPoolCard({
    required String name,
    required String date,
    required String total,
    required String yourShare,
    required String status,
    required String role,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat("Total Bill", "UGX $total"),
              _buildMiniStat("Your Share", "UGX $yourShare"),
              _buildMiniStat("Role", role),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}