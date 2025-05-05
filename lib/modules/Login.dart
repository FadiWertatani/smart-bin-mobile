import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smar_bin/layout/CollectorLayout.dart';
import 'package:smar_bin/layout/HomeLayout.dart';
import 'package:smar_bin/modules/CollectorHomeScreen.dart';
import 'package:smar_bin/modules/Register.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/component.dart';
import 'package:smar_bin/shared/components/navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginScreen extends StatefulWidget {
  final String profileType;

  const LoginScreen({Key? key, required this.profileType}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          AppLocalizations.of(context)!.login,
          style: const TextStyle(
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
                      hintText: localizations.emailHint,
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
                      hintText: localizations.passwordHint,
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
                      foregroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      localizations.forgotPassword,
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
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                      localizations.login,
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
                      localizations.dontHaveAccount,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        normalPush(context: context, direction: RegisterScreen(profileType: widget.profileType,));
                      },
                      child: Text(
                        " ${localizations.signUp}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
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

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      flutterToast(message: "Email and Password are necessary", backgroundColor: Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var response = await ApiService().loginUser(email, password);

      if (response.containsKey('error')) {
        String errorMessage = response['error'];

        if (errorMessage == 'Email not found') {
          flutterToast(message: "Email Invalid!", backgroundColor: Colors.red);
        }
        else if (errorMessage == 'Incorrect password') {
          flutterToast(message: "Password Incorrect!", backgroundColor: Colors.red);
        }
        else {
          flutterToast(message: errorMessage, backgroundColor: Colors.red);
        }
      }
      else if (response.containsKey('token')) {
        // Retrieve user data from response
        // Map<String, dynamic> userData = response['user'];
        // String userCode = userData['user_code'];

        // Store user_code in SharedPreferences if not already saved
        // if (await SharedPrefsHelper.getUserCode() == null) {
        //   await SharedPrefsHelper.saveUserCode(userCode);
        // }

        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          noBackPush(context: context, direction: CollectorLayout());
        }
      }
    } catch (e) {
      flutterToast(message: "Connexion error", backgroundColor: Colors.orangeAccent);
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

}
