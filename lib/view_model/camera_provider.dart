import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? _controller;
  bool _isFrontCamera = true;

  CameraController? get controller => _controller;

  bool get isFrontCamera => _isFrontCamera;

  void setCameraController(CameraController controller) {
    _controller = controller;
    notifyListeners();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final selectedCamera = cameras.firstWhere(
          (cam) => cam.lensDirection == (_isFrontCamera ? CameraLensDirection.front : CameraLensDirection.back),
    );

    _controller?.dispose();
    _controller = CameraController(
      selectedCamera,
      ResolutionPreset.medium,
      enableAudio: true,
    );

    await _controller!.initialize();
    notifyListeners();
  }

  Future<void> switchCamera() async {
    _isFrontCamera = !_isFrontCamera;
    await initializeCamera();
  }

  void reset() {
    _controller?.dispose();
    _controller = null;
    _isFrontCamera = true;
    notifyListeners();
  }

}
