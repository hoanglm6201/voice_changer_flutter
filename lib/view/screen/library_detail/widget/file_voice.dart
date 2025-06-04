import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';

class FileVoice extends StatefulWidget {
  const FileVoice({super.key});

  @override
  State<FileVoice> createState() => _FileVoiceState();
}

class _FileVoiceState extends State<FileVoice> {
  double _currentTime = 0.0;
  double _totalTime = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _totalTime = 63;
    });
  }

  //hàm cần trả về thời gian dạng 00:00
  String _formatDuration(double seconds) {
    final int minutes = (seconds / 60).floor();
    final int secs = (seconds % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
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
              //current duration
              Text(_formatDuration(_currentTime)),
              // total duration
              Text(_formatDuration(_totalTime)),
            ],
          ),
        ),
        ResSpacing.h6,
        Slider(
          value: _currentTime,
          min: 0,
          max: _totalTime,
          onChanged: (value) {
            setState(() {
              _currentTime = value;
            });
          },
          activeColor: ResColors.textColor,
          inactiveColor: Color.fromRGBO(182, 189, 197, 1),
        ),
        Spacer(),
        Center(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            child: SvgPicture.asset(_isPlaying ? ResIcon.icPlayCircle : ResIcon.icPause),
          ),
        ),
        Spacer(),
        Spacer(),
      ],
    );
  }
}
