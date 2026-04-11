import 'package:flutter/material.dart';

class WalletSplitConfigScreen extends StatefulWidget {
  const WalletSplitConfigScreen({super.key});

  @override
  State<WalletSplitConfigScreen> createState() => _WalletSplitConfigScreenState();
}

class _WalletSplitConfigScreenState extends State<WalletSplitConfigScreen> {
  // Mock data for the "Wallets" or "Pockets"
  final List<Map<String, dynamic>> _wallets = [
    {"name": "The Kampala Crew", "amount": 80000},
    {"name": "Family Table", "amount": 120000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Shared Wallets", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Create sub-groups (Wallets). One person in each group will be responsible for the group's total payment.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // --- ADD WALLET FORM ---
              const Text("Create a New Wallet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Wallet Name",
                        hintText: "e.g. Roommates",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Amount",
                        hintText: "0.00",
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_box, color: Color(0xFF2563EB), size: 40),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // --- WALLET LIST ---
              const Text("Active Wallets", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _wallets.length,
                  itemBuilder: (context, index) {
                    return _buildWalletCard(_wallets[index]['name'], _wallets[index]['amount']);
                  },
                ),
              ),

              // --- SUMMARY & NAVIGATION ---
              const Divider(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Allocated:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("UGX 200,000", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                ],
              ),
              const SizedBox(height: 24),

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

  Widget _buildWalletCard(String name, int amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF06B6D4)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text("Sub-group", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text("UGX $amount", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const SizedBox(width: 12),
          const Icon(Icons.edit_note_outlined, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}