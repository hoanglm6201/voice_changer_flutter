import 'package:voice_changer_flutter/data/model/effect.dart';

extension ReverbTypeExtension on ReverbType {
  String get stringValue {
    switch (this) {
      case ReverbType.mediumChamber:
        return 'Medium Chamber';
      case ReverbType.mediumRoom:
        return 'Medium Room';
      case ReverbType.mediumHall2:
        return 'Medium Hall 2';
      case ReverbType.cathedral:
        return 'Cathedral';
      case ReverbType.largeRoom2:
        return 'Large Room 2';
      case ReverbType.largeRoom:
        return 'Large Room';
      case ReverbType.smallRoom:
        return 'Small Room';
      case ReverbType.plate:
        return 'Plate';
      case ReverbType.largeHall2:
        return 'Large Hall 2';
      default:
        return 'Unknown Reverb';
    }
  }
}

extension FilterTypeExtension on FilterType {
  String get stringValue {
    switch (this) {
      case FilterType.highPass:
        return 'High Pass';
      case FilterType.lowPass:
        return 'Low Pass';
      case FilterType.bandPass:
        return 'Band Pass';
      case FilterType.lowShelf:
        return 'Low Shelf';
      case FilterType.resonantLowShelf:
        return 'Resonant Low Shelf';
      case FilterType.resonantHighPass:
        return 'Resonant High Pass';
      case FilterType.resonantHighShelf:
        return 'Resonant High Shelf';
      default:
        return 'Unknown Filter';
    }
  }
}

extension DistortTypeExtension on DistortType {
  String get stringValue {
    switch (this) {
      case DistortType.speechRadioTower:
        return 'Speech Radio Tower';
      case DistortType.drumsBitBrush:
        return 'Drums Bit Brush';
      case DistortType.multiDistortedCubed:
        return 'Multi Distorted Cubed';
      case DistortType.multiCellphoneConcert:
        return 'Multi Cellphone Concert';
      case DistortType.drumsLoFi:
        return 'Drums LoFi';
      case DistortType.multiEverythingIsBroken:
        return 'Multi Everything Is Broken';
      case DistortType.multiDecimated4:
        return 'Multi Decimated 4';
      case DistortType.speechCosmicInterference:
        return 'Speech Cosmic Interference';
      case DistortType.multiDecimated2:
        return 'Multi Decimated 2';
      case DistortType.drumsBufferBeats:
        return 'Drums Buffer Beats';
      case DistortType.multiDistortedFunk:
        return 'Multi Distorted Funk';
      case DistortType.multiDistortedSquared:
        return 'Multi Distorted Squared';
      case DistortType.speechGoldenPi:
        return 'Speech Golden Pi';
      default:
        return 'Unknown Distortion';
    }
  }
}