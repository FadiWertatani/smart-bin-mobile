import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:smar_bin/modules/Login.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/component.dart';
import 'package:smar_bin/shared/components/navigator.dart';
import 'package:dio/dio.dart'; // Import Dio package

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;
  String? selectedClinic;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> clinics = [
    "City Hospital",
    "Green Valley Clinic",
    "Sunrise Care",
    "Health Plus",
    "Wellness Center",
    "Metro Healthcare"
  ];

  final ApiService _apiService = ApiService(); // Use the singleton instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Name field
                  _buildInputField(Iconsax.personalcard, 'Enter your name', _nameController),
                  const SizedBox(height: 16),

                  // Email field
                  _buildInputField(Iconsax.direct, 'Enter your email', _emailController),
                  const SizedBox(height: 16),

                  // Clinic Dropdown (Searchable)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search clinic...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      items: clinics,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Iconsax.hospital, color: Colors.grey.shade500),
                          hintText: "Select your Clinic",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedClinic = newValue;
                        });
                      },
                      selectedItem: selectedClinic,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  _buildPasswordField(),
                  const SizedBox(height: 16),

                  // Terms and Conditions
                  _buildTermsAndConditions(),
                  const SizedBox(height: 24),

                  // Sign Up button
                  _buildSignUpButton(),
                  const SizedBox(height: 24),

                  // Already have an account
                  _buildSignInText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Input Field
  Widget _buildInputField(IconData icon, String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(icon, color: Colors.grey.shade500),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // Password Field
  Widget _buildPasswordField() {
    return Container(
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
    );
  }

  // Terms and Conditions
  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(color: Colors.grey.shade400),
            activeColor: const Color(0xFF5EACC1),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              children: [
                const TextSpan(text: 'I agree to the genbox '),
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    color: Color(0xFF5EACC1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: Color(0xFF5EACC1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Sign Up Button
  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _agreeToTerms ? _registerUser : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5EACC1),
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Already have an account
  Widget _buildSignInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            normalPush(context: context, direction: LoginScreen());
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Color(0xFF5EACC1),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _registerUser() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty || selectedClinic == null) {
      showErrorDialog(context, 'Please fill all fields');
      return;
    }

    String responseMessage = await _apiService.registerUser(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
      selectedClinic!,
    );

    if (responseMessage.contains('success')) {
      showSuccessDialog(context);
    } else {
      showErrorDialog(context, responseMessage);
    }
  }


  // Show success dialog
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Registration successful!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                normalPush(context: context, direction: LoginScreen());
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Show error dialog
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
