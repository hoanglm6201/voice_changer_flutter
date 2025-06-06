import 'package:flutter/cupertino.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/effect.dart';

List<Effect> listEffects(BuildContext context) {
  return [
    Effect(
      name: context.locale.no_effect,
      pitch: 0,
      speed: 1,
      icon: ResIcon.icSoundEffect,
      type: EffectType.none,
    ),
    /// Type: Voice Effect
    Effect(
      name: context.locale.man,
      pitch: -400,
      speed: 1.01,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.woman,
      pitch: 1.29,
      speed: 0.5,
      newEcho: [0.2, 0.2, 0.2],
      newReverb: ReverbType.plate,
      distortType: DistortType.multiDistortedSquared,
      filter: FilterType.bandPass,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.baby,
      pitch: 300,
      speed: 1.1,
      newReverb: ReverbType.smallRoom,
      filter: FilterType.highPass,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.old_man,
      pitch: 1.29,
      speed: 0.5,
      newEcho: [0.2, 0.2, 0.2],
      newReverb: ReverbType.plate,
      distortType: DistortType.multiDistortedFunk,
      filter: FilterType.bandPass,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.monster,
      pitch: -400,
      speed: 0.85,
      amplify: 2.0,
      newReverb: ReverbType.mediumRoom,
      filter: FilterType.lowPass,
      eq1: [100, 10, 10],
      distortType: DistortType.multiDecimated4,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.robot,
      pitch: -500,
      speed: 1.2,
      amplify: 5.0,
      newEcho: [0.2, 0.5, 0.7],
      newReverb: ReverbType.largeHall2,
      filter: FilterType.bandPass,
      eq1: [200.0, 1.5, 3.0],
      eq2: [500.0, 1.0, -2.0],
      eq3: [1000.0, 2.0, 5.0],
      distort: [0.8, 0.5, 0.3],
      distortType: DistortType.speechRadioTower,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.ghost,
      pitch: -300,
      speed: 0.9,
      newEcho: [0.3, 0.6, 0.7],
      newReverb: ReverbType.largeHall2,
      filter: FilterType.lowPass,
      distort: [0.1, 0.3, 0.5],
      distortType: DistortType.multiDistortedFunk,
      type: EffectType.voiceEffect,
    ),

    Effect(
      name: context.locale.alien,
      pitch: 160,
      speed: 0.9,
      newEcho: [0.18, 0.75, 0.75],
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.auto_tune,
      pitch: 0, // Neutral pitch for auto-tune
      speed: 1.0,
      distort: [0.5, 0.3, 0.2],
      distortType: DistortType.speechGoldenPi, // Mimics a synthetic, tuned effect
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.chipmunk,
      pitch: 500, // Very high pitch for chipmunk effect
      speed: 1.5, // Faster speed
      filter: FilterType.highPass,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.deep_voice,
      pitch: -600, // Very low pitch for a deep voice
      speed: 0.7, // Slower speed for a resonant tone
      newReverb: ReverbType.mediumHall2,
      filter: FilterType.lowPass,
      type: EffectType.voiceEffect,
    ),
    Effect(
      name: context.locale.villain,
      pitch: -200,
      speed: 0.85,
      amplify: 3,
      filter: FilterType.highPass,
      type: EffectType.voiceEffect,
    ),

    /// Type: Ambient Sound
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.rain,
      pitch: 0,
      speed: 1.0,
      newEcho: [0.2, 0.3, 0.4],
      newReverb: ReverbType.mediumRoom, // Light reverb for rain
      filter: FilterType.lowPass,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.thunderstorm,
      pitch: 0,
      speed: 1.0,
      newEcho: [0.4, 0.6, 0.8],
      newReverb: ReverbType.largeHall2, // Strong reverb for thunder
      filter: FilterType.lowPass,
      distort: [0.3, 0.2, 0.1],
      distortType: DistortType.multiDistortedFunk,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.forest,
      pitch: 0,
      speed: 1.0,
      newEcho: [0.1, 0.2, 0.3],
      newReverb: ReverbType.mediumHall2, // Open space for forest
      filter: FilterType.highPass,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.campfire,
      pitch: 0,
      speed: 1.0,
      newReverb: ReverbType.smallRoom, // Small space for campfire
      filter: FilterType.lowPass,
      distort: [0.2, 0.1, 0.1],
      distortType: DistortType.drumsBitBrush,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.city_traffic,
      pitch: 0,
      speed: 1.0,
      newReverb: ReverbType.mediumRoom,
      filter: FilterType.bandPass,
      distort: [0.3, 0.2, 0.2],
      distortType: DistortType.multiCellphoneConcert,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.ocean_waves,
      pitch: 0,
      speed: 1.0,
      newEcho: [0.3, 0.5, 0.6],
      newReverb: ReverbType.largeRoom, // Large space for waves
      filter: FilterType.lowPass,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.night_crickets,
      pitch: 0,
      speed: 1.0,
      newReverb: ReverbType.mediumHall2,
      filter: FilterType.highPass, // High frequencies for crickets
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.haunted_house,
      pitch: 0,
      speed: 1.0,
      newEcho: [0.4, 0.7, 0.8],
      newReverb: ReverbType.cathedral, // Spooky, large space
      filter: FilterType.lowPass,
      distort: [0.2, 0.3, 0.4],
      distortType: DistortType.multiEverythingIsBroken,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.battlefield,
      pitch: 0,
      speed: 1.0,
      newEcho: [0.3, 0.5, 0.6],
      newReverb: ReverbType.largeRoom,
      filter: FilterType.lowPass,
      distort: [0.5, 0.4, 0.3],
      distortType: DistortType.drumsBufferBeats,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.cave_echo,
      pitch: -300,
      speed: 0.9,
      amplify: 3.0,
      newEcho: [0.3, 0.6, 0.5],
      newReverb: ReverbType.cathedral,
      filter: FilterType.bandPass,
      eq1: [150.0, 1.2, 2.5],
      eq2: [400.0, 1.5, 1.0],
      eq3: [1200.0, 2.0, -2.0],
      distort: [0.2, 0.3, 0.4],
      distortType: DistortType.speechCosmicInterference,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.windy_desert,
      pitch: 0,
      speed: 1.0,
      newReverb: ReverbType.largeRoom2,
      filter: FilterType.highPass, // Wind sounds are higher-pitched
      distort: [0.2, 0.1, 0.1],
      distortType: DistortType.speechCosmicInterference,
    ),
    Effect(
      type: EffectType.ambientSound,
      name: context.locale.space_ambience,
      pitch: 0,
      speed: 1.0,
      newEcho: [0.5, 0.8, 0.9],
      newReverb: ReverbType.cathedral, // Vast space for cosmic sound
      filter: FilterType.lowPass,
      distort: [0.1, 0.2, 0.3],
      distortType: DistortType.speechCosmicInterference,
    ),
  ];
}
