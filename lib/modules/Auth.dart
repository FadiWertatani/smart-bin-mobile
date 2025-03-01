import 'package:flutter/material.dart';
import 'package:smar_bin/modules/Login.dart';
import 'package:smar_bin/modules/Register.dart';
import 'package:smar_bin/shared/components/navigator.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Status bar area
              const SizedBox(height: 40),

              // Logo section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // GENBOX Logo
                    Image.asset(
                      'assets/images/logo.png',
                      height: 250,
                    ),
                    const SizedBox(height: 40),

                    // Let's get started text
                    const Text(
                      "Let's get started!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtitle text
                    const Text(
                      "Login to enjoy the features we've provided, and stay healthy!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          normalPush(context: context, direction: LoginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5EACC1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sign Up button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          normalPush(context: context, direction: RegisterScreen());
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF5EACC1),
                          side: const BorderSide(
                            color: Color(0xFF5EACC1),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom area
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}