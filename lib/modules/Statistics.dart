import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A2A41), // Dark background color
      appBar: AppBar(
        title: Text("Weekly Stats"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: BarChart(
            BarChartData(
              barGroups: _getBarGroups(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      List<String> days = ["Mn", "Te", "Wd", "Tu", "Tu", "Tu"];
                      return Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          days[value.toInt()],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      );
                    },
                    reservedSize: 20,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.round().toString(),
                      TextStyle(color: Colors.white, fontSize: 14),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    List<double> values = [8, 10, 14, 15, 13, 10]; // Sample data
    return List.generate(values.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index],
            width: 16,
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [Colors.cyanAccent, Colors.blueAccent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    });
  }
}
