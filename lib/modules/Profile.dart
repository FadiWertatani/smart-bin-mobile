import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smar_bin/models/User.dart';
import 'package:smar_bin/modules/Auth.dart';
import 'package:smar_bin/modules/FAQ.dart';
import 'package:smar_bin/modules/LanguageSettings.dart';
import 'package:smar_bin/modules/Terms.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/component.dart';
import 'package:smar_bin/shared/components/navigator.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<User> _getUser() async {
    final email = await SharedPrefsHelper.getEmail();
    if (email == null) throw Exception("No email found in shared preferences.");
    return await ApiService().fetchUserByEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: FutureBuilder<User>(
        future: _getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data found.'));
          }

          final user = snapshot.data!;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user.profileImage != null
                          ? NetworkImage(user.profileImage!)
                          : const AssetImage('assets/images/avatar.png')
                              as ImageProvider,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.fullName ?? "No name",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickAndUploadImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade900,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        "Edit Profile Picture",
                        style: TextStyle(color: Colors.white),
                      ),
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
                        icon: Iconsax.edit, label: 'Infos', context: context),
                    buildSettingsItem(
                        icon: Iconsax.global,
                        label: 'Language',
                        direction: LanguageSelectionScreen(),
                        context: context),
                    sectionTitle(text: 'Other'),
                    buildSettingsItem(
                        icon: Icons.help_outline,
                        label: 'Help',
                        direction: FAQ(),
                        context: context),
                    buildSettingsItem(
                        icon: Icons.rule,
                        label: 'Terms & Conditions',
                        direction: Terms(),
                        context: context),
                    buildSettingsItem(
                        icon: Icons.privacy_tip,
                        label: 'Privacy Policy',
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
                          leading: const Icon(Iconsax.logout,
                              color: Colors.red, size: 24),
                          title: const Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.logout, size: 50, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                'Do you want to logout ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await ApiService().logoutUser();
                  await SharedPrefsHelper.clearUserData();
                  Navigator.of(context).pop();
                  noBackPush(context: context, direction: AuthScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
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

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final email = await SharedPrefsHelper.getEmail();

      if (email != null) {
        bool success = await ApiService().uploadProfileImage(email, imageFile);
        if (success) {
          flutterToast(
              message: 'Profile picture updated!',
              backgroundColor: Colors.green);
          setState(
              () {}); // This will trigger FutureBuilder to refetch the user
        } else {
          flutterToast(message: "Upload failed", backgroundColor: Colors.red);
        }
      }
    }
  }
}
