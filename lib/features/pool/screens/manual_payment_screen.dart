import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManualPaymentScreen extends StatefulWidget {
  const ManualPaymentScreen({super.key});

  @override
  State<ManualPaymentScreen> createState() => _ManualPaymentScreenState();
}

class _ManualPaymentScreenState extends State<ManualPaymentScreen> {
  String _currentUser = "Loading...";
  bool _isProcessing = false;
  String _selectedPaymentMethod = "Cash";

  @override
  void initState() {
    super.initState();
    _fetchDeviceOwnerAccount();
  }

  Future<void> _fetchDeviceOwnerAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedName = prefs.getString('userName') ?? "Host";
      if (mounted) {
        setState(() {
          _currentUser = "$savedName (You)";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _currentUser = "Host (You)");
      }
    }
  }

  void _onConfirmPayment(bool isHost) async {
    setState(() => _isProcessing = true);

    if (isHost) {
      // ADMIN PATH: Instant confirmation
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate database save
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/congratulations');
      }
    } else {
      // PARTICIPANT PATH: Waiting for Admin
      // In production, this pushes a notification to the Admin's device via Firebase Cloud Messaging
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFF2563EB)),
              SizedBox(height: 24),
              Text(
                "Waiting for Host",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "We have notified the host. Please wait while they confirm receipt of your payment.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      );

      // Mocking the Admin accepting the payment after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        Navigator.pop(context); // Close the dialog
        Navigator.pushReplacementNamed(context, '/congratulations');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
        {};
    final List<String> participants = args['participants'] ?? [];
    final Map<String, double> finalShares = args['finalShares'] ?? {};

    // Identify the Host (always the first person in our logic)
    final String hostName = participants.isNotEmpty
        ? participants.first
        : "The Host";

    // Check if the person holding the phone IS the host
    final bool isHost = _currentUser == hostName;

    // Find out how much THIS specific user owes
    final double myShare = finalShares[_currentUser] ?? 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Settle Your Share",
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // --- 1. AMOUNT OWED CARD ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "YOU OWE",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "UGX ${myShare.toInt()}",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- 2. PAYMENT INSTRUCTIONS ---
                  if (!isHost) ...[
                    Text(
                      "Pay $hostName",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Hand over cash or send the money via Mobile Money (MoMo/Airtel) directly to the host, then confirm below.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ] else ...[
                    const Text(
                      "You are the Host",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Please confirm your own share has been accounted for to officially open the settlement ledger.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),

                  // --- 3. PAYMENT METHOD SELECTOR ---
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Method Used",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildMethodOption("Cash", Icons.payments_outlined),
                      const SizedBox(width: 16),
                      _buildMethodOption(
                        "Mobile Money",
                        Icons.phone_android_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- 4. CONFIRMATION FOOTER ---
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
              child: ElevatedButton(
                onPressed: _isProcessing || myShare == 0
                    ? null // Disable if already processing or share is 0
                    : () => _onConfirmPayment(isHost),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  disabledBackgroundColor: const Color(0xFF94A3B8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        isHost ? "Confirm My Share" : "I Have Paid",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the selectable Payment Method boxes
  Widget _buildMethodOption(String title, IconData icon) {
    bool isSelected = _selectedPaymentMethod == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPaymentMethod = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF2563EB).withOpacity(0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFFE2E8F0),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF64748B),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? const Color(0xFF2563EB)
                      : const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
