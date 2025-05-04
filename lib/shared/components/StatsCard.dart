import 'package:flutter/material.dart';

class StatInfoCard extends StatelessWidget {
  final String title, summary, date, time, status;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const StatInfoCard({
    super.key,
    required this.title,
    required this.summary,
    required this.date,
    required this.time,
    required this.status,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
            const SizedBox(height: 8),
            Text(summary,
                style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.9))),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: textColor),
                const SizedBox(width: 4),
                Text(date, style: TextStyle(fontSize: 12, color: textColor)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: textColor),
                const SizedBox(width: 4),
                Text(time, style: TextStyle(fontSize: 12, color: textColor)),
              ],
            ),
            const SizedBox(height: 8),
            Text(status,
                style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
}
