import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_changer_flutter/constants/key_share_preference.dart';
import 'package:voice_changer_flutter/service_locator/service_locator.dart';

class AppSettingsProvider with ChangeNotifier {

  final _prefs = ServiceLocator.instance.get<SharedPreferences>();

  bool _isFirstOpenApp = true;
  bool _isInitialized = false;

  bool get isFirstOpenApp => _isFirstOpenApp;
  bool get isInitialized => _isInitialized;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isShowRate = true;
  bool get isShowRate => _isShowRate;

  bool _showRate = true;
  bool get showRate => _showRate;

  bool _isFirstShowRate = false;
  bool get isFirstShowRate => _isFirstShowRate;

  int _timeOpenApp = 0;
  int get timeOpenApp => _timeOpenApp;

  int _timeUserUse = 0;
  int get timeUserUse => _timeUserUse;

  int _timeOpenAds = 0;
  int get timeOpenAds => _timeOpenAds;

  AppSettingsProvider() {
    _initSettings();
    getFirstOpenApp().then((value) {
      _isFirstOpenApp = value;
      notifyListeners();
    });
  }

  Future<void> _initSettings() async {
    _isFirstOpenApp = await getFirstOpenApp();
    _isInitialized = true;
    _isShowRate = await getIsShowRate();
    _showRate = await getShowRate();
    _timeOpenApp = await getTimeOpenApp();
    _isFirstShowRate = await getFirstShowRate();
    _timeUserUse = await getTimeUse();
    print(_timeUserUse);
    notifyListeners();
  }

  Future<bool> getFirstOpenApp() async {
    bool? savedValue = _prefs.getBool(SharePreferencesKey.isFirstTime);
    print('get first open');
    return savedValue ?? true;
  }

  Future<void> setFirstOpenApp() async {
    _isFirstOpenApp = false;
    notifyListeners();
    await _prefs.setBool(SharePreferencesKey.isFirstTime, false);
    print('set first open app');
  }

  Future<bool> getIsShowRate() async {
    bool? savedValue = _prefs.getBool(SharePreferencesKey.isShowRate);
    return savedValue ?? true;
  }

  Future<void> setIsShowRate() async {
    _isShowRate = false;
    notifyListeners();
    await _prefs.setBool(SharePreferencesKey.isShowRate, false);
    print('Show rate updated to false');
  }

  Future<bool> getShowRate() async {
    bool? savedValue = _prefs.getBool(SharePreferencesKey.isFirstShowRate);
    return savedValue ?? true;
  }

  Future<void> setShowRate() async {
    _showRate = false;
    notifyListeners();
    await _prefs.setBool(SharePreferencesKey.isFirstShowRate, false);
  }
  Future<bool> getFirstShowRate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? savedValue = prefs.getBool(SharePreferencesKey.isFirstOpenShow);
    return savedValue ?? false;
  }

  Future<void> setFirstShowRate() async {
    _isFirstShowRate = true;
    notifyListeners();
    await _prefs.setBool(SharePreferencesKey.isFirstOpenShow, false);
    print(_isFirstShowRate);
  }
  Future<int> getTimeOpenApp() async {
    int? savedValue = _prefs.getInt(SharePreferencesKey.timeOpenApp);
    return savedValue ?? 0;
  }

  Future<void> increaseTimeOpenApp() async {
    _timeOpenApp ++;
    notifyListeners();
    await _prefs.setInt(SharePreferencesKey.timeOpenApp, _timeOpenApp);
  }
  void updateTimeOpenAds() {
    _timeOpenAds ++;
    print('time open ads: $_timeOpenAds');
    notifyListeners();
  }

  Future<void> increaseTimeUse() async {
    _timeUserUse ++;
    notifyListeners();
    await _prefs.setInt(SharePreferencesKey.timeUse, _timeUserUse);
  }

  Future<int> getTimeUse() async {
    int? savedValue = _prefs.getInt(SharePreferencesKey.timeUse);
    return savedValue ?? 0;
  }

}
