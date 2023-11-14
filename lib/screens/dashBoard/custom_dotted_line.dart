import 'package:ddofinance/routing/app_router.dart';
import 'package:flutter/material.dart';

class CustomDottedLine extends StatelessWidget {
  const CustomDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left:0),
      width: double.infinity,
      height: 1,
      child: CustomPaint(
        painter: DottedLinePainter(),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final ThemeData theme = Theme.of(rootNavigatorKey.currentState!.context);
    final ColorScheme colorTheme = theme.colorScheme;


    final paint = Paint()
      ..color = colorTheme.onPrimary
      ..strokeWidth = 1;

    const dashWidth = 4;
    const dashSpace = 5;

    double startX = 0;
    double endX = size.width;

    while (startX < endX) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
