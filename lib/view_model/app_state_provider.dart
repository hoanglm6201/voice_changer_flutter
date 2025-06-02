import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_changer_flutter/constants/key_share_preference.dart';
import 'package:voice_changer_flutter/service_locator/service_locator.dart';
import 'package:voice_changer_flutter/view_model/ads_provider.dart';
import 'package:voice_changer_flutter/view_model/purchase_provider.dart';

class AppStateProvider with ChangeNotifier {
  AdsProvider adsProvider;
  PurchaseProvider purchaseProvider;
  final _prefs = ServiceLocator.instance.get<SharedPreferences>();
  bool _isFirstOpenApp = false;

  bool get isFirstOpenApp => _isFirstOpenApp;

  // bool get shouldShowAds => adsProvider.adsEnabled && !purchaseProvider.isSubscribed;

  AppStateProvider(this.adsProvider, this.purchaseProvider) {
    getFirstOpenApp().then((value) {
      _isFirstOpenApp = value;
      notifyListeners();
      // purchaseProvider.loadSubscription().then((_) {
      //   // initializeAds();
      // });

      if (_isFirstOpenApp) {
        // AnalyticsTracker.trackInstallEvent();
      }
    });
  }

  DateTime? _lastAdTime;
  bool _isLoading = false;

  DateTime? get lastAdTime => _lastAdTime;

  bool get isLoading => _isLoading;

  void setLastAdTime(DateTime? dateTime) {
    _lastAdTime = dateTime;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void updateDependencies(AdsProvider adsProvider, PurchaseProvider purchaseProvider) {
    // adsProvider = adsProvider;
    // purchaseProvider = purchaseProvider;
    notifyListeners();
  }

  void updateAdsState(bool isEnabled) {
    // adsProvider.updateAdsState(isEnabled);
    notifyListeners();
  }

  void togglePurchase() {
    // purchaseProvider.togglePurchase();
    notifyListeners();
  }

  // void initializeAds() {
  //   AdController.shared.initialize(
  //     isAdDisabled: !shouldShowAds,
  //     configurations: getAdConfigurations(_isFirstOpenApp),
  //     adjustConfig: AdjustConfig("s7auhvppayv4", AdjustEnvironment.production),
  //   );
  // }

  Future<bool> getFirstOpenApp() async {
    bool? savedValue = _prefs.getBool(SharePreferencesKey.isFirst);
    return savedValue ?? true;
  }

  Future<void> setFirstOpenApp() async {
    _isFirstOpenApp = false;
    notifyListeners();
    await _prefs.setBool(SharePreferencesKey.isFirst, false);
  }
}
