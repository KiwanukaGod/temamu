import 'package:flutter/material.dart';

class MerchantPaymentScreen extends StatefulWidget {
  const MerchantPaymentScreen({super.key});

  @override
  State<MerchantPaymentScreen> createState() => _MerchantPaymentScreenState();
}

class _MerchantPaymentScreenState extends State<MerchantPaymentScreen> {
  // 1. ADD THIS STATE VARIABLE
  bool _isProcessing = false;

  // 2. ADD THE USSD POPUP LOGIC
  void _showMockUSSD() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF334155), // Classic USSD Slate Grey
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "MoMoPay\nPay UGX 14,500 to KFC CENTRAL?\nEnter PIN:",
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              autofocus: true,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, letterSpacing: 8, fontSize: 24),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _handleSuccess();       // Start the fake loading
            },
            child: const Text("SEND", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // 3. ADD THE SUCCESS HANDLER
  void _handleSuccess() {
    setState(() => _isProcessing = true);
    
    // Simulate the 2-second "Waiting for MoMo Network" delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // This takes them to the Recap and prevents them from going "Back" to pay again
        Navigator.pushNamedAndRemoveUntil(context, '/pool-recap', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Merchant Payment"), 
        centerTitle: true, 
        elevation: 0, 
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      // 4. WRAP THE BODY IN A TERNARY OPERATOR
      body: _isProcessing 
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF2563EB)),
                SizedBox(height: 24),
                Text("Confirming with MoMo...", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text("Pay to KFC Central", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                
                // MERCHANT CODE CARD
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      const Text("MoMoPay Code", style: TextStyle(color: Colors.grey)),
                      const Text("123 456", style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: 4, color: Color(0xFF1E293B))),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount Due:", style: TextStyle(fontWeight: FontWeight.w500)),
                          Text("UGX 14,500", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF2563EB))),
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
                    onPressed: _showMockUSSD, // 5. LINK TO THE POPUP
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB), 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Pay with MoMo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}