import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smar_bin/modules/Auth.dart';
import 'dart:io';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:intl/intl.dart';
import 'package:smar_bin/shared/components/navigator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic> userData = {};
  int todayPoints = 0;
  int totalPoints = 0;
  int rewards = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      String? userCode = await SharedPrefsHelper.getUserCode();
      if (userCode != null) {
        var data = await ApiService().getUserData(userCode);
        if (!mounted) return;
        setState(() {
          userData = data;
          if (data['points'] != null) {
            todayPoints = _calculateTodayPoints(data['points']);
            totalPoints = data['points'].length;
            rewards = totalPoints ~/ 10;
          }
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des données')),
      );
    }
  }

  int _calculateTodayPoints(List points) {
    final today = DateTime.now();
    return points.where((point) {
      final pointDate = DateTime.parse(point['date']);
      return pointDate.year == today.year &&
          pointDate.month == today.month &&
          pointDate.day == today.day;
    }).length;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        String? userCode = await SharedPrefsHelper.getUserCode();
        if (userCode != null) {
          bool success =
              await ApiService().uploadProfileImage(userCode, _imageFile!);
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Photo de profil mise à jour avec succès')),
            );
            // Rechargez les données utilisateur pour afficher la nouvelle image
            _loadUserData();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Erreur lors de la mise à jour de la photo')),
            );
          }
        }
      }
    } catch (e) {
      print("Erreur lors de la sélection de l'image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la sélection de l'image")),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Prendre une photo'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choisir depuis la galerie'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void _showPointsHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Historique des points',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: userData['points']?.length ?? 0,
                itemBuilder: (context, index) {
                  final point = userData['points'][index];
                  final date = DateTime.parse(point['date']);
                  return ListTile(
                    title: Text('Point gagné'),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy HH:mm:ss').format(date),
                    ),
                    leading: Icon(Icons.star, color: Colors.amber),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHistory() {
    // Implémentation de l'historique des déchets
  }

  void _showFAQs() {
    // Implémentation des FAQs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAFD3E2),
      body: RefreshIndicator(
        onRefresh: _loadUserData,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Section du haut (profil et statistiques)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showImagePickerOptions,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!) as ImageProvider
                                  : (userData['profile_image'] != null
                                          ? NetworkImage(
                                              '${ApiService.BASE_URL}/uploads/${userData['profile_image']}')
                                          : AssetImage(
                                              'assets/images/doctor.jpg'))
                                      as ImageProvider,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: const Color(0xff589FB6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        userData['name'] ?? 'Chargement...',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem("Aujourd'hui", todayPoints),
                          _buildStatItem('Total', totalPoints),
                          _buildStatItem('Récompenses', rewards),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Section du bas (menu)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMenuItem(
                          icon: Icons.star_outline,
                          title: 'Mes Points',
                          onTap: _showPointsHistory,
                        ),
                        _buildMenuItem(
                          icon: Icons.history,
                          title: 'Historique',
                          onTap: _showHistory,
                        ),
                        _buildMenuItem(
                          icon: Icons.help_outline,
                          title: 'FAQs',
                          onTap: _showFAQs,
                        ),
                        _buildMenuItem(
                          icon: Icons.logout,
                          title: 'Logout',
                          isLogout: true,
                          onTap: () => _showLogoutDialog(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
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
                color: const Color(0xff589FB6),
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
                  backgroundColor: const Color(0xff589FB6),
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
