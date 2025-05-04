import 'package:flutter/material.dart';
import 'package:smar_bin/shared/components/DailyStreakWidget.dart';

class DailyStreakScreen extends StatelessWidget {
  const DailyStreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4), // Added spacing between texts
            Text(
              'Choose your preferred language.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // Increased from 70 to 80
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: DailyStreakWidget(streak: 5, goal: 30),
        ),
      ),
    );
  }
}
