import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_preview/processing_screen.dart';
import 'package:voice_changer_flutter/view/screen/result/widget/file_video.dart';
import 'package:voice_changer_flutter/view/screen/result/widget/file_voice.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class AiVoicePreviewScreen extends StatefulWidget {
  final VoiceModel voiceModel;
  final bool isAudio;
  final String? path;
  const AiVoicePreviewScreen({super.key, required this.voiceModel, required this.isAudio, this.path});

  @override
  State<AiVoicePreviewScreen> createState() => _AiVoicePreviewScreenState();
}

class _AiVoicePreviewScreenState extends State<AiVoicePreviewScreen> {
  final GlobalKey<FileVideoState> _videoKey = GlobalKey<FileVideoState>();
  final GlobalKey<FileVoiceState> _voiceKey = GlobalKey<FileVoiceState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title:Text(context.locale.preview, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
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
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(child: widget.isAudio ? FileVoice(key: _voiceKey, audioPath: widget.path,) : FileVideo(key: _videoKey, videoPath: widget.path,)),
            SizedBox(height: 40),
            _buildButtons(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [Color(0xFFF0A1F2), Color(0xFF6637F9)])
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFFF0A1F2), Color(0xFF6637F9)],
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      context.locale.retake,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                if (!widget.isAudio) {
                  _videoKey.currentState?.pauseVideo();
                }else{
                  _voiceKey.currentState?.pauseAudio();
                }
                await Future.delayed(Duration(milliseconds: 200));
                Navigator.push(context, CupertinoPageRoute(builder: (context) => ProcessingScreen(voiceModel: widget.voiceModel, isAudio: widget.isAudio, path: widget.path,)));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [Color(0xFFF0A1F2), Color(0xFF6637F9)])
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [Color(0xFFF0A1F2), Color(0xFF6637F9)])
                  ),
                  child: Text(context.locale.continue_action,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSeeMoreList(BuildContext context){
    final width = MediaQuery.of(context).size.width - 50;
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25).copyWith(bottom: paddingBottom),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          6,
              (index) {
            final VoiceModel voice = voiceList[index];
            return Container(
              width: width / 4 - 8,
              height: (width / 4 - 8) * 1.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(voice.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.7, sigmaY: 3.7),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            color: Colors.black.withValues(alpha: 0.1),
                            child: Center(
                              child: Text(
                                voice.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black45,
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
