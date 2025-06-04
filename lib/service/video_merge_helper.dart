import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
}
