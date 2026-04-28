import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OverallProgressGauge extends StatelessWidget {
  final double percent;
  final String? centerLabel;
  final String? bottomLabel;

  const OverallProgressGauge({
    super.key,
    required this.percent,
    this.centerLabel,
    this.bottomLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = percent.clamp(0, 100).toDouble();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.16,
                  thicknessUnit: GaugeSizeUnit.factor,
                  color: theme.colorScheme.primary.withValues(alpha: 0.16),
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: p,
                    width: 0.16,
                    color: theme.colorScheme.primary,
                    cornerStyle: CornerStyle.bothCurve,
                    sizeUnit: GaugeSizeUnit.factor,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.08,
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${p.toStringAsFixed(0)}%',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (centerLabel != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            centerLabel!,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (bottomLabel != null) ...[
          const SizedBox(height: 4),
          Text(
            bottomLabel!,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ],
    );
  }
}
