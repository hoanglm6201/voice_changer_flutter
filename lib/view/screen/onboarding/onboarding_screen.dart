import 'package:base_ui_flutter_v1/base_ui_flutter_v1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/home/home_screen.dart';
import 'package:voice_changer_flutter/view/widgets/text/text_gradient.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  PageController controller = PageController();
  int activePageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseOnboardingWidget(
        controller: controller,
        activePageIndex: activePageIndex,
        onPageIndexChanged: (value) {
          setState(() {
            activePageIndex = value;
          });
        },
        onNext: () {
          if (activePageIndex == 3) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        buttonDecorationBuilder: (context, index) => BoxDecoration(
          border: Border.all(
            color: ResColors.softPurple,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(21.1),
        ),
        buttonText: (index) => index == 3 ? context.locale.start : context.locale.next,
        trailingAdsBuilder: (context, index) {
          if(index != 0 && index != 3){
            return const SizedBox(height: kBottomNavigationBarHeight,);
          }
          return Container(
            height: 300,
            width: double.infinity,
            color: Colors.red,
          );
        },
        currentDotColor: ResColors.softPurple,
        dotColor: ResColors.colorGray.withValues(alpha: 0.2),
        centerDot: true,
        children: [
          OnboardingItem(
            title: TextGradient(text: context.locale.title_onboarding_1),
            subTitle: Text(context.locale.sub_title_onboarding_1),
            imageWidget: Image.asset(ResImages.onboarding1),
            imagePadding: EdgeInsets.zero,
          ),
          OnboardingItem(
            title: TextGradient(text: context.locale.title_onboarding_2),
            subTitle: Text(context.locale.sub_title_onboarding_2),
            imageWidget: Image.asset(ResImages.onboarding2),
            imagePadding: EdgeInsets.zero,
          ),
          OnboardingItem(
            title: TextGradient(text: context.locale.title_onboarding_3),
            subTitle: Text(context.locale.sub_title_onboarding_3),
            imageWidget: Image.asset(ResImages.onboarding3),
            imagePadding: EdgeInsets.zero,
          ),
          OnboardingItem(
            title: TextGradient(text: context.locale.title_onboarding_4),
            subTitle: Text(context.locale.sub_title_onboarding_4),
            imageWidget: Image.asset(ResImages.onboarding4),
            imagePadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
