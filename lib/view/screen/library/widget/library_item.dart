import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';

class LibraryItem extends StatelessWidget {
  const LibraryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25), // alpha = 0.1 * 255 ~ 25
            blurRadius: 18,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(ResIcon.icAvatarLib),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Girl_void_${const Uuid().v4()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ResColors.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Mon, 19 May 2025 • 16:19 PM",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ResColors.colorGray,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            offset: Offset(-20, 25),
            icon: Icon(
              Icons.more_vert,
              color: ResColors.colorGray,
            ),
            onSelected: (value) {
              if (value == 'share') {
                print('Chọn Share');
              } else if (value == 'delete') {
                print('Chọn Delete');
              }
            },
            color: Colors.white,
            elevation: 0.5,
            borderRadius: BorderRadius.circular(10),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                padding: EdgeInsets.zero,
                height: 32,
                value: 'share',
                child: Center(
                  child: Text(
                    context.locale.share,
                    style: TextStyle(
                      color: ResColors.textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                padding: EdgeInsets.zero,
                height: 1,
                child: Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 10,),
                  color: ResColors.colorGray.withValues(
                    alpha: 0.1,
                  ),
                ),
              ),
              PopupMenuItem<String>(
                height: 32,
                padding: EdgeInsets.zero,
                value: 'delete',
                child: Center(
                  child: Text(
                    context.locale.delete,
                    style: TextStyle(
                      color: Color(0xFFED213A),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
