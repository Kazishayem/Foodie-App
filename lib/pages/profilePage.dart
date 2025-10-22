// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Text("this is the profile page"));
//   }
// }
// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:foodie_app/constants/colors.dart'; // তোমার color constants (পরিবর্তন কর)

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Demo data — চাইলে API / shared prefs থেকে নেওয়া যাবে
  String name = "Shayem";
  String email = "shayem@example.com";
  String phone = "+880 18xxxxxxxx";
  String avatar = 'assets/images/man.jpg'; // তোমার local asset বা network URL
  int orders = 12;
  int favorites = 5;
  int reviews = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.secondary, // তোমার primary color
        elevation: 0,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              // settings action (optional)
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          children: [
            // ===== Card with avatar, name & edit button =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      avatar,
                      width: 86,
                      height: 86,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Name, email, phone
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          phone,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Edit button
                  ElevatedButton(
                    onPressed: () => _showEditDialog(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ===== Quick stats =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard("Orders", orders.toString(), Icons.shopping_bag),
                _statCard("Favorites", favorites.toString(), Icons.favorite),
                _statCard("Reviews", reviews.toString(), Icons.star),
              ],
            ),

            const SizedBox(height: 18),

            // ===== Action buttons (like wallet, address, payment) =====
            Column(
              children: [
                _listTile(
                  icon: Icons.history,
                  title: "Order History",
                  subtitle: "View past orders",
                  onTap: () {
                    // navigate to order history
                  },
                ),
                _listTile(
                  icon: Icons.location_on,
                  title: "My Addresses",
                  subtitle: "Manage delivery addresses",
                  onTap: () {},
                ),
                _listTile(
                  icon: Icons.payment,
                  title: "Payment Methods",
                  subtitle: "Add or remove cards",
                  onTap: () {},
                ),
                _listTile(
                  icon: Icons.support_agent,
                  title: "Help & Support",
                  subtitle: "Contact support",
                  onTap: () {},
                ),
                _listTile(
                  icon: Icons.logout,
                  title: "Log out",
                  subtitle: "Sign out of your account",
                  onTap: () {
                    _logout();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ===== Small footer =====
            Text(
              "App version 1.0.0",
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ===== helper widgets =====
  Widget _statCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.12),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  // ===== edit dialog example =====
  void _showEditDialog() {
    final nameCtrl = TextEditingController(text: name);
    final emailCtrl = TextEditingController(text: email);
    final phoneCtrl = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit profile"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameCtrl.text.trim();
                  email = emailCtrl.text.trim();
                  phone = phoneCtrl.text.trim();
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // এখানে token clear / shared prefs clear করে navigate to login
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Logged out")));
  }
}
