import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key});
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class LinearIndicator extends StatelessWidget {
  const LinearIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator();
  }
}