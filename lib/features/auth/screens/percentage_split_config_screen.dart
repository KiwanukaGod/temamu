import 'package:flutter/material.dart';

class PercentageSplitConfigScreen extends StatefulWidget {
  const PercentageSplitConfigScreen({super.key});

  @override
  State<PercentageSplitConfigScreen> createState() => _PercentageSplitConfigScreenState();
}

class _PercentageSplitConfigScreenState extends State<PercentageSplitConfigScreen> {
  // Mock data: A Host might pre-define percentage "slots" 
  // which will be assigned to friends in the next step.
  double _hostPercentage = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Percentage Split", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Define how much of the bill you will cover. Your friends will split or assign the remaining percentage.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              
              const Spacer(flex: 1),

              // --- HOST PERCENTAGE ADJUSTER ---
              Center(
                child: Column(
                  children: [
                    const Text("Your Contribution", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(
                      "${_hostPercentage.toInt()}%",
                      style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
                    ),
                    const Text("UGX 60,000", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Slider for the Host to set their share
              Slider(
                value: _hostPercentage,
                min: 0,
                max: 100,
                divisions: 20, // Increments of 5%
                activeColor: const Color(0xFF2563EB),
                inactiveColor: const Color(0xFFE2E8F0),
                onChanged: (value) {
                  setState(() {
                    _hostPercentage = value;
                  });
                },
              ),

              const Spacer(flex: 1),

              // --- REMAINING SUMMARY ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Remaining", style: TextStyle(color: Colors.grey, fontSize: 13)),
                        Text("To be split by friends", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                    Text(
                      "${(100 - _hostPercentage).toInt()}%",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF06B6D4)),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // --- ACTION BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Proceed to Add Participants
                    Navigator.pushNamed(context, '/add-participants');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Confirm & Add Friends", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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