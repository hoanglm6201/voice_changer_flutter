import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;
  final bool centerTitle;
  final TextStyle? titleTextStyle;
  final double actionsSpacing;

  const AppBarCustom({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor = Colors.blue,
    this.elevation = 4.0,
    this.centerTitle = true,
    this.titleTextStyle,
    this.actionsSpacing = 8.0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: kToolbarHeight,
        child: Stack(
          children: [
            if (leading != null)
              Align(alignment: Alignment.centerLeft, child: leading),
            if (title != null)
              Align(
                alignment:
                centerTitle ? Alignment.center : Alignment.centerLeft,
                child: DefaultTextStyle(style: Theme.of(context).appBarTheme.titleTextStyle!, child: title ?? const Text('')),
              ),
            if (actions != null)
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  spacing: actionsSpacing,
                  mainAxisSize: MainAxisSize.min,
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
