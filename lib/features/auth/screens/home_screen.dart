import 'package:flutter/material.dart';
import 'package:temamu/core/services/session_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- DYNAMIC GREETING ---
              FutureBuilder<String>(
                future: SessionService.getUserName(),
                builder: (context, snapshot) {
                  String name = snapshot.data ?? "User";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello, $name", 
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                      const Text("Ready to split the bill?", style: TextStyle(color: Colors.grey)),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              // Your existing Create/Join buttons here...
            ],
          ),
        ),
      ),
    );
  }
}