import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/ai_voice_list_screen.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/banner_home.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/header_welcome.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/hot_voice.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/option_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.push(context, CupertinoPageRoute(builder: (context) => AiVoiceListScreen()));
              },
            ),
            ResSpacing.h24,
            HotVoice(),
            SizedBox(height: kBottomNavigationBarHeight,)
          ],
        ),
      ),
    );
  }
}