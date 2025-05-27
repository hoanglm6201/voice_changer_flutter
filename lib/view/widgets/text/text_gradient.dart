import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';

class TextGradient extends StatelessWidget {
  final LinearGradient gradientColor;
  final String text;
  final TextStyle? style;

  const TextGradient({
    super.key,
    this.gradientColor = ResColors.primaryGradient,
    required this.text,
    this.style = const TextStyle(
      fontSize: 17.81,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradientColor.createShader(bounds),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
