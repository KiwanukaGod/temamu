import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinPoolScreen extends StatefulWidget {
  const JoinPoolScreen({super.key});

  @override
  State<JoinPoolScreen> createState() => _JoinPoolScreenState();
}

class _JoinPoolScreenState extends State<JoinPoolScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isJoining = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onJoinLobby() async {
    final code = _codeController.text.trim();

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit code.")),
      );
      return;
    }

    setState(() => _isJoining = true);

    // 1. Fetch the user's name so we can inject them into the room
    final prefs = await SharedPreferences.getInstance();
    final myName = prefs.getString('userName') ?? "Participant";

    // MOCKING THE DATABASE CALL:
    // In production, you will query Firebase for a session with this 6-digit code.
    // For this prototype, we will simulate a successful find after 1.5 seconds.
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      setState(() => _isJoining = false);

      // We package a mock session that looks exactly like what Firebase would return.
      // Notice the device owner's name is placed SECOND, meaning they are NOT the Host.
      Navigator.pushNamed(
        context,
        '/pool-lobby',
        arguments: {
          'poolName': "Friday Pork Joint", // Mocked from DB
          'method': "Equal Split", // Mocked from DB
          'participants': [
            "Alex Mukasa",
            myName,
            "Sarah Namuli",
          ], // Host is first
        },
      );
    }
  }

  void _scanQR() {
    // Mock QR Scanner
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Opening Camera for QR Scan...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Join a Pool",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // --- 1. INSTRUCTIONS ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF06B6D4).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.group_add_rounded,
                  size: 64,
                  color: Color(0xFF06B6D4),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Enter Lobby Code",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Ask the host for the 6-digit number code to enter the room.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // --- 2. CODE INPUT FIELD ---
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 12.0,
                  color: Color(0xFF2563EB),
                ),
                decoration: InputDecoration(
                  counterText: "", // Hides the '0/6' character counter
                  hintText: "000000",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.3),
                    letterSpacing: 12.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF2563EB),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- 3. JOIN BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _isJoining ? null : _onJoinLobby,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isJoining
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          "Enter Lobby",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 32),

              // --- 4. OR SCAN QR ---
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
                ],
              ),

              const SizedBox(height: 32),

              OutlinedButton.icon(
                onPressed: _scanQR,
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: Color(0xFF1E293B),
                ),
                label: const Text(
                  "Scan QR Code",
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
