import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraRecordingProvider with ChangeNotifier {
  CameraController? cameraController;
  final List<XFile> _recordedSegments = [];

  List<XFile> get recordedSegments => List.unmodifiable(_recordedSegments);

  bool get isRecording => cameraController?.value.isRecordingVideo ?? false;

  void setCameraController(CameraController controller) {
    cameraController = controller;
  }

  Future<void> startRecording() async {
    if (cameraController == null || cameraController!.value.isRecordingVideo) return;
    await cameraController!.startVideoRecording();
    notifyListeners();
  }

  Future<void> pauseRecording() async {
    if (cameraController == null || !cameraController!.value.isRecordingVideo) return;
    final file = await cameraController!.stopVideoRecording();
    _recordedSegments.add(file);
    notifyListeners();
  }

  Future<void> resumeRecording() async {
    if (cameraController == null || cameraController!.value.isRecordingVideo) return;
    await cameraController!.startVideoRecording();
    notifyListeners();
  }

  Future<void> stopRecording() async {
    if (cameraController == null) return;

    if (cameraController!.value.isRecordingVideo) {
      final file = await cameraController!.stopVideoRecording();
      _recordedSegments.add(file);
    }

    notifyListeners();
  }

  void reset() {
    _recordedSegments.clear();
    notifyListeners();
  }
}
