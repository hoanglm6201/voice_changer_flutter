import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/text_to_audio/text_to_audio_screen.dart';
import 'package:voice_changer_flutter/view/widgets/button/gradient_button.dart';
import 'package:voice_changer_flutter/view_model/prank_sound_provider.dart';

class LoopTimerCard extends StatefulWidget {
  @override
  _LoopTimerCardState createState() => _LoopTimerCardState();
}

class _LoopTimerCardState extends State<LoopTimerCard> {
  bool isLoop = true;
  String timerValue = 'Off';

  @override
  Widget build(BuildContext context) {
    final timerOptions = [
      context.locale.off,
      '5s',
      '30s',
      '1m',
      '5m',
      '1m',
    ];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8).copyWith(right: 14,left: 20),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Loop', style: TextStyle(fontSize: 13)),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch.adaptive(
                      value: isLoop,
                      onChanged: (val) => setState(() => isLoop = val),
                      activeColor: ResColors.colorPurple,
                      thumbColor: WidgetStateProperty.all(isLoop ? ResColors.colorPurple : Color(0xffB6BDC5)),
                      activeTrackColor: ResColors.colorPurple.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),

              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1.0,
                  child: child,
                ),
                child: isLoop
                  ? Column(
                    children: [
                      Divider(height:1),
                      SizedBox(height: 14),
                      Row(
                        key: ValueKey('timerRow'),
                        children: [
                          Text('Timer:', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ResColors.colorPurple.withValues(alpha: 0.2)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: DropdownButton2<String>(
                              value: timerValue,
                              underline: SizedBox(),
                              items: timerOptions.map((e) {
                                final isSelected = e == timerValue;
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: !isSelected ? Colors.black : ResColors.colorPurple,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => timerValue = val);
                                context.read<PrankSoundProvider>().setTimerLabel(timerValue, context);
                              },
                              buttonStyleData: ButtonStyleData(
                                padding: const EdgeInsets.only(left: 24, right: 0),
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: ResColors.colorPurple.withValues(alpha: 0.3)),
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(Icons.arrow_right, color: ResColors.colorPurple),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                offset: const Offset(3, 0),
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  )
                    : SizedBox.shrink(
                      key: ValueKey('empty'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8).copyWith(right: 14, left: 20),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(context.locale.volume, style: TextStyle(fontSize: 13)),
              Expanded(
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
                      Consumer<PrankSoundProvider>(
                        builder: (context, provider, _) {
                          return Slider(
                            value: provider.volume,
                            min: 0,
                            max: 1,
                            divisions: 100,
                            label: (provider.volume * 100).round().toString(),
                            activeColor: ResColors.colorPurple,
                            inactiveColor: ResColors.colorGray.withAlpha(50),
                            onChanged: (value) {
                              provider.setVolume(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}