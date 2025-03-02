import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smar_bin/layout/HomeLayout.dart';
import 'package:smar_bin/modules/HomeScreen.dart';
import 'package:smar_bin/modules/Register.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Fonction pour afficher un message
  void _showMessage(String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _login() async {
    // Récupération des valeurs
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Vérification des champs vides
    if (email.isEmpty || password.isEmpty) {
      _showMessage("Email et mot de passe sont requis", true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var response = await ApiService().loginUser(email, password);

      if (response.containsKey('error')) {
        // Gestion des différents types d'erreurs
        String errorMessage = response['error'];
        if (errorMessage.contains('not found')) {
          _showMessage("Adresse email invalide", true);
        } else if (errorMessage.contains('password')) {
          _showMessage("Mot de passe incorrect", true);
        } else {
          _showMessage(errorMessage, true);
        }
      } else if (response.containsKey('token')) {
        // Récupération du user_code
        String? userCode = await ApiService().fetchUserCode(email);

        if (userCode != null) {
          // Sauvegarde du user_code si nécessaire
          if (await SharedPrefsHelper.getUserCode() == null) {
            await SharedPrefsHelper.saveUserCode(userCode);
          }
        }

        // Message de succès et navigation
        _showMessage("Connexion réussie", false);
        
        // Attendre que le message soit affiché avant de naviguer
        await Future.delayed(const Duration(seconds: 1));
        
        // Navigation vers la page d'accueil
        if (mounted) {
          normalPush(context: context, direction: HomeLayout());
        }
      }
    } catch (e) {
      _showMessage("Erreur de connexion: $e", true);
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Email field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Iconsax.direct, color: Colors.grey.shade500),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Iconsax.lock, color: Colors.grey.shade500),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add Forgot Password functionality
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF5EACC1),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5EACC1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Don't have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        normalPush(context: context, direction: RegisterScreen());
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF5EACC1),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
