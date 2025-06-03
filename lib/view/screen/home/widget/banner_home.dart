import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';

class BannerHome extends StatelessWidget {
  final Function() onTap;
  const BannerHome({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 25 - 25;
    final height = width * 0.47;
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          clipBehavior: Clip.none,
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(ResImages.bgBannerHome),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  ResImages.bannerPlayer,
                  height: height + 15,
                  width: height,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: width / 1.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(ResImages.appName, height: 58,),
                        Text(
                          context.locale.sub_banner_home,
                          style: TextStyle(
                            fontSize: 10.76,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(107),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(ResImages.iconMicAI, width: 20, height: 20,),
                              ResSpacing.w4,
                              Text(context.locale.let_go, style: TextStyle(fontSize: 12, color: Color(0xFFC056EF)),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
