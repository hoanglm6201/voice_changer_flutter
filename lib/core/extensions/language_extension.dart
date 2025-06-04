import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/enum/language_enum.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';

extension LanguageExtension on LanguageEnum {
  String displayName(BuildContext context) {
    switch (this) {
      case LanguageEnum.en:
        return 'United States';
      case LanguageEnum.de:
        return 'German';
    case LanguageEnum.es:
      return 'Spanish';
      case LanguageEnum.ko:
        return 'Korean';
      case LanguageEnum.fr:
        return 'French';
      case LanguageEnum.pt:
        return 'Portuguese';
      case LanguageEnum.hi:
        return 'Hindi';
      case LanguageEnum.ru:
        return 'Russian';
    }
  }

  String get getFlag {
    switch (this) {
      case LanguageEnum.en:
        return ResIcon.unitedStates;
      case LanguageEnum.de:
        return ResIcon.german;
    case LanguageEnum.es:
      return ResIcon.spanish;
      case LanguageEnum.ko:
        return ResIcon.korean;
      case LanguageEnum.fr:
        return ResIcon.french;
      case LanguageEnum.pt:
        return ResIcon.portuguese;
      case LanguageEnum.hi:
        return ResIcon.hindi;
      case LanguageEnum.ru:
        return ResIcon.russia;
    }
  }

  String get code {
    return name;
  }

  Locale toLocale() {
    return Locale(code);
  }
}

extension LanguageSelectExtension on LanguageSelect {
  String get displayName {
    switch (this) {
      case LanguageSelect.en:
        return 'English';
      case LanguageSelect.es:
        return 'Spanish';
      case LanguageSelect.ar:
        return 'Arabic';
      case LanguageSelect.id:
        return 'Indonesian';
      case LanguageSelect.pt:
        return 'Portuguese';
      case LanguageSelect.fr:
        return 'French';
      case LanguageSelect.ru:
        return 'Russian';
      case LanguageSelect.tr:
        return 'Turkish';
      case LanguageSelect.th:
        return 'Thai';
      case LanguageSelect.vi:
        return 'Vietnamese';
    }
  }

  String get code {
    return name;
  }

  Locale toLocale() {
    return Locale(code);
  }
}

extension StringToLanguageEnum on String {
  LanguageEnum? toLanguageEnum() {
    try {
      return LanguageEnum.values.firstWhere((e) => e.name == this);
    } catch (_) {
      return null;
    }
  }
}
