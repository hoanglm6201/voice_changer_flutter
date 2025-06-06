import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';

class PrankSoundProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _countdown = 0;
  int get countdown => _countdown;

  Timer? _countdownTimer;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  double _volume = 1;
  double get volume => _volume;

  String _timerLabel = 'Off';
  String get timerLabel => _timerLabel;

  Duration _selectedDuration = Duration.zero;

  // ========== Audio ==========
  Future<void> play(String path, {bool isAsset = false}) async {
    try {
      await _audioPlayer.setVolume(_volume);
      if (isAsset) {
        await _audioPlayer.play(AssetSource(path));
      } else {
        await _audioPlayer.play(UrlSource(path));
      }
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Play error: $e');
    }
  }


  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Pause error: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    await _audioPlayer.setVolume(_volume);
    notifyListeners();
  }

  // ========== Timer Logic ==========

  void setTimerLabel(String label, BuildContext context) {
    _timerLabel = label;
    _selectedDuration = _getDurationFromLabel(label, context );
    print(_selectedDuration);
    notifyListeners();
  }

  void startCountdown() {
    print('start');
    if (_selectedDuration == Duration.zero) return;

    _countdown = _selectedDuration.inSeconds;
    _countdownTimer?.cancel();

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
        notifyListeners();
      } else {
        timer.cancel();
        debugPrint('Countdown finished');
        play('audio_test.mp3', isAsset: true);
      }
    });
  }

  String get formattedCountdown {
    final minutes = _countdown ~/ 60;
    final seconds = _countdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Duration _getDurationFromLabel(String label, BuildContext context) {
    switch (label) {
      case '5s':
        return Duration(seconds: 5);
      case '10s':
        return Duration(seconds: 10);
      case '30s':
        return Duration(seconds: 30);
      case '1m':
        return Duration(minutes: 1);
      case '5m':
        return Duration(minutes: 5);
      case 'Off':
      case 'off':
      case 'OFF':
      case '0':
      case 'off_label': // nếu cần
        return Duration.zero;
      default:
        if (label == context.locale.off) return Duration.zero; // Xử lý label quốc tế
        return Duration.zero;
    }
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }
}
