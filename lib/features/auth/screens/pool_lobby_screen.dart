import 'package:flutter/material.dart';

class PoolLobbyScreen extends StatefulWidget {
  final bool isAdmin; // We'll use this to toggle the UI view

  const PoolLobbyScreen({super.key, this.isAdmin = true}); // Defaulting to true for your testing

  @override
  State<PoolLobbyScreen> createState() => _PoolLobbyScreenState();
}

class _PoolLobbyScreenState extends State<PoolLobbyScreen> {
  // Mock data for the lobby
  final List<Map<String, dynamic>> _participants = [
    {"name": "You", "handle": "@host", "status": "Ready", "isHost": true},
    {"name": "Alex Mukasa", "handle": "@alex_m", "status": "Joined", "isHost": false},
    {"name": "Sarah Namuli", "handle": "@sarah_n", "status": "Joined", "isHost": false},
    {"name": "Grace Akello", "handle": "@akello_g", "status": "Joining...", "isHost": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Pool Lobby", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Prevents accidentally leaving the lobby
        actions: [
          IconButton(
            onPressed: () => _showExitDialog(context),
            icon: const Icon(Icons.exit_to_app, color: Colors.redAccent),
          )
        ],
      ),
      body: Column(
        children: [
          // --- LOBBY HEADER CARD ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
            child: Column(
              children: [
                const Text("Friday Pork Joint", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("Split Method: Itemized", style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(20)),
                  child: const Text("Code: 882 104", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- PARTICIPANTS LIST ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Participants", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${_participants.length} Present", style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _participants.length,
              itemBuilder: (context, index) {
                final person = _participants[index];
                return _buildParticipantTile(person);
              },
            ),
          ),

          // --- CONDITIONAL FOOTER ---
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildParticipantTile(Map<String, dynamic> person) {
    bool isReady = person['status'] == "Ready" || person['status'] == "Joined";
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isReady ? const Color(0xFFE2E8F0) : Colors.transparent),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: person['isHost'] ? const Color(0xFF2563EB) : const Color(0xFF06B6D4),
            child: Text(person['name'][0], style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(person['handle'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isReady ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              person['status'],
              style: TextStyle(color: isReady ? Colors.green : Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: widget.isAdmin 
        ? _buildAdminAction() 
        : _buildParticipantWaiting(),
    );
  }

  Widget _buildAdminAction() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Wait for everyone to join before continuing.", style: TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // Next: Payment Options Screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Confirm All Present", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantWaiting() {
    return Row(
      children: [
        const SizedBox(
          height: 20, width: 20,
          child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF06B6D4))),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Waiting for Host...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("Admin @host will start the payment soon.", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Leave Pool?"),
        content: const Text("Are you sure you want to exit this lobby?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            }, 
            child: const Text("Leave", style: TextStyle(color: Colors.redAccent))
          ),
        ],
      ),
    );
  }
}