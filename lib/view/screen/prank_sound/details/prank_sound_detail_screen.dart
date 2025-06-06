import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/prank_sound_model.dart';
import 'package:voice_changer_flutter/view/screen/prank_sound/widget/loop_widget.dart';
import 'package:voice_changer_flutter/view/widgets/appbar/app_bar_custom.dart';
import 'package:voice_changer_flutter/view/widgets/button/gradient_button.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';
import 'package:voice_changer_flutter/view/widgets/item/prank_category_item.dart';
import 'package:voice_changer_flutter/view/widgets/item/prank_sound_item.dart';
import 'package:voice_changer_flutter/view_model/prank_sound_provider.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            _buildCarousel(),
            SizedBox(height: 60),
            Consumer<PrankSoundProvider>(builder: (context, value, child) {
              return Text(value.formattedCountdown.toString());
            },),
            _buildSetting(),
            SizedBox(height: 10),
            LoopTimerCard(),
            Spacer(),
            GradientButton(
              style: GradientButtonStyle(borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(vertical: 16),
              onTap: () {
                context.read<PrankSoundProvider>().startCountdown();
              },
              child: Center(child: Text(context.locale.start, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
              ),
            )
          ]
        ),
      ),
    );
  }
  Widget _buildSetting(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(context.locale.setting, style: TextStyle(fontSize: 13),))
        ],
      ),
    );
  }
  Widget _buildCarousel(){
    final screenWidth = MediaQuery.sizeOf(context).width;
    final int initialIndex = widget.categoryModel.sounds.indexWhere(
          (e) => e.id == widget.prankSoundModel.id,
    );
    return  CarouselSlider(
      controller: _controller,
      options: CarouselOptions(
        height: screenWidth * 0.45,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.41,
        initialPage: initialIndex,
        aspectRatio: 16/9,
        disableCenter: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        onPageChanged: (index, reason) {
        },
      ),
      items: widget.categoryModel.sounds.map((sound) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(top: 10) ,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: PrankSoundItem(
              prankSoundModel: sound,
              isShadow: false,
            ),
          ),
        );
      }).toList(),
    );
  }
}
