import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smar_bin/modules/Auth.dart';
import 'package:smar_bin/modules/LanguageSettings.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/component.dart';
import 'package:smar_bin/shared/components/navigator.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/avatar.png'), // Replace with your image
                ),
                const SizedBox(height: 10),
                Text(
                  "Azzahri Alpiana",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {},
                  child: const Text("Edit Profile Picture",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                sectionTitle(text: 'Account Settings'),
                buildSettingsItem(
                    icon: Icons.card_giftcard,
                    label: 'Mobile Reward',
                    context: context),
                buildSettingsItem(
                    icon: Icons.fingerprint,
                    label: 'Sidik Jari & Face ID',
                    context: context),
                buildSettingsItem(
                    icon: Iconsax.global,
                    label: 'Language',
                    direction: LanguageSelectionScreen(),
                    context: context),
                buildSettingsItem(
                    icon: Icons.link,
                    label: 'Sidik Jari & Face ID',
                    context: context),
                const SizedBox(height: 20),
                sectionTitle(text: 'Other'),
                buildSettingsItem(
                    icon: Icons.link,
                    label: 'Sidik Jari & Face ID',
                    context: context),
                buildSettingsItem(
                    icon: Icons.rule,
                    label: 'Sidik Jari & Face ID',
                    context: context),
                buildSettingsItem(
                    icon: Icons.privacy_tip,
                    label: 'Sidik Jari & Face ID',
                    context: context),
                const SizedBox(height: 20),
                sectionTitle(text: 'Logout'),
                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Iconsax.logout,
                        color: Colors.red,
                        size: 24,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20),
              Text(
                'Do you want to logout ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await ApiService().logoutUser();
                  Navigator.of(context).pop();
                  noBackPush(context: context, direction: AuthScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    'Logout'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
