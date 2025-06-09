import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/result/result_screen.dart';
import 'package:voice_changer_flutter/view/screen/voice_effect/body/header_voice_effect.dart';
import 'package:voice_changer_flutter/view/screen/voice_effect/body/options_effect_widget.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/dialog/confirm_dialog.dart';

class VoiceEffectScreen extends StatefulWidget {
  final bool? isFromVoiceChanger;
  final bool? isAudio;
  const VoiceEffectScreen({super.key, this.isFromVoiceChanger = false, this.isAudio = true});

  @override
  State<VoiceEffectScreen> createState() => _VoiceEffectScreenState();
}

class _VoiceEffectScreenState extends State<VoiceEffectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: Text(context.locale.voice_effect),
        leading: IconButtonCustom(
          onPressed: () {
            ConfirmDialog(
              imageHeader: ResImages.iconDiscard,
              title: context.locale.discard,
              content: context.locale.discard_des,
              textCancel: context.locale.stay_here,
              textAccept: context.locale.leave,
              onCancelPress: () {
                Navigator.pop(context);
              },
            ).show(context);
          },
          icon: SvgPicture.asset(ResIcon.icBack),
        ),
        actions: [
          IconButtonCustom(
            icon: SvgPicture.asset(
              ResIcon.icCheck,
              colorFilter: ColorFilter.mode(
                ResColors.colorPurple,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => ResultScreen(isVideo: false,isFromProcessing: true,),),);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            ResSpacing.h12,
            HeaderVoiceEffect(isAudio: widget.isAudio,),
            ResSpacing.h24,
            OptionsEffectWidget(),
          ],
        ),
      ),
    );
  }
}
