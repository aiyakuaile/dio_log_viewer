import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final Color color;

  // 固定宽度模式
  final double? fixedWidth;

  // 宽度比例
  final double? widthFactor;
  final double indicatorSpacing;
  final double radius;
  final double height;

  const CustomTabIndicator({
    required this.color,
    this.fixedWidth,
    this.widthFactor,
    this.indicatorSpacing = 8,
    this.radius = 4,
    this.height = 3,
  }) : assert(
            fixedWidth != null || widthFactor != null, 'One of fixedWidth or widthFactor must be passed in.');

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(
      fixedWidth: fixedWidth,
      widthFactor: widthFactor,
      indicatorSpacing: indicatorSpacing,
      radius: radius,
      color: color,
      height: height,
    );
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final double? fixedWidth;
  final double? widthFactor;
  final double indicatorSpacing;
  final double radius;
  final double height;
  final Color color;

  _CustomTabIndicatorPainter({
    required this.fixedWidth,
    required this.widthFactor,
    required this.indicatorSpacing,
    required this.radius,
    required this.color,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final tabWidth = configuration.size!.width;
    final centerX = offset.dx + tabWidth / 2;

    // 使用哪种模式
    final double indicatorWidth = fixedWidth ?? (tabWidth * (widthFactor ?? 0.12)); // 默认0.12

    final Rect rect = Rect.fromCenter(
      center: Offset(centerX, offset.dy + configuration.size!.height - indicatorSpacing),
      width: indicatorWidth,
      height: height,
    );

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(rect, topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
      paint,
    );
  }
}
