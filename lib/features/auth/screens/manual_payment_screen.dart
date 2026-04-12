import 'package:flutter/material.dart';

class ManualPaymentScreen extends StatefulWidget {
  const ManualPaymentScreen({super.key});

  @override
  State<ManualPaymentScreen> createState() => _ManualPaymentScreenState();
}

class _ManualPaymentScreenState extends State<ManualPaymentScreen> {
  bool _isWaiting = false;

  void _notifyHost() {
    setState(() => _isWaiting = true);
    // In a real app, this would send a push notification to the Admin.
    // For our MVP, we'll just show the "Waiting" state.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Manual Payment"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: !_isWaiting, // Disable back button while waiting
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(
              _isWaiting ? Icons.hourglass_top_rounded : Icons.handshake_outlined,
              size: 100,
              color: const Color(0xFF06B6D4),
            ),
            const SizedBox(height: 32),
            Text(
              _isWaiting ? "Notification Sent!" : "Pay Cash to Host",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              _isWaiting 
                ? "Wait for @host to confirm they've received your UGX 14,500. You'll be notified once settled."
                : "Please hand over UGX 14,500 to the pool creator. After paying, tap the button below to notify them.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const Spacer(),
            
            if (!_isWaiting)
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _notifyHost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06B6D4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Notify Host I've Paid", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            else
              const CircularProgressIndicator(color: Color(0xFF06B6D4)),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}