import 'package:flutter/material.dart';

class DailyStreakWidget extends StatelessWidget {
  final int streak;
  final int goal;

  const DailyStreakWidget({
    super.key,
    required this.streak,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final dotSize = screenWidth < 350 ? 12.0 : 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Streak',
          style: TextStyle(
            fontSize: screenWidth < 350 ? 14 : 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: List.generate(goal, (index) {
            final isActive = index < streak;
            return Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.secondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          '$streak-day streak',
          style: TextStyle(
            fontSize: screenWidth < 350 ? 12 : 14,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
