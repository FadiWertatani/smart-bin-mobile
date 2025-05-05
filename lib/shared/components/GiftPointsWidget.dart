import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GiftPointsWidget extends StatelessWidget {
  final double points;
  final double maxPoints;

  const GiftPointsWidget({
    super.key,
    required this.points,
    required this.maxPoints,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final gaugeSize = screenWidth * 0.6; // Responsive gauge size

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Gift Points',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: gaugeSize,
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: maxPoints,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.15,
                  thicknessUnit: GaugeSizeUnit.factor,
                  color: colorScheme.secondary.withOpacity(0.2),
                ),
                pointers: [
                  RangePointer(
                    value: points,
                    width: 0.15,
                    color: colorScheme.outlineVariant,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: Text(
                      '${points.toInt()} pts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.outlineVariant,
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
