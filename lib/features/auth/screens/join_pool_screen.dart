import 'package:flutter/material.dart';

class JoinPoolScreen extends StatefulWidget {
  const JoinPoolScreen({super.key});

  @override
  State<JoinPoolScreen> createState() => _JoinPoolScreenState();
}

class _JoinPoolScreenState extends State<JoinPoolScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;

  void _handleJoin() {
    if (_codeController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit code")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate "Searching for Pool..."
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        // Navigate to the Lobby as a Participant (isAdmin: false)
        Navigator.pushReplacementNamed(
          context, 
          '/pool-lobby', 
          arguments: {'isAdmin': false, 'poolName': 'Friday Pork Joint'},
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Join a Pool", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Enter the 6-digit code shared by the host to join the session.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            
            const SizedBox(height: 48),

            // --- CODE INPUT FIELD ---
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 12),
              decoration: InputDecoration(
                counterText: "", // Hide the 0/6 counter
                hintText: "000000",
                hintStyle: TextStyle(color: Colors.grey[300]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // --- JOIN BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleJoin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Join Pool", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 24),
            const Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            // --- QR SCAN PLACEHOLDER ---
            OutlinedButton.icon(
              onPressed: () {
                // Future: Integrate camera for QR scanning
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text("Scan QR Code"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                side: const BorderSide(color: Color(0xFF06B6D4)),
                foregroundColor: const Color(0xFF06B6D4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}