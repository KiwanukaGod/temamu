import 'package:flutter/material.dart';

class AdminSettlementScreen extends StatelessWidget {
  const AdminSettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pool Status"), centerTitle: true),
      body: Column(
        children: [
          const ListTile(
            title: Text("Sarah Namuli"),
            subtitle: Text("Waiting for Merchant Pay"),
            trailing: Icon(Icons.access_time, color: Colors.orange),
          ),
          ListTile(
            title: const Text("Alex Mukasa"),
            subtitle: const Text("Wants to pay Cash"),
            trailing: ElevatedButton(
              onPressed: () {}, 
              child: const Text("Confirm Receipt")
            ),
          ),
          // ... more participants
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/pool-recap'),
              child: const Text("Finish Session"),
            ),
          )
        ],
      ),
    );
  }
}