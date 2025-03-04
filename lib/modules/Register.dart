import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:smar_bin/modules/Login.dart';
import 'package:smar_bin/modules/Privacy.dart';
import 'package:smar_bin/modules/Terms.dart';
import 'package:smar_bin/services/api_service.dart';
import 'package:smar_bin/shared/components/navigator.dart';

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

  // Validation functions
  bool _isValidName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegex.hasMatch(name);
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    if (password.length < 8) return false;

    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
  }

  String? _getPasswordErrorText(String password) {
    if (password.isEmpty) return null;

    List<String> errors = [];

    if (password.length < 8) {
      errors.add("• Le mot de passe doit contenir au moins 8 caractères");
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add("• Au moins une lettre majuscule");
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add("• Au moins une lettre minuscule");
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      errors.add("• Au moins un chiffre");
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      errors.add("• Au moins un caractère spécial (!@#\$%^&*(),.?\":{}|<>)");
    }

    return errors.isEmpty ? null : errors.join('\n');
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            onChanged: (value) {
              setState(() {}); // Refresh to show/hide error text
            },
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
        if (_passwordController.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
            child: Text(
              _getPasswordErrorText(_passwordController.text) ?? "Mot de passe valide ✓",
              style: TextStyle(
                color: _isValidPassword(_passwordController.text) ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
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
                const TextSpan(text: 'I agree to the Technolypse '),
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    color: Color(0xFF5EACC1),
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Terms()),
                      );
                    },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: Color(0xFF5EACC1),
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Privacy()),
                      );
                    },
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
    // Récupération des valeurs
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Liste pour stocker les messages d'erreur
    List<String> errors = [];

    // Validation du nom
    if (name.isEmpty) {
      errors.add("Le nom est requis");
    } else if (!_isValidName(name)) {
      errors.add("Le nom ne doit contenir que des lettres");
    }

    // Validation de l'email
    if (email.isEmpty) {
      errors.add("L'email est requis");
    } else if (!_isValidEmail(email)) {
      errors.add("Format d'email invalide");
    }

    // Validation du mot de passe
    if (password.isEmpty) {
      errors.add("Le mot de passe est requis");
    } else if (!_isValidPassword(password)) {
      errors.add("Le mot de passe ne respecte pas les critères de sécurité");
    }

    // Validation de la clinique
    if (selectedClinic == null) {
      errors.add("Veuillez sélectionner une clinique");
    }

    // Vérification des termes et conditions
    if (!_agreeToTerms) {
      errors.add("Veuillez accepter les termes et conditions");
    }

    // S'il y a des erreurs, on les affiche
    if (errors.isNotEmpty) {
      showErrorDialog(context, errors.join('\n'));
      return;
    }

    // Si tout est valide, on procède à l'inscription
    String responseMessage = await _apiService.registerUser(
      name,
      email,
      password,
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
