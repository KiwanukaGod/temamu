import 'package:flutter/material.dart';

class ItemizedSplitConfigScreen extends StatefulWidget {
  const ItemizedSplitConfigScreen({super.key});

  @override
  State<ItemizedSplitConfigScreen> createState() => _ItemizedSplitConfigScreenState();
}

class _ItemizedSplitConfigScreenState extends State<ItemizedSplitConfigScreen> {
  // Mock data for the UI-first approach
  final List<Map<String, dynamic>> _items = [
    {"name": "Whole Grilled Pork", "price": 45000},
    {"name": "Large Cassava Portion", "price": 12000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Itemize Bill", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
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
              const Text(
                "Add items from your receipt. Friends will claim what they consumed in the lobby.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // --- ADD ITEM FORM ---
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Item Name",
                        hintText: "e.g. Club Beer",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Price",
                        hintText: "0.00",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle, color: Color(0xFF2563EB), size: 32),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- ITEM LIST ---
              const Text("Current Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return _buildItemTile(_items[index]['name'], _items[index]['price']);
                  },
                ),
              ),

              // --- SUMMARY & NEXT ---
              const Divider(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Itemized:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text("UGX 57,000", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                ],
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Next step: Host confirms and generates code
                    Navigator.pushNamed(context, '/host-invite');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Confirm & Generate Code", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemTile(String name, int price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
          Row(
            children: [
              Text("UGX $price", style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Icon(Icons.cancel_outlined, color: Colors.redAccent, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}