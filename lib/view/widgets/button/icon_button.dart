import 'package:flutter/material.dart';

class IconButtonCustomStyle {
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;

  const IconButtonCustomStyle({
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.shape = BoxShape.rectangle,
  });
}

class IconButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final IconButtonCustomStyle style;

  const IconButtonCustom({
    super.key,
    this.onPressed,
    required this.icon,
    this.style = const IconButtonCustomStyle()
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: style.backgroundColor ?? Colors.white,
          // Only set borderRadius when shape is rectangle
          borderRadius: style.shape == BoxShape.rectangle
              ? BorderRadius.circular(style.borderRadius ?? 15)
              : null,
          shape: style.shape,
        ),
        padding: style.padding ?? const EdgeInsets.all(11.0),
        child: icon,
      ),
    );
  }
}