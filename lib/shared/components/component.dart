import 'package:flutter/material.dart';


//text input
Widget textField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? textValidator,
  bool obscure = false,
  String? label,
  Widget? prefixIcon,
  Widget? suffixIcon,
  readOnly = false,
  textCap = false,
  ValueChanged<String>? onSubmit,
}) => Container(
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(30),
  ),
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Enter your email',
      hintStyle: TextStyle(color: Colors.grey.shade500),
      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade500),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
    ),
  ),
);


//POPUP
void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing on tap outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade50,
              child: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Success",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your account has been successfully registered",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                // Navigate to home screen
                Navigator.pushReplacementNamed(context, "/home");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                "Go to Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}