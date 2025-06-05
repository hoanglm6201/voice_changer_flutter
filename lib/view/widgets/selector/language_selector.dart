import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/enum/language_enum.dart';
import 'package:voice_changer_flutter/core/extensions/language_extension.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final ScrollController _scrollController = ScrollController();

  LanguageSelect _languageSelector = LanguageSelect.en;
  bool _isOpen = false;
  bool _showDivider = false;

  @override
  Widget build(BuildContext context) {
    final height = _isOpen ? LanguageSelect.values.length * 30.0 + 2 : 0.0;
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
      child: Container(
        padding: EdgeInsets.all(12).copyWith(
          right: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: InkWell(
          onTap: () {
            setState(() {
              if (!_isOpen) {
                _isOpen = true;
                _showDivider = true;
              } else {
                _isOpen = false;
              }
            });
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ResIcon.icArrowRight,
                    colorFilter: ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    _languageSelector.displayName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isOpen ? -0.25 : 0,
                    duration: Durations.medium2,
                    child: SvgPicture.asset(ResIcon.icArrowRight),
                  ),
                ],
              ),
              if (_showDivider) ...[
                ResSpacing.h12,
                Divider(
                  color: ResColors.colorGray.withValues(alpha: 0.2),
                  height: 1,
                ),
              ],
              AnimatedContainer(
                height: height.toDouble(),
                duration: Durations.medium2,
                onEnd: () {
                  if (!_isOpen) {
                    if (mounted) {
                      setState(() {
                        _showDivider = false;
                      });
                    }
                  }
                },
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 10),
                  itemCount: LanguageSelect.values.length,
                  itemBuilder: (context, index) {
                    final item = LanguageSelect.values[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _languageSelector = item;
                          _isOpen = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(12).copyWith(right: 14),
                        child: Center(
                          child: Text(
                            item.displayName,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _languageSelector == item
                                  ? ResColors.colorPurple
                                  : ResColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
