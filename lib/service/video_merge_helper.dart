import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoMergerHelper {
  static const _channel = MethodChannel('video_merger');

  static Future<String?> mergeVideos(List<String> paths) async {
    final dir = await getTemporaryDirectory();
    final outputPath = '${dir.path}/merged_video_${DateTime.now().millisecondsSinceEpoch}.mp4';

    try {
      final result = await _channel.invokeMethod<String>('mergeVideos', {
        'paths': paths,
        'outputPath': outputPath,
      });

      return result; // Đường dẫn file video đã merge
    } catch (e) {
      print("Video merge failed: $e");
      return null;
    }
  }

  static Future<void> saveToGallery(String filePath, bool isVideo) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      print("❌ Permission denied");
      return;
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      print("❌ File không tồn tại");
      return;
    }

    final bytes = await file.readAsBytes();
    final name = filePath.split("/").last;

    final result = await ImageGallerySaver.saveFile(
      filePath,
      name: name,
      isReturnPathOfIOS: true,
    );

    print("✅ Save result: $result");
  }
}
