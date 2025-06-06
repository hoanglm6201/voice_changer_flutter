import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/ai_voice_changer_screen.dart';
import 'package:voice_changer_flutter/view/screen/prank_sound/prank_sound_screen.dart';
import 'package:voice_changer_flutter/view/screen/text_to_audio/text_to_audio_screen.dart';

class OptionList extends StatelessWidget {
  const OptionList({super.key});

  List<Map<String, dynamic>> options(BuildContext context) =>  [
    {
      'icon': ResImages.voiceChange,
      'title': context.locale.voice_changer,
      'onTap': () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => AiVoiceChangerScreen(voiceModel: voiceList.first, isAIVoiceChanger: false,),
          ),
        );
      }
    },
    {
      'icon': ResImages.textToAudio,
      'title': context.locale.text_to_audio,
      'onTap': () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TextToAudioScreen(),
          ),
        );
      }
    },
    {
      'icon': ResImages.prankSound,
      'title': context.locale.prank_sound,
      'onTap': () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PrankSoundScreen(),
          ),
        );
      }
    },
    {
      'icon': ResImages.prankReel,
      'title': context.locale.prankReels,
      'onTap': () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TextToAudioScreen(),
          ),
        );
      }
    },
    {
      'icon': ResImages.pdfToAudio,
      'title': context.locale.pdf_to_audio,
      'onTap': () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TextToAudioScreen(),
          ),
        );
      }
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
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: option['onTap'],
            child: Column(
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
            ),
          );
        }).toList(),
      ),
    );
  }
}
