import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/core/enum/record_mode.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';
import 'package:voice_changer_flutter/service/video_merge_helper.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/widget/camera_view.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_changer/widget/recording_widget.dart';
import 'package:voice_changer_flutter/view/screen/ai_voice_preview/ai_voice_preview_screen.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/dialog/confirm_dialog.dart';
import 'package:voice_changer_flutter/view_model/audio_record_provider.dart';
import 'package:voice_changer_flutter/view_model/camera_provider.dart';

import '../../../view_model/camera_recording_provider.dart';

class AiVoiceChangerScreen extends StatefulWidget {
  final VoiceModel voiceModel;
  const AiVoiceChangerScreen({super.key, required this.voiceModel});

  @override
  State<AiVoiceChangerScreen> createState() => _AiVoiceChangerScreenState();
}

class _AiVoiceChangerScreenState extends State<AiVoiceChangerScreen> {
  bool isRecording = false;
  bool isPausing = false;
  int _timer = 0;
  RecordMode recordMode = RecordMode.video;


  void setRecordingState(){
    bool isAudioRecord = recordMode == RecordMode.audio;
    final recordingProvider = context.read<CameraRecordingProvider>();
    if(_timer <=2 && isRecording){
      _showSnackBar();
      return;
    }
    setState(() {
      isRecording = !isRecording;
      _timer = 0;
    });
    if (isRecording) {
      if (isAudioRecord) {
        context.read<AudioRecorderProvider>().startRecording();
      } else {
        recordingProvider.startRecording();
      }
      // recordingProvider.startRecording();
    } else {
      onRecordEnd();
    }
  }
  void setPausingState() {
    if (!isRecording) return;

    final isAudioRecord = recordMode == RecordMode.audio;
    final audioProvider = context.read<AudioRecorderProvider>();
    final videoProvider = context.read<CameraRecordingProvider>();

    if (isPausing) {
      isAudioRecord ? audioProvider.resumeRecording() : videoProvider.resumeRecording();
    } else {
      isAudioRecord ? audioProvider.pauseRecording() : videoProvider.pauseRecording();
    }

    setState(() {
      isPausing = !isPausing;
    });
  }


  Future<void> onRecordEnd() async {
    final recordingProvider = context.read<CameraRecordingProvider>();
    final audioRecordingProvider = context.read<AudioRecorderProvider>();
    final isAudioRecord = recordMode == RecordMode.audio;
    String? finalPath;


    if (isAudioRecord) {
      finalPath = await audioRecordingProvider.stopRecording();
    } else {
      await recordingProvider.stopRecording();
      final paths = recordingProvider.recordedSegments.map((e) => e.path).toList();
      if (paths.length > 1) {
        final merged = await VideoMergerHelper.mergeVideos(paths);
        if (merged != null) {
          print("✅ Đã merge video: $merged");
          finalPath = merged;
        }
      } else if (paths.isNotEmpty) {
        print("✅ Đã quay xong 1 đoạn: ${paths.first}");
        finalPath = paths.first;
      }
      recordingProvider.reset();
    }
    setState(() {
      isPausing = false;
      isRecording = false;
    });
    Navigator.push(context, CupertinoPageRoute(builder: (context) =>
      AiVoicePreviewScreen(
        voiceModel: widget.voiceModel,
        isAudio: isAudioRecord,
        path: finalPath,),
      )
    );
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
    bool isAudioRecord = recordMode == RecordMode.audio;
    return Scaffold(
      appBar: AppBarCustom(
        title: isRecording ? _buildTimeUI(_timer) : Text(context.locale.ai_voice_changer, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        leading: IconButtonCustom(
          icon: SvgPicture.asset(ResIcon.icBack),
          onPressed: () {
            print('asda');
            if(isRecording){
              final ConfirmDialog confirmDialog = ConfirmDialog(
                imageHeader: ResImages.iconDiscard,
                title: context.locale.discard,
                content: context.locale.discard_des,
                textCancel: context.locale.stay_here,
                textAccept: context.locale.leave,
                onCancelPress: () {
                  Navigator.pop(context);
                },
              );
              confirmDialog.show(context);
              return;
            }
            Navigator.pop(context);
          },
          style: const IconButtonCustomStyle(
            backgroundColor: Colors.white,
            borderRadius: 15,
            padding: EdgeInsets.all(11.0),
          ),
        ),
        actions: [
          if(!isAudioRecord)
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icRotateCamera),
            onPressed: () {
              context.read<CameraProvider>().switchCamera();
            },
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
                    child: isAudioRecord ? Lottie.asset('assets/anim/anim_audio.json') : CameraView()
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
                  icon: SvgPicture.asset(!isAudioRecord ? ResIcon.icRecordsMic : ResIcon.icRecordsVideo, height: 30,),
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
                child: Image.asset(widget.voiceModel.image, height: 50,)),
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
  void _showSnackBar(){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.locale.min_video_length_is_2_seconds,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black.withValues(alpha: 0.7),
        elevation: 0,
        padding: EdgeInsets.all(12),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 66),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
