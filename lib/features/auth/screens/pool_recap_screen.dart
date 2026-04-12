import 'package:flutter/material.dart';

class PoolRecapScreen extends StatelessWidget {
  const PoolRecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(Icons.check_circle_rounded, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              const Text("Payment Successful!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(
                "Your share for 'Friday Pork Joint' has been settled. Wait for others to finish.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              const SizedBox(height: 48),
              
              // RECAP CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount Paid", style: TextStyle(color: Colors.grey)),
                        Text("UGX 14,500", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Transaction ID", style: TextStyle(color: Colors.grey)),
                        Text("TXN-99201", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E293B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Back to Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}