import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OverallProgressGauge extends StatelessWidget {
  /// 0..100
  final double percent;

  const OverallProgressGauge({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = percent.clamp(0, 100);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                axisLineStyle: const AxisLineStyle(
                  thickness: 1,
                  thicknessUnit: GaugeSizeUnit.factor,
                  color: Color.fromARGB(255, 76, 152, 238),
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: p.toDouble(),
                    width: 0.15,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    pointerOffset: 0.10,
                    cornerStyle: CornerStyle.bothCurve,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.1,
                    widget: Text(
                      '${p.toStringAsFixed(0)}%',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // const SizedBox(height: 10),
      ],
    );
  }
}
