import 'package:flutter/material.dart';

class IconButtonCustomStyle {
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const IconButtonCustomStyle({
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });
}

class IconButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final IconButtonCustomStyle? style;
  const IconButtonCustom({super.key, this.onPressed, required this.icon, this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: style?.backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(style?.borderRadius ?? 15),
        ),
        padding: style?.padding ?? const EdgeInsets.all(11.0),
        child: icon,
      ),
    );
  }
}
