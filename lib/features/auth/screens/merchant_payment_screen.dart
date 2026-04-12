import 'package:flutter/material.dart';

class MerchantPaymentScreen extends StatelessWidget {
  const MerchantPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Merchant Payment"), centerTitle: true, elevation: 0, backgroundColor: Colors.white),
      body: Padding(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                onPressed: () => _showMockUSSD(context), // Trigger the USSD Mock we discussed
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text("Pay with MoMo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMockUSSD(BuildContext context) {
    // We'll reuse the USSD Mock code here to show the PIN popup
  }
}