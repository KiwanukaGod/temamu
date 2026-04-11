import 'package:flutter/material.dart';

class AddParticipantsScreen extends StatefulWidget {
  const AddParticipantsScreen({super.key});

  @override
  State<AddParticipantsScreen> createState() => _AddParticipantsScreenState();
}

class _AddParticipantsScreenState extends State<AddParticipantsScreen> {
  // Mock data: In a real app, 'hasApp' would be checked against your database
  final List<Map<String, dynamic>> _contacts = [
    {"name": "Alex Mukasa", "handle": "@alex_m", "hasApp": true, "selected": false},
    {"name": "Sarah Namuli", "handle": "@sarah_n", "hasApp": true, "selected": false},
    {"name": "John Doe", "handle": "+256 700...", "hasApp": false, "selected": false},
    {"name": "Grace Akello", "handle": "@akello_g", "hasApp": true, "selected": false},
    {"name": "Peter Okello", "handle": "+256 772...", "hasApp": false, "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Friends", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
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
              
              // --- SEARCH BAR ---
              TextField(
                decoration: InputDecoration(
                  hintText: "Search contacts or @username",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              const Text("On Temamu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2563EB))),
              const SizedBox(height: 12),

              // --- CONTACT LIST ---
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    final contact = _contacts[index];
                    return _buildContactTile(contact, index);
                  },
                ),
              ),

              // --- BOTTOM ACTION ---
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    // This leads to the Invite Screen (Share Code/Link)
                    Navigator.pushNamed(context, '/host-invite');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "Enter Lobby", 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact, int index) {
    bool hasApp = contact['hasApp'];
    bool isSelected = contact['selected'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: hasApp ? const Color(0xFF2563EB).withOpacity(0.1) : Colors.grey[200],
            child: Text(
              contact['name'][0], 
              style: TextStyle(color: hasApp ? const Color(0xFF2563EB) : Colors.grey[600], fontWeight: FontWeight.bold)
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(contact['handle'], style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              ],
            ),
          ),
          
          // Action Button based on status
          if (hasApp)
            IconButton(
              onPressed: () {
                setState(() {
                  _contacts[index]['selected'] = !isSelected;
                });
              },
              icon: Icon(
                isSelected ? Icons.check_circle : Icons.add_circle_outline,
                color: isSelected ? const Color(0xFF2563EB) : Colors.grey[400],
              ),
            )
          else
            TextButton(
              onPressed: () {
                // Future: Send SMS invite
              },
              child: const Text("Invite", style: TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}