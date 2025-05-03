import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TopRankGauge extends StatelessWidget {
  final double value; // 0–100 (e.g. 15 means Top 15%)

  const TopRankGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gaugeSize = MediaQuery.of(context).size.width * 0.8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Rank',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: gaugeSize,
          height: gaugeSize / 2,
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: 100,
                startAngle: 180,
                endAngle: 0,
                showTicks: false,
                showLabels: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.15,
                  thicknessUnit: GaugeSizeUnit.factor,
                  color: Colors.grey.shade300,
                ),
                pointers: [
                  RangePointer(
                    value: 100 - value, // Lower is better
                    color: colorScheme.primary,
                    width: 0.15,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: Text(
                      'Top ${value.toInt()}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
