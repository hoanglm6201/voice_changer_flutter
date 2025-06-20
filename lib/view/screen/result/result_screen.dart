import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';
import 'package:voice_changer_flutter/service/video_merge_helper.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/ai_voice_list_screen.dart';
import 'package:voice_changer_flutter/view/screen/result/widget/file_video.dart';
import 'package:voice_changer_flutter/view/screen/result/widget/file_voice.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/dialog/confirm_dialog.dart';
import 'package:voice_changer_flutter/view/widgets/dialog/download_dialog.dart';

class ResultScreen extends StatefulWidget {
  final bool? isFromProcessing;
  final bool isVideo;
  final String? path;

  const ResultScreen({super.key, required this.isVideo, this.isFromProcessing = false, this.path});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isDownloaded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 50;
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBarCustom(
        leading: IconButtonCustom(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ResIcon.icBack),
        ),
        actions: [
          if(widget.isFromProcessing == false)
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icDelete),
            onPressed: () {
              final ConfirmDialog confirmDialog = ConfirmDialog(
                imageHeader: ResImages.deleteHeader,
                title: context.locale.delete,
                content: context.locale.sub_delete,
                textCancel: context.locale.keep_it,
                textAccept: context.locale.delete,
              );
              confirmDialog.show(context);
            },
            style: IconButtonCustomStyle(padding: EdgeInsets.all(8)),
          ),
          if(widget.isFromProcessing == true)
          IconButtonCustom(
            icon: SvgPicture.asset(_isDownloaded ? ResIcon.icDownloadSuccess : ResIcon.icDownload),
            onPressed: () async {
              print('heheh');
              final status = await Permission.storage.request();
              print(status);
              // if (!status.isGranted) {
              //   print("❌ Permission denied");
              //   return;
              // }
              print('object');
              // if (widget.path != null) {
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Dialog(
                    child: DownloadDialog(
                      onDownloadSuccess: (bool isDownloadSuccess) {
                        setState(() {
                          _isDownloaded = isDownloadSuccess;
                        });
                      },
                      path: widget.path,
                      isVideo: widget.isVideo,
                    ),
                  ),
                );
              // }
            },
            style: IconButtonCustomStyle(padding: EdgeInsets.all(8)),
          ),
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icShare),
            onPressed: () {
              ///SHARE
            },
            style: IconButtonCustomStyle(padding: EdgeInsets.all(8)),
          ),
          if (widget.isFromProcessing == true)
            IconButtonCustom(
              icon: SvgPicture.asset(ResIcon.icHomeResult),
              onPressed: () {
                Navigator.popUntil(context, (route) {
                  return route.isFirst;
                });
              },
              style: IconButtonCustomStyle(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          ResSpacing.h14,
          Expanded(child: widget.isVideo ? FileVideo(videoPath: widget.path,) : FileVoice(audioPath: widget.path,),),
          ResSpacing.h14,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AiVoiceListScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    spacing: 3.5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ResIcon.icFire,
                        width: 16,
                        height: 16,
                      ),
                      Text(
                        context.locale.hot_voices,
                        style: TextStyle(
                          color: ResColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    context.locale.see_more,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: ResColors.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ResSpacing.h8,
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25)
                .copyWith(bottom: paddingBottom),
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
                                filter:
                                    ImageFilter.blur(sigmaX: 3.7, sigmaY: 3.7),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
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
          )
        ],
      ),
    );
  }
}
