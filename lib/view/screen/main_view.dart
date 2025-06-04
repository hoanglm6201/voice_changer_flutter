import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/view/screen/home/home_screen.dart';
import 'package:voice_changer_flutter/view/screen/library/library_screen.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget Function()> _screenBuilders = [
        () => const HomeScreen(),
        () => const LibraryScreen(),
  ];

  late final List<Widget?> _screens = List.filled(_screenBuilders.length, null);

  Widget _getScreenAt(int index) {
    if (_screens[index] == null) {
      _screens[index] = _screenBuilders[index]();
    }

    return _screens[index]!;
  }


  @override
  Widget build(BuildContext context) {
    _getScreenAt(_selectedIndex);
    return Scaffold(
      appBar: AppBarCustom(
        leading: IconButtonCustom(
          icon: SvgPicture.asset(ResIcon.icUpload),
          onPressed: () {},
          style: const IconButtonCustomStyle(
            backgroundColor: Colors.white,
            borderRadius: 15,
            padding: EdgeInsets.all(11.0),
          ),
        ),
        actions: [
          IconButtonCustom(
            icon: SvgPicture.asset(ResIcon.icSetting),
            onPressed: () {},
            style: const IconButtonCustomStyle(
              backgroundColor: Colors.white,
              borderRadius: 15,
              padding: EdgeInsets.all(11.0),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(_screenBuilders.length, (index) {
          return _screens[index] ?? const Center(child: CupertinoActivityIndicator());
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: Offset(0, 20),
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(ResImages.bgGradient), fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(97, 62, 234, 0.3),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ]
            ),
            child: Center(
              child: SvgPicture.asset(
                ResIcon.icMic,
                width: 30,
                height: 34,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 28),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(ResImages.bgBottomNav)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              ResIcon.icHome,
              _selectedIndex == 0,
              context.locale.home,
              () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            _buildItem(
                ResIcon.icLibrary, _selectedIndex == 1, context.locale.library,
                () {
              setState(() {
                _selectedIndex = 1;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      String iconPath, bool isSelected, String label, Function() onTap) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16).copyWith(bottom: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isSelected ? ResColors.colorPurple : ResColors.colorGray,
                BlendMode.srcIn,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? ResColors.colorPurple : ResColors.colorGray,
              ),
            )
          ],
        ),
      ),
    );
  }
}
