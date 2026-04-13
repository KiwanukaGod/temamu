import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF2563EB)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // --- USER HEADER ---
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFF1F5F9),
              child: Icon(Icons.person, size: 50, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 16),
            const Text(
              "Alex Mukasa",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            const Text(
              "@alex_m",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            
            const SizedBox(height: 32),

            // --- QUICK STATS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem("Total Split", "UGX 450k"),
                  _buildStatItem("Pools", "24"),
                  _buildStatItem("Friends", "12"),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Divider(thickness: 8, color: Color(0xFFF8FAFC)),

            // --- SETTINGS LIST ---
            _buildSettingsSection("Account Settings", [
              _buildSettingsTile(Icons.payment_outlined, "Payment Methods", "MoMo & Bank Cards"),
              _buildSettingsTile(Icons.notifications_none_outlined, "Notifications", "Alerts & Reminders"),
              _buildSettingsTile(Icons.security_outlined, "Security", "PIN & Biometrics"),
            ]),

            _buildSettingsSection("Support & Legal", [
              _buildSettingsTile(Icons.help_outline_rounded, "Help Center", "FAQs & Support"),
              _buildSettingsTile(Icons.description_outlined, "Terms of Service", ""),
              _buildSettingsTile(Icons.privacy_tip_outlined, "Privacy Policy", ""),
            ]),

            // --- LOGOUT BUTTON ---
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
                icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                label: const Text("Logout", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 24, bottom: 8),
          child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        ...tiles,
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: const Color(0xFF1E293B), size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: () {},
    );
  }
}