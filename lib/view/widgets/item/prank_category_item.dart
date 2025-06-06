import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/data/model/prank_sound_model.dart';
import 'package:voice_changer_flutter/view/screen/prank_sound/list_prank_item_screen.dart';

class PrankCategoryItem extends StatelessWidget {
  final PrankSoundCategory categoryModel;
  const PrankCategoryItem({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => ListPrankItemScreen(categoryModel: categoryModel,)));
      },
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 3, offset: Offset(0, 3))
          ]
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                  image: DecorationImage(image: AssetImage(categoryModel.thumbnail), fit: BoxFit.cover)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0).copyWith(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      categoryModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, size: 20,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
