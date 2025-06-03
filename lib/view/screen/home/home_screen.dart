import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/font.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/ai_voice_changer_screen.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/banner_home.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/header_welcome.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/option_list.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: IconButtonCustom(
          icon: SvgPicture.asset(ResIcon.icUpload),
          onPressed: () {},
          style: const IconButtonCustomStyle(
            backgroundColor: Colors.white,
            iconColor: Colors.white,
            borderRadius: 15,
            padding: EdgeInsets.all(11.0),
          ),
        ),
        actions: [
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icSetting),
            onPressed: () {},
            style: const IconButtonCustomStyle(
              backgroundColor: Colors.white,
              iconColor: Colors.white,
              borderRadius: 15,
              padding: EdgeInsets.all(11.0),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResSpacing.h24,
            HeaderWelcome(),
            ResSpacing.h24,
            OptionList(),
            ResSpacing.h28,
            BannerHome(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => AiVoiceChangerScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
