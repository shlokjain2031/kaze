import 'dart:math';

import 'package:flutter/material.dart';

import 'colours.dart';

class MyArc extends StatelessWidget {
  final double diameter;
  final double piMultiplier;

  const MyArc({Key key, this.diameter = 200, this.piMultiplier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(piMultiplier),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  final double piMultiplier;

  MyPainter(this.piMultiplier);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colours().white()
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.5;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      4.71239,
      pi * piMultiplier,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}