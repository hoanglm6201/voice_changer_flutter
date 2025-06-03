import 'package:base_ui_flutter_v1/base_ui_flutter_v1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/core/enum/language_enum.dart';
import 'package:voice_changer_flutter/core/extensions/language_extension.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/onboarding/onboarding_screen.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view_model/locale_view_model.dart';

class LanguageScreen extends StatelessWidget {
  final bool isFromSetting;

  const LanguageScreen({super.key, this.isFromSetting = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: isFromSetting ? IconButtonCustom(
          style: IconButtonCustomStyle(
            padding: EdgeInsets.all(10.0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: ResColors.textColor,
          ),
        ) : null,
        title: Text(context.locale.language),
        actions: [
          if(context.watch<LocateViewModel>().selectedLanguage != null)
          IconButtonCustom(
            onPressed: () {
              context.read<LocateViewModel>().saveLanguage();
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => OnboardingScreen(),));
            },
            style: IconButtonCustomStyle(
              padding: EdgeInsets.all(12.0),
            ),
            icon: SvgPicture.asset(
              ResIcon.icCheck,
            ),
          ),
        ],
      ),
      body: Consumer<LocateViewModel>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
            child: LanguageWidget<LanguageEnum>(
              shrinkWrap: true,
              languages: LanguageEnum.values,
              selectedLanguage: value.selectedLanguage,
              onLanguageChanged: (value) {
                context.read<LocateViewModel>().selectLanguage(value);
              },
              leadingBuilder: (context, item) =>
                  SvgPicture.asset(item.getFlag),
              itemTextStyleBuilder: (item, isSelected) {
                return TextStyle(
                  color: isSelected ? ResColors.textColor : ResColors.colorGray,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                );
              },
              displayLanguageNameBuilder: (value) => value.displayName(context),
              spacingItem: 8,
              itemDecorationBuilder: (item, isSelected) {
                return BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected ? ResColors.colorPurple : Colors.transparent,
                    width: 1.5,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
