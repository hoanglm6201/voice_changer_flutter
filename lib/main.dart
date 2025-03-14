import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/service/service_locator.dart';
import 'package:voice_changer_flutter/view/screen/splash/splash_screen.dart';
import 'package:voice_changer_flutter/view_model/locale_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.instance.initialise();

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => LocateViewModel()),
      ],
          child: const MyApp()
      ));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Selector<LocateViewModel, Locale>(
      selector: (context, localeProvider) => localeProvider.locale,
      builder: (context, locale, child) => MaterialApp(
        theme: ThemeData(
          fontFamily: 'SF Bold',
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        locale: locale,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..indicatorSize = 0
    ..radius = 12.0
    ..textColor = Colors.black
    ..maskColor = Colors.black.withValues(alpha: 0.4)
    ..dismissOnTap = true
    ..indicatorWidget = null
    ..indicatorColor = Colors.transparent;
}
