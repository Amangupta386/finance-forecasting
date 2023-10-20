import 'package:ddofinance/theme/color_constants.dart';
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
    final paint = Paint()
      ..color = kGrey
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
