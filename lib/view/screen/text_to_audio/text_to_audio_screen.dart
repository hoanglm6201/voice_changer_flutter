import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/gradient_button.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/selector/language_selector.dart';

class TextToAudioScreen extends StatefulWidget {
  const TextToAudioScreen({super.key});

  @override
  State<TextToAudioScreen> createState() => _TextToAudioScreenState();
}

class _TextToAudioScreenState extends State<TextToAudioScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  double _speechValue = 50;
  double _pitchValue = 50;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double paddingBottom = MediaQuery.of(context).padding.bottom == 0 ? 20 : MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const double estimatedContentHeight = 600;
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: constraints.maxHeight > estimatedContentHeight
                          ? constraints.maxHeight
                          : estimatedContentHeight,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            top: 60,
                            left: 24,
                            right: 24,
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: _textEditingController,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    maxLength: 1000,
                                    buildCounter: (context, {required currentLength, required isFocused, required maxLength}) =>
                                        SizedBox.shrink(),
                                    maxLines: 8,
                                    style: TextStyle(
                                      color: ResColors.textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    cursorHeight: 14,
                                    cursorColor: ResColors.textColor,
                                    decoration: InputDecoration(
                                      hintText: context.locale.place_holder_text_to_audio,
                                      hintStyle: TextStyle(
                                        color: ResColors.colorGray,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(18),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: ResColors.colorGray.withValues(alpha: 0.1),
                                  ),
                                  ResSpacing.h10,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${_textEditingController.text.length}/1000",
                                          style: TextStyle(
                                            color: ResColors.colorGray,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // Audio text has been imported
                                          },
                                          child: SvgPicture.asset(
                                            ResIcon.icVolume,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ResSpacing.h14,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 320,
                            left: 0,
                            right: 24,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                context.locale.setting,
                                style: TextStyle(
                                  color: ResColors.textColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 355,
                            left: 24,
                            right: 24,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15).copyWith(topLeft: Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Theme(
                                data: ThemeData(
                                  sliderTheme: SliderThemeData(
                                    trackHeight: 4.0,
                                    activeTrackColor: ResColors.colorPurple,
                                    inactiveTrackColor: ResColors.colorGray.withValues(alpha: 0.2),
                                    thumbColor: ResColors.colorPurple,
                                    overlayColor: ResColors.colorPurple.withValues(alpha: 0.2),
                                    thumbShape: AppSliderShape(thumbRadius: 10),
                                    overlayShape: AppSliderOverlayShape(overlayRadius: 20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.locale.manage_speech,
                                      style: TextStyle(
                                        color: ResColors.textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "0",
                                          style: TextStyle(
                                            color: ResColors.colorGray,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Expanded(
                                          child: Slider(
                                            value: _speechValue,
                                            min: 0,
                                            max: 100,
                                            divisions: 100,
                                            label: _speechValue.round().toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                _speechValue = value;
                                              });
                                            },
                                            activeColor: ResColors.colorPurple,
                                            inactiveColor: ResColors.colorGray.withValues(alpha: 0.2),
                                          ),
                                        ),
                                        Text(
                                          "100",
                                          style: TextStyle(
                                            color: ResColors.colorGray,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ResSpacing.h20,
                                    Text(
                                      context.locale.pitch_rate,
                                      style: TextStyle(
                                        color: ResColors.textColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "0",
                                          style: TextStyle(
                                            color: ResColors.colorGray,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Expanded(
                                          child: Slider(
                                            value: _pitchValue,
                                            min: 0,
                                            max: 100,
                                            divisions: 100,
                                            label: _pitchValue.round().toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                _pitchValue = value;
                                              });
                                            },
                                            activeColor: ResColors.colorPurple,
                                            inactiveColor: ResColors.colorGray.withValues(alpha: 0.2),
                                          ),
                                        ),
                                        Text(
                                          "100",
                                          style: TextStyle(
                                            color: ResColors.colorGray,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: LanguageSelector(
                              onLanguageChanged: (language) {
                                print('Selected language: $language');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            GradientButton(
              height: kBottomNavigationBarHeight / 1.2,
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20).copyWith(bottom: paddingBottom),
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
          ],
        ),
      ),
    );
  }
}

class AppSliderShape extends SliderComponentShape {
  final double thumbRadius;

  const AppSliderShape({required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = ResColors.colorPurple;

    const cornerRadius = 4.55;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 14, height: 14),
        Radius.circular(cornerRadius),
      ),
      paint,
    );
  }
}

class AppSliderOverlayShape extends SliderComponentShape {
  final double overlayRadius;

  const AppSliderOverlayShape({required this.overlayRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(overlayRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = (sliderTheme.overlayColor ?? Colors.transparent).withValues(alpha: activationAnimation.value * 0.4);

    const cornerRadius = 8.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: overlayRadius * 1.2, height: overlayRadius * 1.2),
        Radius.circular(cornerRadius),
      ),
      paint,
    );
  }
}