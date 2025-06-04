import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';
import 'package:voice_changer_flutter/view/screen/result/result_screen.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/item/voices_item.dart';

class ProcessingScreen extends StatefulWidget {
  final VoiceModel voiceModel;
  const ProcessingScreen({super.key, required this.voiceModel});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => ResultScreen(isVideo: false,),));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBarCustom(
        title:Text(context.locale.preview, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        leading: IconButtonCustom(
          icon: SvgPicture.asset(ResIcon.icClose),
          onPressed: () {
            Navigator.pop(context);
          },
          style: const IconButtonCustomStyle(
            backgroundColor: Colors.white,
            borderRadius: 15,
            padding: EdgeInsets.all(11.0),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          VoicesItem(voiceModel: widget.voiceModel, height: screenSize * 0.35, width: screenSize * 0.26,),
          SizedBox(height: 28),
          Text(context.locale.processing, style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 12),
          Text(context.locale.processing_des_1, style: TextStyle( fontSize: 12, fontWeight: FontWeight.w400),),
          Text(context.locale.processing_des_2, style: TextStyle( fontSize: 12, fontWeight: FontWeight.w400),),
          SizedBox(height: 36),
          Lottie.asset('assets/anim/anim_audio.json')
        ],
      ),
    );
  }
}
