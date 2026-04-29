import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class PoolLobbyScreen extends StatefulWidget {
  const PoolLobbyScreen({super.key});

  @override
  State<PoolLobbyScreen> createState() => _PoolLobbyScreenState();
}

class _PoolLobbyScreenState extends State<PoolLobbyScreen> {
  late String _poolCode;
  String _deviceOwnerName =
      "Loading..."; // Placeholder while reading local storage

  @override
  void initState() {
    super.initState();
    _poolCode = _generateRandomCode();
    _fetchDeviceOwnerAccount();
  }

  // --- PRODUCTION LOGIC: FETCHING THE ACTUAL LOGGED-IN USER ---
  Future<void> _fetchDeviceOwnerAccount() async {
    try {
      // 1. Open the local storage on the device
      final prefs = await SharedPreferences.getInstance();

      // 2. Fetch the name that was saved during the Sign-Up screen
      // If it's null (e.g., they bypassed signup somehow), default to "Host"
      final savedName = prefs.getString('userName') ?? "Host";

      // 3. Update the UI safely
      if (mounted) {
        setState(() {
          _deviceOwnerName = "$savedName (You)";
        });
      }
    } catch (e) {
      // Fallback just in case local storage fails
      if (mounted) {
        setState(() {
          _deviceOwnerName = "Host (You)";
        });
      }
    }
  }

  String _generateRandomCode() {
    const chars = '0123456789';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
        {};
    final String poolName = args['poolName'] ?? "Event Lobby";
    final String splitMethod = args['method'] ?? "Equal Split";

    // These are the FRIENDS the admin invited
    final List<String> invitedFriends = args['participants'] ?? [];

    // The math dynamically uses the fetched device owner
    final int totalParticipants = invitedFriends.length + 1;

    // The device owner is automatically the first person in the room
    final List<String> joined = [
      _deviceOwnerName,
      if (invitedFriends.isNotEmpty)
        invitedFriends.first, // Mocking 1 friend joining
    ];

    // The rest of the invited friends are pending
    final List<String> pending = invitedFriends.length > 1
        ? invitedFriends.skip(1).toList()
        : [];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          poolName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF2563EB)),
            onPressed: () {
              // Action to show large QR code pop-up
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- THE LOBBY HEADER (Code & Method) ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Column(
              children: [
                const Text(
                  "LOBBY CODE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _poolCode,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2563EB),
                    letterSpacing: 8.0,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF06B6D4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Color(0xFF06B6D4),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Method: $splitMethod",
                        style: const TextStyle(
                          color: Color(0xFF06B6D4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- PARTICIPANTS LISTS ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // JOINED SECTION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Joined",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        "${joined.length}/$totalParticipants",
                        style: const TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...joined.map(
                    (name) => _buildParticipantTile(
                      name,
                      isJoined: true,
                      isAdmin:
                          name ==
                          _deviceOwnerName, // Compares against the fetched account name
                    ),
                  ),

                  const SizedBox(height: 32),

                  // PENDING SECTION
                  if (pending.isNotEmpty) ...[
                    const Text(
                      "Pending (Waiting to join...)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...pending.map(
                      (name) => _buildParticipantTile(
                        name,
                        isJoined: false,
                        isAdmin: false,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // --- THE FINANCIAL TRIGGER (Admin Only) ---
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Passes the full roster (Device Owner + Friends) to the Attach Receipt screen
                  final fullParticipantList = [
                    _deviceOwnerName,
                    ...invitedFriends,
                  ];
                  final Map<String, dynamic> updatedArgs = {
                    ...args,
                    'participants': fullParticipantList,
                  };

                  Navigator.pushNamed(
                    context,
                    '/attach-receipt',
                    arguments: updatedArgs,
                  );
                },
                icon: const Icon(Icons.receipt_long, color: Colors.white),
                label: const Text(
                  "Proceed",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantTile(
    String name, {
    required bool isJoined,
    required bool isAdmin,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAdmin
            ? const Color(0xFF2563EB).withOpacity(0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAdmin
              ? const Color(0xFF2563EB).withOpacity(0.3)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: isJoined
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isJoined
                ? const Color(0xFF2563EB).withOpacity(0.1)
                : const Color(0xFFF1F5F9),
            child: Text(
              name.isNotEmpty ? name[0] : "?", // Safe access if name is loading
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isJoined ? const Color(0xFF2563EB) : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  // Wrapping in Expanded prevents text overflow if name is long
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isJoined ? FontWeight.w600 : FontWeight.w400,
                      color: isJoined ? const Color(0xFF1E293B) : Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isAdmin) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "HOST",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isJoined)
            const Icon(Icons.check_circle, color: Colors.green, size: 20)
          else
            const Icon(Icons.hourglass_empty, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
