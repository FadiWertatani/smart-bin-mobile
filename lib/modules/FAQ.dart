import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
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
Frequently Asked Questions (FAQ)

What is this app used for?
This app provides users to supervise and controle trashbins .

Is the app free to use?
Yes, the basic features are free. However, some advanced features may require a subscription or in-app purchases.

What permissions does the app require?
The app may request access to your camera, location, or storage to enable specific features. You can manage these permissions in your device settings.

How is my data protected?
We prioritize user privacy and implement security measures to protect your data. Your information is not shared with third parties without consent.

Can I delete my account and data?
Yes, you can delete your data by contacting our support team at contact@technolypse.com.

What should I do if I encounter a problem?
If you experience any issues, please reach out to our support team through the app or email us at [your email].

How often is the app updated?
We regularly update the app to improve performance, add new features, and enhance security.
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
