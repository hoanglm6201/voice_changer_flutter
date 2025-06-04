import 'package:flutter/material.dart';
import 'package:record/record.dart';

class AudioRecorderProvider extends ChangeNotifier {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  bool _isPaused = false;
  String? _recordedFilePath;

  bool get isRecording => _isRecording;
  bool get isPaused => _isPaused;
  String? get recordedFilePath => _recordedFilePath;

  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      _recordedFilePath = null;
      await _recorder.start(
        const RecordConfig(),
        path: '',
      );
      _isRecording = true;
      _isPaused = false;
      notifyListeners();
    } else {
      print("❌ No microphone permission");
    }
  }

  Future<void> pauseRecording() async {
    if (_isRecording && !_isPaused) {
      await _recorder.pause();
      _isPaused = true;
      notifyListeners();
    }
  }

  Future<void> resumeRecording() async {
    if (_isRecording && _isPaused) {
      await _recorder.resume();
      _isPaused = false;
      notifyListeners();
    }
  }

  Future<void> stopRecording() async {
    if (_isRecording) {
      _recordedFilePath = await _recorder.stop();
      _isRecording = false;
      _isPaused = false;
      notifyListeners();
      print("✅ Recording saved: $_recordedFilePath");
    }
  }

  Future<void> cancelRecording() async {
    if (_isRecording) {
      await _recorder.stop();
      _isRecording = false;
      _isPaused = false;
      _recordedFilePath = null;
      notifyListeners();
    }
  }
}
