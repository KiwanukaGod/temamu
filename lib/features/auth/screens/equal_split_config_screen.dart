import 'package:flutter/material.dart';

class EqualSplitConfigScreen extends StatefulWidget {
  const EqualSplitConfigScreen({super.key});

  @override
  State<EqualSplitConfigScreen> createState() => _EqualSplitConfigScreenState();
}

class _EqualSplitConfigScreenState extends State<EqualSplitConfigScreen> {
  // Mock total from the previous screen
  double totalBill = 150000; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Equal Split", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Icon(Icons.auto_awesome_motion_outlined, size: 64, color: Color(0xFF2563EB)),
              const SizedBox(height: 24),
              const Text(
                "Everything will be divided equally among all participants in the lobby.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              
              const Spacer(flex: 1),

              // --- PREVIEW CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    const Text("Total Bill", style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 8),
                    const Text(
                      "UGX 150,000",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(),
                    ),
                    const Text("Estimated Share", style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 12),
                    _buildPreviewRow("If 2 people join:", "UGX 75,000"),
                    const SizedBox(height: 12),
                    _buildPreviewRow("If 4 people join:", "UGX 37,500"),
                    const SizedBox(height: 12),
                    _buildPreviewRow("If 5 people join:", "UGX 30,000"),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // --- ACTION BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-participants');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Next: Add Participants", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
        Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
      ],
    );
  }
}