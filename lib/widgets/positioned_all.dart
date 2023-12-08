import 'package:flutter/material.dart';

/// A custom Flutter widget that simplifies positioning a child within a `Stack`.
/// This widget allows you to specify the position of the child using `top`, `bottom`, `left`, or `right` values.
/// It is useful for precise control of a child's position within a `Stack`.
class PositionedAll extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Widget child;
  const PositionedAll({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Use the Positioned widget to set the position of the child within a Stack.
    return Positioned(
        top: top, bottom: bottom, left: left, right: right, child: child);
  }
}
