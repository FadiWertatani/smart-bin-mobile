import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StatGauge extends StatelessWidget {
  final String label;
  final double value;
  final double max;
  final String unit;

  const StatGauge({
    super.key,
    required this.label,
    required this.value,
    required this.max,
    this.unit = '',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust size based on available width
        final double gaugeSize = constraints.maxWidth * 0.8;
        final double fontSize = constraints.maxWidth * 0.1;
        final double labelFontSize = constraints.maxWidth * 0.08;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: gaugeSize,
              height: gaugeSize,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: max,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 150,
                    endAngle: 30,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.15,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: Colors.grey.shade200,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: value,
                        width: 0.15,
                        color: Colors.indigo.shade900,
                        sizeUnit: GaugeSizeUnit.factor,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          '${value.toInt()}$unit',
                          style: TextStyle(
                            fontSize: fontSize.clamp(12, 24),
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
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
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize.clamp(10, 18),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
