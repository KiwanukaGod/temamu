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
        title: const Text(
          "New Payment Pool", 
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)
        ),
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
              const SizedBox(height: 16), // Padding from AppBar

              // --- SECTION 1: THE BASICS ---
              const Text(
                "The Basics", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Pool Title",
                  hintText: "e.g., Friday Pork Joint",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.celebration_outlined, size: 22),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Total Bill Amount",
                  hintText: "UGX 0.00",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined, size: 22),
                ),
                keyboardType: TextInputType.number,
              ),

              // --- THE REQUESTED GAP ---
              // This 40px gap creates the "Section Break" you're looking for
              const SizedBox(height: 40), 

              // --- SECTION 2: CHOOSE OPTION ---
              const Text(
                "Choose Split Method", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))
              ),
              const SizedBox(height: 16),
              
              _buildSplitOption("Equal", "Everyone pays the same", Icons.groups_outlined),
              _buildSplitOption("Itemized", "Pick what you ate", Icons.receipt_long_outlined),
              _buildSplitOption("Percentage", "Split by responsibility", Icons.percent_outlined),
              _buildSplitOption("Shared Wallet", "Groups pay together", Icons.account_balance_outlined),

              // Pushes the button to the bottom while respecting the content above
              const Spacer(), 

              // --- ACTION BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 58,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ]
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // To be linked to Participant Selection
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text(
                      "Continue", 
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Margin below button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSplitOption(String title, String subtitle, IconData icon) {
    bool isSelected = selectedMethod == title;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10), // Balanced spacing between cards
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB).withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon, 
              color: isSelected ? const Color(0xFF2563EB) : Colors.grey[400], 
              size: 22
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 15,
                      color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF1E293B)
                    )
                  ),
                  Text(
                    subtitle, 
                    style: TextStyle(color: Colors.grey[500], fontSize: 12)
                  ),
                ],
              ),
            ),
            if (isSelected) 
              const Icon(Icons.check_circle_rounded, color: Color(0xFF2563EB), size: 20),
          ],
        ),
      ),
    );
  }
}