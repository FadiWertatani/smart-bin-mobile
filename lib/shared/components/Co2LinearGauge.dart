import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Co2LinearGauge extends StatelessWidget {
  final double value;
  final double max;

  const Co2LinearGauge({super.key, required this.value, required this.max});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gaugeWidth = MediaQuery.of(context).size.width * 0.85;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CO₂ Saved',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: gaugeWidth,
          child: SfLinearGauge(
            minimum: 0,
            maximum: max,
            showTicks: false,
            showLabels: false,
            axisTrackStyle: LinearAxisTrackStyle(
              thickness: 12,
              edgeStyle: LinearEdgeStyle.bothCurve,
              color: Colors.grey[300],
            ),
            barPointers: [
              LinearBarPointer(
                value: value,
                color: colorScheme.primary,
                thickness: 12,
              ),
            ],
            markerPointers: [
              LinearWidgetPointer(
                value: value,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          '${value.toInt()}g saved',
          style: TextStyle(fontSize: 14, color: colorScheme.secondary),
        ),
      ],
    );
  }
}
