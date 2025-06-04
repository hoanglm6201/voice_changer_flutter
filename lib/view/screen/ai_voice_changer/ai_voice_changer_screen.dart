import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/enum/record_mode.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/widget/camera_view.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/widget/recording_widget.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class AiVoiceChangerScreen extends StatefulWidget {
  final String voiceSelectedImage;
  const AiVoiceChangerScreen({super.key, required this.voiceSelectedImage});

  @override
  State<AiVoiceChangerScreen> createState() => _AiVoiceChangerScreenState();
}

class _AiVoiceChangerScreenState extends State<AiVoiceChangerScreen> {
  bool isRecording = false;
  bool isPausing = false;
  int _timer = 0;
  RecordMode recordMode = RecordMode.video;



  void setRecordingState(){
    setState(() {
      isRecording = !isRecording;
      _timer = 0;
    });
    if(isPausing){
      setPausingState();
    }
  }
  void setPausingState(){
    setState(() {
      isPausing = !isPausing;
    });
  }
  void setRecordMode() {
    setState(() {
      recordMode = (recordMode == RecordMode.video)
          ? RecordMode.audio
          : RecordMode.video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: isRecording ? _buildTimeUI(_timer) : Text(context.locale.ai_voice_changer, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        leading: IconButtonCustom(
          icon: SvgPicture.asset(ResIcon.icBack),
          onPressed: () {Navigator.pop(context);},
          style: const IconButtonCustomStyle(
            backgroundColor: Colors.white,
            borderRadius: 15,
            padding: EdgeInsets.all(11.0),
          ),
        ),
        actions: [
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icRotateCamera),
            onPressed: () {},
            style: const IconButtonCustomStyle(
              backgroundColor: Colors.white,
              borderRadius: 15,
              padding: EdgeInsets.all(11.0),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CameraView()
                  )
                ),
                SizedBox(height: 10),
                _buildBottomButtons(context),

              ],
            ),
            if(isPausing)
              Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(3)
                ),
                child: Text(context.locale.currently_paused, style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context){
    bool isAudioRecord = recordMode == RecordMode.audio;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// BUTTON AUDIO RECORD / PAUSE, RESUME
        SizedBox(
          width: 90,
          child: isRecording ?
            GestureDetector(
              onTap: () {
                setPausingState();
              },
              child: isPausing ? Image.asset(ResImages.iconResume) : SvgPicture.asset(ResIcon.icPause))
            :
          /// CHUYỂN QUA AUDIO RECORD MODE
            GestureDetector(
              onTap: () {
                setRecordMode();
              },
              child: Column(
              spacing: 4,
              children: [
                IconButtonCustom(
                  icon: SvgPicture.asset(isAudioRecord ? ResIcon.icRecordsMic : ResIcon.icRecordsVideo, height: 30,),
                  style: const IconButtonCustomStyle(
                    backgroundColor: Colors.white,
                    borderRadius: 15,
                    padding: EdgeInsets.all(11.0),
                  ),
                ),
                Text(context.locale.audio_record,maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12),)
                ],
              ),
            ),
          ),
        /// BUTTON RECORD
        GestureDetector(
          onTap: () {
            setRecordingState();
          },
          child: SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.24,
            width: MediaQuery.sizeOf(context).width * 0.24,
            child: isRecording ? RecordButtonWithTimer(
              isPausing: isPausing,
              isRecording: isRecording,
              onEndTime: (endTime) {

              },
              onChangeTimer: (int timer) {
                setState(() {
                  _timer = timer;
                });
                print(_timer);
              },
            ) : Image.asset(isAudioRecord ? ResImages.iconRecordAudio: ResImages.iconRecordVideo, fit: BoxFit.cover,)
          )
        ),
        /// BUTTON IMAGE VOICE LIST
        isRecording ? SizedBox(width: 90) : SizedBox(
          width: 90,
          child: Column(
            spacing: 4,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Image.asset(widget.voiceSelectedImage, height: 50,)),
              Text(context.locale.voice_list, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12),)
            ],
          ),
        )
      ],
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  Widget _buildTimeUI(int time){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: isPausing ? Colors.transparent: Colors.red,
        border: Border.all(
          color: Colors.red
        )
      ),
      child: Text(
        formatTime(time),
        style: TextStyle(
          color: isPausing ? Colors.black: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
