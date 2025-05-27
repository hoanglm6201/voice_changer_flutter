import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/font.dart';
import 'package:voice_changer_flutter/service/service_locator.dart';
import 'package:voice_changer_flutter/view/screen/language/language_screen.dart';
import 'package:voice_changer_flutter/view/screen/splash/splash_screen.dart';
import 'package:voice_changer_flutter/view_model/locale_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.instance.initialise();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LocateViewModel()),
    ], child: const MyApp()),
  );
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
          fontFamily: ResFont.sfCompactDisplay,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xFFF3F4F8),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: ResColors.textColor,
            ),
          )
        ),
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
