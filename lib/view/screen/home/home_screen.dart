import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/extensions/effect_extension.dart';
import 'package:voice_changer_flutter/core/utils/effect_list.dart';
import 'package:voice_changer_flutter/data/model/effect.dart';
import 'package:voice_changer_flutter/service/audio_effect_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void applyEffect(Effect effect) {
    AudioEffectService.playAudioWithEffect({
      "pitch": effect.pitch,
      "speed": effect.speed,
      "newReverb": effect.newReverb?.stringValue,
      "amplify": effect.amplify,
      "newEcho": effect.newEcho,
      "distort": effect.distort,
      "distortType": effect.distortType?.stringValue,
      "filter": effect.filter?.stringValue,
      "eq1": effect.eq1,
      "eq2": effect.eq2,
      "eq3": effect.eq3,
    });
  }

  void stopAudio() {
    AudioEffectService.stopAudio();
  }

  void onIndexChanged(){
    setState(() {
      ++_currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(listEffects()[_currentIndex].name, style: TextStyle(color: Colors.blue, fontSize: 24),),
              TextButton(
                onPressed: (){
                  applyEffect(listEffects()[_currentIndex > 0? _currentIndex - 1 : _currentIndex]);
                  onIndexChanged();
                },
                child: Text('Play Audio', style: TextStyle(color: Colors.black, fontSize: 24),)
              ),
              TextButton(
                  onPressed: (){
                    stopAudio();
                  },
                  child: Text('Stop Audio', style: TextStyle(color: Color(0xFF27100A), fontSize: 24),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
