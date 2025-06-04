import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/gradient_button.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class TextToAudioScreen extends StatefulWidget {
  const TextToAudioScreen({super.key});

  @override
  State<TextToAudioScreen> createState() => _TextToAudioScreenState();
}

class _TextToAudioScreenState extends State<TextToAudioScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(
        leading: IconButtonCustom(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ResIcon.icBack),
        ),
        title: Text(context.locale.text_to_audio_2),
      ),
      body: Column(

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientButton(
        height: kBottomNavigationBarHeight / 1.2,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 24),
        style: GradientButtonStyle(
          borderRadius: BorderRadius.circular(15),
        ),
        onTap: () {},
        child: Center(
          child: Text(
            context.locale.continuee,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
