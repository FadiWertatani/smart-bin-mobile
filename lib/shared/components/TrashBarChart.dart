import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrashBarChart extends StatelessWidget {
  final int count;

  const TrashBarChart({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Trash Thrown',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(
                    toY: count.toDouble(),
                    width: 20,
                    color: Colors.indigo.shade900,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ]),
              ],
            ),
          ),
        ),
        Text('$count items',
            style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
