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
  });
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