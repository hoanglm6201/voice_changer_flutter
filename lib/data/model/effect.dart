enum EffectType{
  voiceEffect, ambientSound,none
}

class Effect {
  final String name;
  final double pitch;
  final double speed;
  final double? amplify;
  final List<double>? newEcho;
  final ReverbType? newReverb;
  final FilterType? filter;
  final List<double>? eq1;
  final List<double>? eq2;
  final List<double>? eq3;
  final List<double>? distort;
  final DistortType? distortType;
  final EffectType type;
  final String? icon;

  Effect({
    required this.name,
    required this.pitch,
    required this.speed,
    this.amplify,
    this.newEcho,
    this.newReverb,
    this.filter,
    this.eq1,
    this.eq2,
    this.eq3,
    this.distort,
    this.distortType,
    this.type = EffectType.none,
    this.icon,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Effect) return false;
    return name == other.name &&
        pitch == other.pitch &&
        speed == other.speed &&
        amplify == other.amplify &&
        _listEquals(newEcho, other.newEcho) &&
        newReverb == other.newReverb &&
        filter == other.filter &&
        _listEquals(eq1, other.eq1) &&
        _listEquals(eq2, other.eq2) &&
        _listEquals(eq3, other.eq3) &&
        _listEquals(distort, other.distort) &&
        distortType == other.distortType &&
        type == other.type;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      pitch.hashCode ^
      speed.hashCode ^
      amplify.hashCode ^
      (newEcho == null ? 0 : newEcho.hashCode) ^
      newReverb.hashCode ^
      filter.hashCode ^
      (eq1 == null ? 0 : eq1.hashCode) ^
      (eq2 == null ? 0 : eq2.hashCode) ^
      (eq3 == null ? 0 : eq3.hashCode) ^
      (distort == null ? 0 : distort.hashCode) ^
      distortType.hashCode ^
      type.hashCode;

  bool _listEquals(List<double>? a, List<double>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

}

enum ReverbType {
  mediumChamber,
  mediumRoom,
  mediumHall2,
  cathedral,
  largeRoom2,
  largeRoom,
  smallRoom,
  plate,
  largeHall2,
}

enum FilterType {
  highPass,
  lowPass,
  bandPass,
  lowShelf,
  resonantLowShelf,
  resonantHighPass,
  resonantHighShelf,
}

enum DistortType {
  speechRadioTower,
  drumsBitBrush,
  multiDistortedCubed,
  multiCellphoneConcert,
  drumsLoFi,
  multiEverythingIsBroken,
  multiDecimated4,
  speechCosmicInterference,
  multiDecimated2,
  drumsBufferBeats,
  multiDistortedFunk,
  multiDistortedSquared,
  speechGoldenPi,
}