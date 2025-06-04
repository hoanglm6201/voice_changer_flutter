import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_ui_flutter_v1/base_ui_flutter_v1.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';

class ConfirmDialog extends DialogBase {
  String? imageHeader;
  String? title;
  String? content;
  String textCancel;
  String textAccept;

  TextStyle? titleStyle;
  TextStyle? contentStyle;
  TextStyle? cancelTextStyle;
  TextStyle? acceptTextStyle;

  EdgeInsets watchAdsPadding;
  EdgeInsets cancelPadding;

  Color backgroundColor;
  BorderRadius borderRadius;

  Function()? onCancelPress;
  Function()? onConfirmPress;

  ConfirmDialog({
    this.imageHeader,
    this.title,
    this.content,
    required this.textCancel,
    required this.textAccept,
    this.titleStyle,
    this.contentStyle,
    this.cancelTextStyle,
    this.acceptTextStyle,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    super.barrierDismissible,
    super.onCompleted,
    this.watchAdsPadding = const EdgeInsets.symmetric(vertical: 16),
    this.cancelPadding = const EdgeInsets.symmetric(vertical: 16),
    this.onCancelPress,
    this.onConfirmPress,
  }) {
    barrierDismissible = true;
    if (onCancelPress != null) {
      acceptAction(onCancelPress!);
    }
    if (onConfirmPress != null) {
      declineAction(onConfirmPress!);
    }
  }

  @override
  Future<void> onShow(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.7, sigmaY: 3.7, tileMode: TileMode.mirror),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Dialog(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ResSpacing.h16,
                  if (imageHeader != null && imageHeader?.trim() != "")
                    Image.asset(
                      imageHeader!,
                      width: 72,
                      height: 72,
                    ),
                  ResSpacing.h8,
                  if (title != null)
                    ...[
                      Text(
                        title ?? "",
                        style: titleStyle ??
                            const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ResColors.textColor,
                            ),
                      ),
                      ResSpacing.h16,
                    ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      content ?? "",
                      textAlign: TextAlign.center,
                      style: contentStyle ??
                          const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ResColors.textColor,
                          ),
                    ),
                  ),
                  ResSpacing.h14,
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color.fromRGBO(190, 183, 219, 0.5),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              textAccept,
                              style: acceptTextStyle ??
                                  const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                  ),
                            ),
                          ),
                          onTap: () {
                            onAccept();
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color.fromRGBO(190, 183, 219, 0.5),
                                  width: 0.5,
                                ),
                                left: BorderSide(
                                  color: Color.fromRGBO(190, 183, 219, 0.5),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              textCancel,
                              style: cancelTextStyle ??
                                  const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: ResColors.textColor,
                                  ),
                            ),
                          ),
                          onTap: () {
                            onCancel();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).then(
      (value) {
        setIsShowing(false);
        if (onCompleted != null) {
          onCompleted!();
        }
      },
    );
  }
}
