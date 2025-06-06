import 'dart:math';

import 'package:flutter/material.dart';

class ResColors {
  ResColors._();


  static const Color lightPinkPurple = Color(0xFFF0A1F2);
  static const Color deepViolet = Color(0xFF6637F9);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [lightPinkPurple, deepViolet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(
      pi / 5,
    ),
  );

  static const Color textColor = Color(0xFF4E4E4E);
  static const Color colorGray = Color(0xFFB6BDC5);
  static const Color softPurple = Color(0xFFB070F5);
  static const Color darkBlueBlack = Color(0xFF071822);
  static const Color colorPurple = Color(0xFF9373FE);
}