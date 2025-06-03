import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import 'package:voice_changer_flutter/core/res/images.dart';

class VoiceModel {
  final String id;
  final String name;
  final String image;

  VoiceModel({
    required this.id,
    required this.name,
    required this.image,
  });
}

List<VoiceModel> voiceList = [
  // Cartoon voices
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Daffi Duck',
    image: ResImages.daffiDuck,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Dorth Vader',
    image: ResImages.dorthVader,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Elza',
    image: ResImages.elza,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Hamer Simpson',
    image: ResImages.hamerSimpson,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Haroy Potter',
    image: ResImages.haroyPotter,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Micket Mouse',
    image: ResImages.micketMouse,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Peppa pug',
    image: ResImages.peppaPug,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Scooby Dop',
    image: ResImages.scoobyDop,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Shark',
    image: ResImages.shark,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Ton',
    image: ResImages.ton,
  ),

  // Celebrities and public figures voices
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Ariana Grande',
    image: ResImages.arianaGrande,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Billie Eilish',
    image: ResImages.billieEilish,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'cardi b',
    image: ResImages.cardiB,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Drake',
    image: ResImages.drake,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Keanu Reeves',
    image: ResImages.keanuReeves,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Morgan Freeman',
    image: ResImages.morganFreeman,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'snoop dogg',
    image: ResImages.snoopDogg,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Taylor Swift',
    image: ResImages.taylorSwift,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'The rock',
    image: ResImages.theRock,
  ),

  // Game and pop culture icons voices
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Krotos',
    image: ResImages.krotos,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'lata croft',
    image: ResImages.lataCroft,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Luegi',
    image: ResImages.luegi,
  ),
  VoiceModel(
    id: const Uuid().v4(),
    name: 'Mazio',
    image: ResImages.mazio,
  ),
];
