import 'package:flutter/material.dart';

class CreatePoolScreen extends StatefulWidget {
  const CreatePoolScreen({super.key});

  @override
  State<CreatePoolScreen> createState() => _CreatePoolScreenState();
}

class _CreatePoolScreenState extends State<CreatePoolScreen> {
  String selectedMethod = 'Equal'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("New Payment Pool", 
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Bill Basics
            const Text("The Basics", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: "Pool Title",
                hintText: "e.g., Friday Pork Joint",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.celebration_outlined),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "Total Bill Amount",
                hintText: "UGX 0.00",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 32),

            // Section 2: Merchant Info
            const Text("Merchant Details", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: "Merchant Name",
                hintText: "e.g., KFC Central",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.storefront),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "MoMoPay Code",
                hintText: "6-digit code",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.qr_code_2),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 32),

            // Section 3: Split Method Selection (Now with 4 options)
            const Text("Choose Split Method", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
            const SizedBox(height: 16),
            
            _buildSplitOption("Equal", "Everyone pays the same amount", Icons.groups_outlined),
            _buildSplitOption("Itemized", "Each person picks what they ate", Icons.receipt_long_outlined),
            _buildSplitOption("Percentage", "Split by agreed responsibility", Icons.percent_outlined),
            _buildSplitOption("Shared Wallet", "Allow sub-groups to pay together", Icons.account_balance_outlined),

            const SizedBox(height: 48),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigation logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Next: Add Participants", 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitOption(String title, String subtitle, IconData icon) {
    bool isSelected = selectedMethod == title;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB).withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2563EB).withOpacity(0.1) : Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: isSelected ? const Color(0xFF2563EB) : Colors.grey[400], size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 15,
                    color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF1E293B)
                  )),
                  Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ],
              ),
            ),
            if (isSelected) 
              const Icon(Icons.check_circle, color: Color(0xFF2563EB), size: 20),
          ],
        ),
      ),
    );
  }
}