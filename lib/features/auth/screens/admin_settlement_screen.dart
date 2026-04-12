import 'package:flutter/material.dart';

class AdminSettlementScreen extends StatefulWidget {
  const AdminSettlementScreen({super.key});

  @override
  State<AdminSettlementScreen> createState() => _AdminSettlementScreenState();
}

class _AdminSettlementScreenState extends State<AdminSettlementScreen> {
  // Mock data representing participants in various states
  final List<Map<String, dynamic>> _participants = [
    {"name": "Sarah Namuli", "amount": "14,500", "status": "Paid", "method": "Merchant"},
    {"name": "Alex Mukasa", "amount": "22,000", "status": "Confirm?", "method": "Manual"},
    {"name": "John Doe", "amount": "14,500", "status": "Pending", "method": "Merchant"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text("Pool Progress"), centerTitle: true, elevation: 0),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _participants.length,
              itemBuilder: (context, index) => _buildParticipantCard(_participants[index], index),
            ),
          ),
          _buildFooterAction(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    int paidCount = _participants.where((p) => p['status'] == "Paid").length;
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        children: [
          const Text("Friday Pork Joint", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: paidCount / _participants.length,
            backgroundColor: Colors.grey[200],
            color: Colors.green,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text("$paidCount of ${_participants.length} settled", style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildParticipantCard(Map<String, dynamic> person, int index) {
    bool needsConfirmation = person['status'] == "Confirm?";
    bool isPaid = person['status'] == "Paid";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isPaid ? Colors.green[50] : Colors.orange[50],
            child: Icon(isPaid ? Icons.check : Icons.access_time, color: isPaid ? Colors.green : Colors.orange),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(person['method'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          if (needsConfirmation)
            ElevatedButton(
              onPressed: () => setState(() => _participants[index]['status'] = "Paid"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06B6D4)),
              child: const Text("Confirm Cash", style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          else
            Text("UGX ${person['amount']}", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildFooterAction() {
    bool allPaid = _participants.every((p) => p['status'] == "Paid");
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: allPaid ? () => Navigator.pushNamed(context, '/pool-recap') : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E293B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text("End Session", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}