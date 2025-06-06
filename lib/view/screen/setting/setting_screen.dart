import 'package:base_ui_flutter_v1/base_ui_flutter_v1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/constants/setting_funcs.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/language/language_screen.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: IconButtonCustom(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(ResIcon.icBack),
        ),
        title: Text(context.locale.setting),
      ),
      body: Column(
        children: [
          ResSpacing.h8,
          Expanded(
            child: SettingWidget(
                baseDecoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(4, 4),
                          color: Colors.black.withValues(alpha: 0.05))
                    ],
                    borderRadius: BorderRadius.circular(12)),
                baseMargin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                basePadding: EdgeInsets.all(16),
                baseTitleStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  SettingItem(
                    onPress: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LanguageScreen(
                            isFromSetting: true,
                          ),
                        ),
                      );
                    },
                    title: context.locale.language,
                    leading: Image.asset(
                      ResImages.iconSetting,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SettingItem(
                    onPress: () {
                      SettingFuncs.share();
                    },
                    title: context.locale.share,
                    leading: Image.asset(
                      ResImages.iconShare,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SettingItem(
                    onPress: () {
                      // SettingFuncs.rateUs(context);
                    },
                    title: context.locale.rate_us,
                    leading: Image.asset(
                      ResImages.iconRate,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SettingItem(
                    onPress: () {
                      SettingFuncs.termsOfService();
                    },
                    title: context.locale.term_of_service,
                    leading: Image.asset(
                      ResImages.iconTermsOfUser,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  SettingItem(
                    onPress: () {
                      SettingFuncs.privacyPolicy();
                    },
                    title: context.locale.privacy_policy,
                    leading: Image.asset(
                      ResImages.iconPolicy,
                      width: 25,
                      height: 25,
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
