import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/prank_sound_model.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/item/prank_category_item.dart';
import 'package:voice_changer_flutter/view/widgets/item/prank_sound_item.dart';

class PrankSoundDetailScreen extends StatefulWidget {
  final PrankSoundCategory categoryModel;
  final PrankSound prankSoundModel;
  const PrankSoundDetailScreen({super.key, required this.categoryModel, required this.prankSoundModel});

  @override
  State<PrankSoundDetailScreen> createState() => _PrankSoundDetailScreenState();
}

class _PrankSoundDetailScreenState extends State<PrankSoundDetailScreen> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final int initialIndex = widget.categoryModel.sounds.indexWhere(
          (e) => e.id == widget.prankSoundModel.id,
    );
    return Scaffold(
      appBar: AppBarCustom(
        title:Text("${context.locale.list} ${widget.categoryModel.title}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
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
      body: Column(
        children: [
          CarouselSlider(
            controller: _controller,
            options: CarouselOptions(
              height: screenWidth * 0.4,
              enlargeCenterPage: true,
              animateToClosest: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.32,
              initialPage: initialIndex,
              aspectRatio: 16/9,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
              },
            ),
            items: widget.categoryModel.sounds.map((sound) {
              return PrankSoundItem(
                prankSoundModel: sound,
                isShadow: false,
              );
            }).toList(),
          )
        ]
      ),
    );
  }
}
