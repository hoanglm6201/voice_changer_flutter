import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/ai_voice_changer_screen.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/item/voices_item.dart';

class AiVoiceListScreen extends StatelessWidget {
  const AiVoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: Text(context.locale.voice_list, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        leading: IconButtonCustom(
          icon: SvgPicture.asset(ResIcon.icBack),
          onPressed: () {
            Navigator.pop(context);
          },
          style: const IconButtonCustomStyle(
            backgroundColor: Colors.white,
            borderRadius: 15,
            padding: EdgeInsets.all(11.0),
          ),
        )
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: aiVoiceChanger.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 0.76,
          mainAxisSpacing: 10
        ),
        itemBuilder: (context, index) {
          final voiceModel = aiVoiceChanger[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => AiVoiceChangerScreen(voiceModel: voiceModel,)));
            },
            child: VoicesItem(
            voiceModel: voiceModel)
          );
        },
      ),
    );
  }
}
