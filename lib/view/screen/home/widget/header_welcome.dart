import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/font.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';

class HeaderWelcome extends StatelessWidget {
  const HeaderWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            context.locale.welcome_to,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              fontFamily: ResFont.belanosima,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            context.locale.voice_changer,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              fontFamily: ResFont.belanosima,
            ),
          ),
        ),
      ],
    );
  }
}
