import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smar_bin/shared/components/navigator.dart';

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
}) =>
    Container(
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

//button
Widget button({
  required VoidCallback toDo,
  required String text,
  fontSize = 18.0,
  Color textColor = Colors.white,
  Color buttonColor = const Color(0xff4647ed),
  double height = 48.0,
  double width = double.infinity,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: MaterialButton(
        onPressed: toDo,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: textColor,
          ),
        ),
      ),
    );

Widget profileSettingCard({
  context,
  required IconData icon,
  required String title,
  String? field,
  required String userId,
  required String profileType,
  GestureTapCallback? toDo,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 1,
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          subtitle: Text(
            "data here",
            style: TextStyle(
              color: field == null
                  ? const Color(0xffFFAB2F)
                  : (field == 'password'
                      ? const Color(0xffFFAB2F)
                      : const Color(0xff716969)),
            ),
          ),
          trailing: Icon(
            title == 'Email' ? Iconsax.safe_home3 : Iconsax.arrow_circle_right,
            color: Theme.of(context).primaryColor,
          ),
          onTap: toDo,
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

flutterToast({
  required String message,
  required backgroundColor,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int time = 1,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: time,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);

Widget sectionTitle({
  required final String text,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );

Widget customListTile({
  required final IconData icon,
  required final String title,
}) =>
    ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Iconsax.arrow_right_3, size: 20),
      onTap: () {
        // Handle tile tap
      },
    );

Widget buildSettingsItem({
  required IconData icon,
  required String label,
  required BuildContext context,
  Widget? direction,
}) {
  return GestureDetector(
    onTap: () => normalPush(context: context, direction: direction!),
    child: Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: label == 'Logout' ? Colors.red : Theme.of(context).primaryColor,
          size: 24,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: label == 'Logout' ? Colors.red : Colors.black,
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
  );
}