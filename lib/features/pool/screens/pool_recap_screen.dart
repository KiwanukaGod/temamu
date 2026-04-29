import 'package:flutter/material.dart';

class PoolRecapScreen extends StatelessWidget {
  const PoolRecapScreen({super.key});

  // --- CORE MATH ENGINE ---
  Map<String, double> _calculateShares(
    List<String> participants,
    double baseBill,
    List<Map<String, dynamic>> extras,
    String method,
  ) {
    // 1. Initialize everyone's balance to 0
    Map<String, double> shares = {};
    for (var person in participants) {
      shares[person] = 0.0;
    }

    // 2. Split the Base Bill
    // For Version 1 prototyping, we will default the base bill to an Equal Split
    // across all participants (unless you later build a full Itemized UI for the base bill).
    if (participants.isNotEmpty) {
      double baseSplit = baseBill / participants.length;
      for (var person in participants) {
        shares[person] = shares[person]! + baseSplit;
      }
    }

    // 3. Add the Extras (Boda, Tips, Items)
    for (var extra in extras) {
      double amount = extra['amount'] ?? 0.0;
      String assignedTo = extra['assignedTo'] ?? 'Everyone';

      if (assignedTo == 'Everyone' && participants.isNotEmpty) {
        // Split this extra equally
        double extraSplit = amount / participants.length;
        for (var person in participants) {
          shares[person] = shares[person]! + extraSplit;
        }
      } else if (shares.containsKey(assignedTo)) {
        // Assign this extra specifically to one person
        shares[assignedTo] = shares[assignedTo]! + amount;
      }
    }

    return shares;
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve all the arguments passed through the flow
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
        {};

    final String poolName = args['poolName'] ?? "Event";
    final String method = args['method'] ?? "Equal";
    final List<String> participants = args['participants'] ?? [];
    final double baseBill = args['baseBill'] ?? 0.0;
    final List<Map<String, dynamic>> extras = args['extras'] ?? [];

    // Calculate Grand Total
    double totalExtras = extras.fold(
      0,
      (sum, extra) => sum + (extra['amount'] as double),
    );
    double grandTotal = baseBill + totalExtras;

    // Run the Math Engine
    Map<String, double> finalShares = _calculateShares(
      participants,
      baseBill,
      extras,
      method,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Final Shares",
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
          // --- 1. HEADER SUMMARY ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Column(
              children: [
                Text(
                  poolName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "UGX ${grandTotal.toInt()}",
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Method: $method",
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- 2. PARTICIPANT BREAKDOWN LIST ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: participants.length,
              itemBuilder: (context, index) {
                String person = participants[index];
                double amountOwed = finalShares[person] ?? 0.0;
                bool isHost =
                    index == 0; // The first person is our Device Owner/Host

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: isHost
                            ? const Color(0xFF2563EB).withOpacity(0.1)
                            : const Color(0xFFF1F5F9),
                        child: Text(
                          person.isNotEmpty ? person[0] : "?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isHost
                                ? const Color(0xFF2563EB)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (isHost)
                              const Text(
                                "Host",
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        "UGX ${amountOwed.toInt()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2563EB), // Action Blue for money
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // --- 3. PROCEED TO PAYMENT FOOTER ---
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
                onPressed: () {
                  // This is the trigger that moves everyone out of the lobby
                  // and into the manual settlement/reconciliation phase.
                  Navigator.pushNamed(
                    context,
                    '/manual-payment', // The next route in your flow
                    arguments: {
                      ...args,
                      'finalShares':
                          finalShares, // Pass the computed math forward
                      'grandTotal': grandTotal,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Proceed to Settlement",
                  style: TextStyle(
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
}
