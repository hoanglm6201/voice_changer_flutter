import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';

class GradientButtonStyle {
  final Gradient? gradient;
  final BoxShape shape;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const GradientButtonStyle({
    this.gradient,
    this.shape = BoxShape.rectangle,
    this.border,
    this.borderRadius,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 16,
        offset: Offset(0, 2),
      ),
    ],
  });

  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
      gradient: gradient ?? ResColors.primaryGradient,
      shape: shape,
      border: border,
      borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
      boxShadow: boxShadow,
    );
  }
}


class GradientButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final GradientButtonStyle style;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const GradientButton({
    super.key,
    required this.onTap,
    required this.child,
    this.style = const GradientButtonStyle(),
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: style.toBoxDecoration(),
        child: child,
      ),
    );
  }
}
