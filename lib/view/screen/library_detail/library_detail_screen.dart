import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class LibraryDetailScreen extends StatelessWidget {
  final bool isVideo;
  const LibraryDetailScreen({super.key, required this.isVideo});

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
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icDelete),
            onPressed: () {},
            style: IconButtonCustomStyle(padding: EdgeInsets.all(8)),
          ),
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icShare),
            onPressed: () {},
            style: IconButtonCustomStyle(padding: EdgeInsets.all(8)),
          ),
        ],
      ),
      body: Column(
        children: [
          ResSpacing.h14,
          Expanded(child: Placeholder(),),
          ResSpacing.h14,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
          ResSpacing.h8,
          SingleChildScrollView(
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
          )
        ],
      ),
    );
  }
}
