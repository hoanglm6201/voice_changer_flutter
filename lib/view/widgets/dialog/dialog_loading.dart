import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_ui_flutter_v1/base_ui_flutter_v1.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';

class DialogLoading extends DialogBase {
  String? imageHeader;

  DialogLoading({
    this.imageHeader,
  }) {
    barrierDismissible = true;

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
                children: [
                  if (imageHeader != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Image.asset(
                        imageHeader!,
                        height: MediaQuery.sizeOf(context).width * 0.26,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text("Loading...")
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
