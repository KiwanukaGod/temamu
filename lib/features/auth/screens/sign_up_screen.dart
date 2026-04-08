import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String selectedNetwork = 'MTN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // The back arrow in the AppBar will also work automatically!
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Profile", 
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))
            ),
            const SizedBox(height: 8),
            Text("Join Temamu and start paying together.", style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 32),
            const TextField(decoration: InputDecoration(labelText: "Full Name", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: "Phone Number", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            const Text("Select Network", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildNetworkChip("MTN", Colors.amber),
                const SizedBox(width: 12),
                _buildNetworkChip("Airtel", Colors.red),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Later: Save user and go to Home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // NAVIGATION BACK TO LOGIN
            Center(
              child: TextButton(
                onPressed: () {
                  // Goes back to the previous screen (Login)
                  Navigator.pop(context);
                },
                child: const Text("Already have an account? Sign In"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkChip(String label, Color color) {
    bool isSelected = selectedNetwork == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        setState(() {
          selectedNetwork = label;
        });
      },
      selectedColor: color.withOpacity(0.3),
      labelStyle: TextStyle(
        color: isSelected ? color : Colors.black, 
        fontWeight: FontWeight.bold
      ),
    );
  }
}