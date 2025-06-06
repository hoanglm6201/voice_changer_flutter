import 'package:voice_changer_flutter/core/res/images.dart';

class PrankSound {
  final int id;
  final String name;
  final String fileUrl;
  final String image;

  PrankSound({
    required this.id,
    required this.name,
    required this.fileUrl,
    required this.image,
  });

  factory PrankSound.fromJson(Map<String, dynamic> json) {
    return PrankSound(
      id: json['id'],
      name: json['name'],
      fileUrl: json['fileUrl'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fileUrl': fileUrl,
      'image': image,
    };
  }
}
class PrankSoundCategory {
  final int id;
  final String title;
  final String thumbnail;
  final List<PrankSound> sounds;

  PrankSoundCategory({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.sounds,
  });

  factory PrankSoundCategory.fromJson(Map<String, dynamic> json) {
    return PrankSoundCategory(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      sounds: (json['sounds'] as List<dynamic>)
          .map((e) => PrankSound.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'sounds': sounds.map((e) => e.toJson()).toList(),
    };
  }
}

final List<PrankSoundCategory> mockPrankSoundCategories = [
  PrankSoundCategory(
    id: 1,
    title: 'Animal Sounds',
    thumbnail: ResImages.daffiDuck,
    sounds: [
      PrankSound(
        id: 101,
        name: 'Dog Bark',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.daffiDuck,
      ),
      PrankSound(
        id: 102,
        name: 'Cat Meow',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.daffiDuck,
      ),
    ],
  ),
  PrankSoundCategory(
    id: 2,
    title: 'Fart Sounds',
    thumbnail: ResImages.daffiDuck,
    sounds: [
      PrankSound(
        id: 201,
        name: 'Fart Classic',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.daffiDuck,
      ),
      PrankSound(
        id: 202,
        name: 'Wet Fart',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.daffiDuck,
      ),
    ],
  ),
  PrankSoundCategory(
    id: 3,
    title: 'Scary Sounds',
    thumbnail: ResImages.daffiDuck,
    sounds: [
      PrankSound(
        id: 301,
        name: 'Scream',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.daffiDuck,
      ),
      PrankSound(
        id: 302,
        name: 'Ghost Whisper',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.hamerSimpson,
      ),
      PrankSound(
        id: 303,
        name: 'Ghost Whisper',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.keanuReeves,
      ),
      PrankSound(
        id: 304,
        name: 'Ghost Whisper',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.elza,
      ),
      PrankSound(
        id: 305,
        name: 'Ghost Whisper',
        fileUrl: 'assets/audio_test.mp3',
        image: ResImages.arianaGrande,
      ),
    ],
  ),
];
