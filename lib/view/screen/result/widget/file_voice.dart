import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';

class FileVoice extends StatefulWidget {
  const FileVoice({super.key});

  @override
  State<FileVoice> createState() => FileVoiceState();
}

class FileVoiceState extends State<FileVoice> {
  final player = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isSliderDragging = false;

  @override
  void initState() {
    super.initState();
    _loadAudio();
  }

  void pauseAudio() async {
    await player.pause();
  }

  Future<void> _loadAudio() async {
    try {
      await player.setSource(AssetSource("audio_test.mp3"));

      // Lắng nghe thay đổi vị trí audio
      player.onPositionChanged.listen((duration) {
        if (!_isSliderDragging && mounted) {
          setState(() {
            _currentPosition = duration;
          });
        }
      });

      // Lắng nghe thay đổi trạng thái player
      player.onPlayerStateChanged.listen((state) {
        if(mounted){
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
        }
      });

      // Lắng nghe thời lượng total của audio
      player.onDurationChanged.listen((duration) {
        if(mounted) {
          setState(() {
            _totalDuration = duration;
          });
        }
      });

      // Lắng nghe khi audio kết thúc
      player.onPlayerComplete.listen((event) {
        if(mounted) {
          setState(() {
            _isPlaying = false;
            _currentPosition = Duration.zero;
          });
        }
      });

    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  // Hàm format thời gian từ Duration sang mm:ss
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  // Hàm play/pause audio
  void _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await player.pause();
      } else {
        await player.resume();
      }
    } catch (e) {
      print("Error toggling play/pause: $e");
    }
  }

  // Hàm seek audio đến vị trí cụ thể
  void _seekToPosition(double value) async {
    final position = Duration(milliseconds: value.toInt());
    await player.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 58;
    return Column(
      children: [
        Spacer(),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 4),
          child: Image.asset(ResImages.vinyl),
        ),
        Spacer(),
        Spacer(),
        Text(
          "Girl_Voice_1747626572092",
          style: TextStyle(
            color: ResColors.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        ResSpacing.h24,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Current duration
              Text(
                _formatDuration(_currentPosition),
                style: TextStyle(
                  color: ResColors.textColor,
                  fontSize: 12,
                ),
              ),
              // Total duration
              Text(
                _formatDuration(_totalDuration),
                style: TextStyle(
                  color: ResColors.textColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        ResSpacing.h6,

        // Audio Progress Slider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.0,
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: ResColors.textColor,
              inactiveTrackColor: Color.fromRGBO(182, 189, 197, 0.3),
            ),
            child: Slider(
              value: _totalDuration.inMilliseconds > 0
                  ? _currentPosition.inMilliseconds.toDouble()
                  : 0.0,
              max: _totalDuration.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _currentPosition = Duration(milliseconds: value.toInt());
                });
              },
              onChangeStart: (value) {
                _isSliderDragging = true;
              },
              onChangeEnd: (value) {
                _isSliderDragging = false;
                _seekToPosition(value);
              },
            ),
          ),
        ),

        Spacer(),

        // Play/Pause Button
        Center(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: _togglePlayPause,
            child: SizedBox(
              height: 60,
              width: 60,
              child: SvgPicture.asset(
                  _isPlaying ? ResIcon.icPause : ResIcon.icPlayCircle
              ),
            ),
          ),
        ),
        Spacer(),
        Spacer(),
      ],
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}