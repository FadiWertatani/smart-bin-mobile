import 'package:flutter/material.dart';
import 'package:smar_bin/shared/components/DailyStreakWidget.dart';
import 'package:smar_bin/shared/components/GiftPointsWidget.dart';
import 'package:smar_bin/shared/components/RecyclablePieChart.dart';
import 'package:smar_bin/shared/components/TopRankGauge.dart';
import 'package:smar_bin/shared/components/TrashBarChart.dart';
import '../shared/components/Co2LinearGauge.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Your Stats',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Track your eco impact',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              GiftPointsWidget(points: 420, maxPoints: 1000),
              SizedBox(height: 20),
              TrashBarChart(count: 200),
              SizedBox(height: 20),
              RecyclablePieChart(bottles: 45, cans: 21, cartons: 10),
              SizedBox(height: 20),
              Co2LinearGauge(value: 360, max: 1000),
              SizedBox(height: 20),
              DailyStreakWidget(streak: 5, goal: 30),
              SizedBox(height: 20),
              TopRankGauge(value: 15),
            ],
          ),
        ),
      ),
    );
  }
}
