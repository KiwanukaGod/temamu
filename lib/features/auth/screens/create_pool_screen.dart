import 'package:flutter/material.dart';

class CreatePoolScreen extends StatefulWidget {
  const CreatePoolScreen({super.key});

  @override
  State<CreatePoolScreen> createState() => _CreatePoolScreenState();
}

class _CreatePoolScreenState extends State<CreatePoolScreen> {
  final TextEditingController _poolNameController = TextEditingController();
  final List<String> _selectedFriends = [];

  // Mock data for contacts - in production this would come from the phone's contact list
  final List<String> _contacts = [
    "Sarah Namuli",
    "John Musoke",
    "Alex Mukasa",
    "Ivan Kato",
    "Maria Okecho",
    "Pius Wandera",
  ];

  @override
  void dispose() {
    _poolNameController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_poolNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please give your pool a name first")),
      );
      return;
    }

    // Proceed to Split Method Selection
    Navigator.pushNamed(
      context,
      '/select-split-method',
      arguments: {
        'poolName': _poolNameController.text,
        'participants': _selectedFriends,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Start a New Pool",
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
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- SECTION 1: POOL NAME ---
                  const Text(
                    "What are we splitting?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _poolNameController,
                    decoration: InputDecoration(
                      hintText: "e.g. Friday Pork Joint",
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      prefixIcon: const Icon(
                        Icons.edit_note,
                        color: Color(0xFF2563EB),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- SECTION 2: ADD PARTICIPANTS ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add Participants",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        "${_selectedFriends.length} selected",
                        style: const TextStyle(
                          color: Color(0xFF2563EB),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search Input
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search contacts...",
                      prefixIcon: const Icon(Icons.search, size: 20),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- HORIZONTAL LIST OF SELECTED FRIENDS ---
                  if (_selectedFriends.isNotEmpty)
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedFriends.length,
                        itemBuilder: (context, index) {
                          final name = _selectedFriends[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: const Color(
                                        0xFF2563EB,
                                      ).withOpacity(0.1),
                                      child: Text(
                                        name[0],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2563EB),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () => setState(
                                          () => _selectedFriends.remove(name),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  name.split(" ")[0],
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                  const Divider(height: 40, color: Color(0xFFF1F5F9)),

                  // --- LIST OF CONTACTS ---
                  const Text(
                    "Suggested Contacts",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._contacts.map((name) {
                    bool isSelected = _selectedFriends.contains(name);
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFF1F5F9),
                        child: Text(
                          name[0],
                          style: const TextStyle(color: Color(0xFF1E293B)),
                        ),
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      trailing: Checkbox(
                        value: isSelected,
                        activeColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _selectedFriends.add(name);
                            } else {
                              _selectedFriends.remove(name);
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // --- FOOTER ACTION ---
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: _onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Choose Split Method",
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
