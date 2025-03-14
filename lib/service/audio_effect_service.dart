import 'package:flutter/services.dart';

class AudioEffectService {
  static const MethodChannel _channel = MethodChannel('audio_effects');

  static Future<void> playAudioWithEffect(Map<String, dynamic> effect) async {
    try {
      await _channel.invokeMethod('playAudioWithEffect', effect);
    } catch (e) {
      print("Error calling native method: $e");
    }
  }

  static Future<void> stopAudio() async {
    try {
      await _channel.invokeMethod('stopAudio');
    } catch (e) {
      print("Error stopping audio: $e");
    }
  }
}
