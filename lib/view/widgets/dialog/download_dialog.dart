import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/service/video_merge_helper.dart';
import 'package:voice_changer_flutter/view/widgets/progress_bar/gradient_progress_bar.dart';

class DownloadDialog extends StatefulWidget {
  final Function(bool isDownloadSuccess) onDownloadSuccess;
  final String? path;
  final bool isVideo;
  const DownloadDialog({super.key, required this.onDownloadSuccess, required this.path, required this.isVideo});

  @override
  State<DownloadDialog> createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _startSaving();
  }

  void _startSaving() async {
    await Future.delayed(Duration(milliseconds: 300)); // Cho phép dialog hiện lên
    await VideoMergerHelper.saveToGallery(widget.path ?? '', widget.isVideo);

    // Đợi 1 chút để hoàn thiện animation
    await Future.delayed(Duration(milliseconds: 500));

    widget.onDownloadSuccess(true);
    if (mounted) Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 8, bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Lottie.asset('assets/anim/anim_download.json', height: MediaQuery.sizeOf(context).width * 0.26),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 5),
              builder: (context, value, child) {
                return GradientProgressBar(
                  percent: (value * 100).toInt(),
                  gradient: ResColors.primaryGradient,
                  backgroundColor: ResColors.colorGray.withValues(alpha: 0.15),
                );
              },
              onEnd: () {
                widget.onDownloadSuccess(true);
                Navigator.pop(context);
              },
            ),
          ),
          Text(context.locale.downloading)
        ],
      ),
    );
  }
}
