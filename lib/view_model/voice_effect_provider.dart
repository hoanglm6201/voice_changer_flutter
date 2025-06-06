import 'package:flutter/cupertino.dart';
import 'package:voice_changer_flutter/core/utils/effect_list.dart';
import 'package:voice_changer_flutter/data/model/effect.dart';

class VoiceEffectProvider extends ChangeNotifier {
  Effect? _selectedEffect;

  Effect? get selectedEffect => _selectedEffect;

  void selectEffect(Effect effect) {
    _selectedEffect = effect;
    notifyListeners();
  }
}