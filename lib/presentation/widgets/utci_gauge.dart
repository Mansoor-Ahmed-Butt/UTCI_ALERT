import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class UtciGauge extends StatefulWidget {
  final double value;
  final String category;
  final String categoryLabel;
  final double size;

  const UtciGauge({
    super.key,
    required this.value,
    required this.category,
    required this.categoryLabel,
    this.size = 220,
  });

  @override
  State<UtciGauge> createState() => _UtciGaugeState();
}

class _UtciGaugeState extends State<UtciGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(UtciGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: oldWidget.value,
        end: widget.value,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0.0);
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = AppColors.statusColor(widget.category);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final animatedVal = _animation.value;
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _UtciGaugePainter(
            value: animatedVal,
            category: widget.category,
            statusColor: statusColor,
            isDark: isDark,
          ),
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  '${animatedVal.toStringAsFixed(1)}°',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.0,
                        fontSize: widget.size * 0.20,
                        color: statusColor,
                      ),
                ),
                Text(
                  'UTCI Equivalent',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: widget.size * 0.055,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withValues(alpha: 0.65),
                      ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    widget.categoryLabel.toUpperCase(),
                    style: TextStyle(
                      fontSize: widget.size * 0.045,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UtciGaugePainter extends CustomPainter {
  final double value;
  final String category;
  final Color statusColor;
  final bool isDark;

  _UtciGaugePainter({
    required this.value,
    required this.category,
    required this.statusColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 16;

    // 240 degree sweep arc from 150° to 390°
    const startAngle = 150 * (math.pi / 180);
    const totalSweep = 240 * (math.pi / 180);

    // Background track
    final trackPaint = Paint()
      ..color = isDark
          ? const Color(0xFF232730)
          : const Color(0xFFE8EBF0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalSweep,
      false,
      trackPaint,
    );

    // Value mapping: 0°C to 50°C
    final fraction = ((value - 0.0) / 50.0).clamp(0.0, 1.0);
    final activeSweep = totalSweep * fraction;

    // Glowing arc
    final glowPaint = Paint()
      ..color = statusColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    if (activeSweep > 0.02) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        activeSweep,
        false,
        glowPaint,
      );
    }

    // Active gradient progress arc
    final activePaint = Paint()
      ..shader = const SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + totalSweep,
        colors: [
          AppColors.coldStress,
          AppColors.noStress,
          AppColors.moderateStress,
          AppColors.strongStress,
          AppColors.veryStrongStress,
          AppColors.extremeStress,
        ],
        stops: [0.0, 0.25, 0.45, 0.65, 0.82, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    if (activeSweep > 0.02) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        activeSweep,
        false,
        activePaint,
      );
    }

    // Indicator needle dot
    final currentAngle = startAngle + activeSweep;
    final dotX = center.dx + radius * math.cos(currentAngle);
    final dotY = center.dy + radius * math.sin(currentAngle);

    final dotGlow = Paint()
      ..color = statusColor.withValues(alpha: 0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(Offset(dotX, dotY), 10, dotGlow);

    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(dotX, dotY), 6, dotPaint);

    final dotBorder = Paint()
      ..color = statusColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(Offset(dotX, dotY), 6, dotBorder);
  }

  @override
  bool shouldRepaint(covariant _UtciGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.statusColor != statusColor ||
        oldDelegate.isDark != isDark;
  }
}
