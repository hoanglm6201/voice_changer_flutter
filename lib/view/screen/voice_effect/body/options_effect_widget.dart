import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/effect_list.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/effect.dart';
import 'package:voice_changer_flutter/view_model/voice_effect_provider.dart';

class OptionsEffectWidget extends StatefulWidget {
  const OptionsEffectWidget({super.key});

  @override
  State<OptionsEffectWidget> createState() => _OptionsEffectWidgetState();
}

class _OptionsEffectWidgetState extends State<OptionsEffectWidget> {
  EffectType? _selectedEffectType = EffectType.voiceEffect;
  List<Effect> _disPlayedEffects = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDisplayedEffects();
    });
  }

  void _getDisplayedEffects() {
    Provider.of<VoiceEffectProvider>(context, listen: false)
        .selectEffect(listEffects(context).first);
    // find all effects that match the selected effect type and effect type none
    final list = listEffects(context)
        .where((effect) =>
            effect.type == _selectedEffectType ||
            effect.type == EffectType.none)
        .toList();

    setState(() {
      _disPlayedEffects = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedEffectType = EffectType.voiceEffect;
                    });
                    _getDisplayedEffects();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: _selectedEffectType == EffectType.voiceEffect
                          ? Border.all(
                              color: ResColors.colorPurple,
                              width: 1.5,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      spacing: 5.5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ResImages.changeVoice),
                        Text(
                          context.locale.change_voice,
                          style: TextStyle(
                            color: ResColors.textColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedEffectType = EffectType.ambientSound;
                      _getDisplayedEffects();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: _selectedEffectType == EffectType.ambientSound
                          ? Border.all(
                              color: ResColors.colorPurple,
                              width: 1.5,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      spacing: 5.5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ResImages.ambientSound),
                        Text(
                          context.locale.ambient_sound,
                          style: TextStyle(
                            color: ResColors.textColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ResSpacing.h12,
          Expanded(
            child: Consumer<VoiceEffectProvider>(
              builder: (context, value, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: _disPlayedEffects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.07,
                  ),
                  itemBuilder: (context, index) {
                    final Effect effect = _disPlayedEffects[index];
                    bool isSelected = value.selectedEffect == effect;
                    bool isNoEffect = effect.type == EffectType.none;
                    return InkWell(
                      onTap: () {
                        value.selectEffect(effect);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: ResColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(child: SizedBox()),
                            Container(
                              margin: EdgeInsets.all(3),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? Colors.white : Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                spacing: 2,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (effect.icon != null)
                                    SvgPicture.asset(
                                      ResIcon.icSoundEffect,
                                      colorFilter: ColorFilter.mode(
                                        isSelected ? ResColors.colorPurple : Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  Text(
                                    effect.name,
                                    style: TextStyle(
                                      color: isSelected ? ResColors.colorPurple : Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
