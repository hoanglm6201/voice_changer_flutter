import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';

class FileVideo extends StatefulWidget {
  final String? videoPath;
  const FileVideo({super.key, this.videoPath});

  @override
  State<FileVideo> createState() => FileVideoState();
}

class FileVideoState extends State<FileVideo> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initializeVideo();
      }
    });
  }
  void pauseVideo() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _initializeVideo() {
    // _controller = VideoPlayerController.asset("assets/video_test.mp4")
    if (widget.videoPath != null && widget.videoPath!.isNotEmpty) {
      _controller = VideoPlayerController.file(
        File(widget.videoPath!),
      );
    } else {
      _controller = VideoPlayerController.asset("assets/video_test.mp4");
    }
    _controller.initialize().then((_) {
        if (mounted) {
          _controller.setLooping(true);
          _controller.addListener(_videoListener);
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              _controller.play();
              setState(() {
                _isPlaying = true;
                _isInitialized = true;
              });
            }
          });
        }
      }).catchError((error) {
        if (mounted) {
          print("Lỗi khởi tạo video: $error");
          setState(() {
            _isInitialized = false;
          });
        }
      });
  }

  void _videoListener() {
    if (mounted) {
      setState(() {
      });
    }
  }

  // Hàm format thời gian từ Duration sang mm:ss
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: _isInitialized
          ? InkWell(
        onTap: () {
          setState(() {
            _isPlaying = !_isPlaying;
          });
          if (_isPlaying) {
            _controller.play();
          } else {
            _controller.pause();
          }
        },
        child: SizedBox.expand(
          child: Stack(
            fit: StackFit.expand,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),

              if(!_isPlaying) Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  ResIcon.icPlayCircle,
                  colorFilter:
                  ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //current duration
                          Text(
                            _formatDuration(_controller.value.position),
                            style: TextStyle(color: Colors.white),
                          ),
                          // total duration
                          Text(
                            _formatDuration(_controller.value.duration),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        height: 4,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: VideoProgressIndicator(
                          _controller,
                          padding: EdgeInsets.zero,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: Colors.white,
                            bufferedColor:Color.fromRGBO(182, 189, 197, 0.3),
                            backgroundColor: Color.fromRGBO(182, 189, 197, 0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : Container(
        color: Colors.black,
        child: Center(
          child: CupertinoActivityIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }
}