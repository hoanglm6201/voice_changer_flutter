import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';

class OptionList extends StatelessWidget {
  const OptionList({super.key});

  List<Map<String, dynamic>> options(BuildContext context) =>  [
        {
          'icon': ResImages.voiceChange,
          'title': context.locale.voice_changer,
        },
        {
          'icon': ResImages.textToAudio,
          'title': context.locale.text_to_audio,
        },
        {
          'icon': ResImages.prankSound,
          'title': context.locale.prank_sound,
        },
        {
          'icon': ResImages.prankReel,
          'title': context.locale.prankReels,
        },
        {
          'icon': ResImages.pdfToAudio,
          'title': context.locale.pdf_to_audio,
        },

      ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 16,
        children: options(context).map((option) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(233, 236, 248, 0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                    ),
                  ]
                ),
                child: Image.asset(
                  option['icon'],
                  width: 28,
                  height: 28
                ),
              ),
              ResSpacing.h8,
              Text(
                option['title'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
