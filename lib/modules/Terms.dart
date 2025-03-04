import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''
By using this application, you agree to the terms of use, including compliance with laws, respecting intellectual property, and not disrupting the service. We may collect personal data (name, email, location) to enhance user experience, ensuring privacy and security without sharing data with third parties unless required by law. The app may request access to your camera, storage, or location for specific features, which you can manage in your device settings. You can uninstall the app anytime, and to delete your data, contact us at contact@genbox.com. Continued use implies acceptance of these terms
                  ''',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back or navigate to home
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
