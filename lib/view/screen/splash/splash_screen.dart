import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/constants/app_info.dart';
import 'package:voice_changer_flutter/view/screen/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {

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
    if(state == AppLifecycleState.paused) {
      // AdController.shared.toggleResumeAdDisabled(true);
    }
    if(state == AppLifecycleState.resumed) {
      // AdController.shared.toggleResumeAdDisabled(false);
    }
  }

  void _onLoadingEnd() {
    // final adsProvider = Provider.of<AdsProvider>(context, listen: false);
    // adsProvider.showInterAd(name: "inter_splash", callback: _navigateToHome);
  }

  Future<void> _navigateToHome() async {
    // AdController.shared.toggleResumeAdDisabled(false);
    // final isFirstOpenApp = Provider.of<AppStateProvider>(context, listen: false).isFirstOpenApp;

    // if (isFirstOpenApp) {
    //   Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const LanguageScreen(isFromSetting: false,)));
    // } else {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const HomeScreen()));
      // Provider.of<AppSettingsProvider>(context, listen: false).increaseTimeOpenApp();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.greenAccent
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 72,),
                ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(AppInfo.appIcon, width: 81, height: 81, fit: BoxFit.cover,)),
                const SizedBox(height: 12,),
                const Text('Voice Changer', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),),
                const SizedBox(height: 20,),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 2), // Thời gian hoàn thành
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 8
                      );
                    },
                    onEnd: _navigateToHome,
                  )
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
