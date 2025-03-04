import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
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
                  Privacy Policy

Effective Date: 03/03/2025

1. Introduction
At Technolypse , we value and respect your privacy. This Privacy Policy explains how we collect, use, and protect your personal information when you use our mobile app.

2. Information We Collect
We collect the following types of information:

Personal Information: When you use our app, we may ask for personal information such as your name, email address, and other relevant data to provide a personalized experience.
Usage Data: We collect information about how you interact with the app, including device information, IP address, pages visited, and app usage patterns.
Permissions: The app may request certain permissions (e.g., access to camera, location, storage) to provide full functionality.
3. How We Use Your Information
We use the information we collect for the following purposes:

To provide and improve our services
To personalize your experience
To send important notifications or updates
To ensure the security and functionality of the app
4. Sharing Your Information
We do not sell or rent your personal information to third parties. However, we may share your data in the following situations:

With service providers: To facilitate the app's functionality.
For legal reasons: If required by law or to protect our rights.
5. Data Security
We implement reasonable security measures to protect your personal data from unauthorized access, alteration, or destruction. However, no data transmission over the internet is completely secure, so we cannot guarantee full protection.

6. Your Rights
You have the right to:

Access and update your personal information.
Request the deletion of your account and data.
Opt-out of marketing communications.
7. Third-Party Services
Our app may contain links to third-party services that are not operated by us. We are not responsible for the content or privacy practices of these third-party sites.

8. Children’s Privacy
Our app is not intended for children under the age of 13, and we do not knowingly collect personal information from children. If we learn that we have inadvertently collected personal information from a child, we will take steps to delete it.

9. Changes to This Privacy Policy
We may update this Privacy Policy from time to time. We will notify users of any significant changes by posting the updated policy in the app or through other appropriate means.

10. Contact Us
If you have any questions or concerns about this Privacy Policy, please contact us at contact@technolypse.com.
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
