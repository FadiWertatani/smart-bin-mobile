import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RecyclablePieChart extends StatelessWidget {
  final int bottles;
  final int cans;
  final int cartons;

  const RecyclablePieChart({
    super.key,
    required this.bottles,
    required this.cans,
    required this.cartons,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final total = bottles + cans + cartons;
    final chartHeight = MediaQuery.of(context).size.width * 0.6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recyclables',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: chartHeight,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: bottles.toDouble(),
                  title: 'Bottles',
                  color: colorScheme.primary,
                  radius: 50,
                  titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                PieChartSectionData(
                  value: cans.toDouble(),
                  title: 'Cans',
                  color: Colors.indigo.shade900,
                  radius: 50,
                  titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                PieChartSectionData(
                  value: cartons.toDouble(),
                  title: 'Cartons',
                  color: Colors.indigo.shade300,
                  radius: 50,
                  titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        Text(
          'Total: $total items',
          style: TextStyle(fontSize: 14, color: colorScheme.secondary),
        ),
      ],
    );
  }
}
