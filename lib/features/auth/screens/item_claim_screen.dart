import 'package:flutter/material.dart';

class ItemClaimScreen extends StatefulWidget {
  const ItemClaimScreen({super.key});

  @override
  State<ItemClaimScreen> createState() => _ItemClaimScreenState();
}

class _ItemClaimScreenState extends State<ItemClaimScreen> {
  // Mock data: Items that haven't been claimed yet or claimed by 'Me'
  final List<Map<String, dynamic>> _items = [
    {"name": "Whole Grilled Pork", "price": 45000, "claimedBy": null},
    {"name": "Large Cassava Portion", "price": 12000, "claimedBy": "Me"},
    {"name": "Club Beer", "price": 6000, "claimedBy": "Alex"},
    {"name": "Club Beer", "price": 6000, "claimedBy": null},
    {"name": "Soda (Coke)", "price": 2500, "claimedBy": "Me"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Claim Your Items", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Tap the items you consumed. Others will see what's already taken.",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _buildClaimTile(_items[index], index);
              },
            ),
          ),

          // --- STICKY FOOTER ---
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Your Total:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const Text("UGX 14,500", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/payment-selection');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Confirm & Pay", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimTile(Map<String, dynamic> item, int index) {
    bool isClaimedByMe = item['claimedBy'] == "Me";
    bool isClaimedByOther = item['claimedBy'] != null && item['claimedBy'] != "Me";

    return GestureDetector(
      onTap: isClaimedByOther ? null : () {
        setState(() {
          _items[index]['claimedBy'] = isClaimedByMe ? null : "Me";
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isClaimedByMe ? const Color(0xFF2563EB).withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isClaimedByMe ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
            width: isClaimedByMe ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isClaimedByOther ? Icons.lock_outline : (isClaimedByMe ? Icons.check_circle : Icons.add_circle_outline),
              color: isClaimedByOther ? Colors.grey[300] : (isClaimedByMe ? const Color(0xFF2563EB) : Colors.grey[400]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'], 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: isClaimedByOther ? TextDecoration.lineThrough : null,
                      color: isClaimedByOther ? Colors.grey[400] : Colors.black
                    )
                  ),
                  if (isClaimedByOther)
                    Text("Taken by ${item['claimedBy']}", style: const TextStyle(color: Colors.redAccent, fontSize: 11)),
                ],
              ),
            ),
            Text(
              "UGX ${item['price']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isClaimedByOther ? Colors.grey[300] : (isClaimedByMe ? const Color(0xFF2563EB) : Colors.black)
              ),
            ),
          ],
        ),
      ),
    );
  }
}