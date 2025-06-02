import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_changer_flutter/constants/app_info.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/service_locator/service_locator.dart';
import 'package:voice_changer_flutter/view/screen/home/home_screen.dart';
import 'package:voice_changer_flutter/view/screen/language/language_screen.dart';
import 'package:voice_changer_flutter/view/widgets/progress_bar/gradient_progress_bar.dart';
import 'package:voice_changer_flutter/view_model/app_state_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {

  final _prefs = ServiceLocator.instance.get<SharedPreferences>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // AdController.shared.toggleResumeAdDisabled(true);
    }
    if (state == AppLifecycleState.resumed) {
      // AdController.shared.toggleResumeAdDisabled(false);
    }
  }

  void _onLoadingEnd() {
    // final adsProvider = Provider.of<AdsProvider>(context, listen: false);
    // adsProvider.showInterAd(name: "inter_splash", callback: _navigateToHome);
  }

  Future<void> _navigateToHome() async {
    // AdController.shared.toggleResumeAdDisabled(false);
    final isFirstOpenApp = Provider.of<AppStateProvider>(context, listen: false).isFirstOpenApp;

    if (isFirstOpenApp) {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const LanguageScreen(isFromSetting: false,)));
    } else {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const HomeScreen()));
    // Provider.of<AppSettingsProvider>(context, listen: false).increaseTimeOpenApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ResImages.appIcon),
            const SizedBox(
              height: 12,
            ),
            Image.asset(ResImages.appName),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "LOADING ...",
              style: TextStyle(
                color: ResColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            ResSpacing.h16,
            FractionallySizedBox(
              widthFactor: 0.8,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return GradientProgressBar(
                    percent: (value * 100).toInt(),
                    gradient: ResColors.primaryGradient,
                    backgroundColor: ResColors.colorGray.withValues(alpha: 0.15),
                  );
                },
                onEnd: _navigateToHome,
              ),
            ),
            ResSpacing.h16,
            Text(
              "This action may contain ads",
              style: TextStyle(
                color: ResColors.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
