import 'package:flutter/material.dart';

class ManualPaymentScreen extends StatefulWidget {
  const ManualPaymentScreen({super.key});

  @override
  State<ManualPaymentScreen> createState() => _ManualPaymentScreenState();
}

class _ManualPaymentScreenState extends State<ManualPaymentScreen> {
  bool _notified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text("Manual Settlement"), centerTitle: true, backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.handshake_rounded, size: 100, color: Color(0xFF06B6D4)),
            const SizedBox(height: 32),
            const Text("Pay Cash to the Host", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              "Please hand over UGX 14,500 to @alex_m. Once they receive it, they will confirm your payment.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            
            _notified 
              ? Column(
                  children: const [
                    CircularProgressIndicator(color: Color(0xFF06B6D4)),
                    SizedBox(height: 16),
                    Text("Host notified. Waiting for confirmation...", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              : SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _notified = true),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06B6D4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text("I've Paid Cash", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}