import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_ui_flutter_v1/base_ui_flutter_v1.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';

class LoadingDialog extends DialogBase {
  final String animLoading;

  LoadingDialog({
    required this.animLoading,
    super.onCompleted,
  }) {
    barrierDismissible = true;
  }

  @override
  Future<void> onShow(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.7,
            sigmaY: 3.7,
            tileMode: TileMode.mirror,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(animLoading,
                        width: 72,
                        height: 72,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 16),
                      Text("Loading...", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,),),
                    ],
                  ),
                ),
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
