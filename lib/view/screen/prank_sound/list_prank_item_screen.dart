import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/prank_sound_model.dart';
import 'package:voice_changer_flutter/view/screen/prank_sound/details/prank_sound_detail_screen.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/item/prank_sound_item.dart';

class ListPrankItemScreen extends StatelessWidget {
  final PrankSoundCategory categoryModel;
  const ListPrankItemScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title:Text("${context.locale.list} ${categoryModel.title}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        leading: IconButtonCustom(
          icon: SvgPicture.asset(ResIcon.icBack),
          onPressed: () {
            Navigator.pop(context);
          },
          style: const IconButtonCustomStyle(
            backgroundColor: Colors.white,
            borderRadius: 15,
            padding: EdgeInsets.all(11.0),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        itemCount: categoryModel.sounds.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,
          crossAxisSpacing: 12
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => PrankSoundDetailScreen(categoryModel: categoryModel, prankSoundModel: categoryModel.sounds[index],)));
            },
            child: PrankSoundItem(prankSoundModel: categoryModel.sounds[index],)
          );
        },
      ),
    );
  }
}
