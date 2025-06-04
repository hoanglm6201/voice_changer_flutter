import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/home/widget/header_welcome.dart';
import 'package:voice_changer_flutter/view/screen/library/widget/library_item.dart';
import 'package:voice_changer_flutter/view/screen/library_detail/library_detail_screen.dart';
import 'package:voice_changer_flutter/view/widgets/container/gradient_box_border.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox.shrink(),
        HeaderWelcome(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 43),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIndicator(
                _selectedTabIndex == 0,
                context.locale.ai_voices,
                ResImages.iconMicAI,
                () {
                  setState(() {
                    _selectedTabIndex = 0;
                  });
                },
              ),
              _buildIndicator(
                _selectedTabIndex == 1,
                context.locale.voice_changer,
                ResImages.iconMicStar,
                () {
                  setState(() {
                    _selectedTabIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LibraryDetailScreen(isVideo: true,),
                    ),
                  );
                },
                child: LibraryItem(),
              );
            },
            separatorBuilder: (BuildContext context, int index) => ResSpacing.h8,
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(bool isSelected, String text, String icon, Function() onTap) {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? GradientBoxBorder(gradient: ResColors.primaryGradient, width: 1.5) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.74,
                spreadRadius: 0.4,
                offset: Offset(0, 1)
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Image.asset(
                icon,
                width: 20,
                height: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ResColors.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
