import 'package:flutter/material.dart';

class SelectSplitMethodScreen extends StatefulWidget {
  const SelectSplitMethodScreen({super.key});

  @override
  State<SelectSplitMethodScreen> createState() =>
      _SelectSplitMethodScreenState();
}

class _SelectSplitMethodScreenState extends State<SelectSplitMethodScreen> {
  String _selectedMethod = 'Equal';

  // The logic descriptions for the Ugandan context
  final List<Map<String, dynamic>> _methods = [
    {
      'id': 'Equal',
      'title': 'Equal Split',
      'desc': 'Total bill is divided equally among all participants.',
      'icon': Icons.groups_rounded,
    },
    {
      'id': 'Itemized',
      'title': 'Itemized / Per Item',
      'desc': 'Everyone pays for exactly what they ordered/consumed.',
      'icon': Icons.receipt_long_rounded,
    },
    {
      'id': 'Percentage',
      'title': 'Percentage Share',
      'desc': 'Assign custom portions (e.g., 60/40) for each person.',
      'icon': Icons.pie_chart_outline_rounded,
    },
    {
      'id': 'Shared Wallet',
      'title': 'Shared Wallet',
      'desc': 'Bill is divided based on the assigned groups.',
      'icon': Icons.wallet_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Receiving data from CreatePoolScreen
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String poolName = args['poolName'] ?? "New Pool";
    final List<String> participants = args['participants'] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Split Method",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  poolName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "With ${participants.length} participants. How would you like to split the future bill?",
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _methods.length,
              itemBuilder: (context, index) {
                final method = _methods[index];
                bool isSelected = _selectedMethod == method['id'];

                return GestureDetector(
                  onTap: () => setState(() => _selectedMethod = method['id']),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2563EB).withOpacity(0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2563EB)
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2563EB)
                                : const Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            method['icon'],
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isSelected
                                      ? const Color(0xFF2563EB)
                                      : const Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                method['desc'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF2563EB),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // --- FOOTER ACTION ---
          Container(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate based on selected method
                  String route;
                  switch (_selectedMethod) {
                    case 'Equal':
                      route = '/equal-split-config';
                      break;
                    case 'Itemized':
                      route = '/itemized-split-config';
                      break;
                    case 'Percentage':
                      route = '/percentage-split-config';
                      break;
                    case 'Shared Wallet':
                      route = '/wallet-split-config';
                      break;
                    default:
                      route = '/pool-lobby'; // fallback
                  }

                  Navigator.pushNamed(
                    context,
                    route,
                    arguments: {
                      'poolName': poolName,
                      'participants': participants,
                      'method': _selectedMethod,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF1E293B,
                  ), // Dark Navy for "Finalizing" actions
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Confirm",
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
