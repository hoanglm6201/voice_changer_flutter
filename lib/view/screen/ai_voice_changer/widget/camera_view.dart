import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/view_model/camera_provider.dart';
import 'package:voice_changer_flutter/view_model/camera_recording_provider.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final recordingProvider = context.watch<CameraProvider>();
    final controller = recordingProvider.controller;

    if (controller == null || !controller.value.isInitialized) {
      context.read<CameraProvider>().initializeCamera();
      return Container(color: Colors.black);
    }
    context.read<CameraRecordingProvider>().setCameraController(controller);

    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: controller.value.previewSize!.height,
        height: controller.value.previewSize!.width,
        child: CameraPreview(controller),
      ),
    );
  }
}

