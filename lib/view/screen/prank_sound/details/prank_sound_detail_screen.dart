import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
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
  int carouselIndex = 0;
  late int initialIndex;
  @override
  void initState() {
    super.initState();

    initialIndex = widget.categoryModel.sounds.indexWhere(
          (e) => e.id == widget.prankSoundModel.id,
    );

    if (initialIndex == -1) initialIndex = 0;

    carouselIndex = initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Gọi reset hoặc cleanup tại đây
          context.read<PrankSoundProvider>().reset();
        }
      },
      child: Scaffold(
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
                return value.isTimerSet ? Column(
                  children: [
                    Text(context.locale.sound_will_auto_play_after, style: TextStyle(fontSize: 13, color: Colors.black),),
                    Text(value.formattedCountdown, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: ResColors.colorPurple),)
                  ],
                ): SizedBox.shrink();
              },),
              _buildSetting(),
              SizedBox(height: 10),
              LoopTimerCard(),
              Spacer(),
              _buildButtonStart()
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildButtonStart(){
    return Consumer<PrankSoundProvider>(
      builder: (BuildContext context, PrankSoundProvider value, Widget? child) {
        final gradient = ResColors.primaryGradient;
        return GestureDetector(
          onTap: () {
            value.isPlaying ? value.reset(): value.startCountdown();
          },
          child: Container(
            height: MediaQuery.sizeOf(context).width * 0.135,
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: value.isPlaying ? ResColors.primaryGradient : LinearGradient(colors: [Colors.transparent, Colors.transparent])
            ),
            child: Container(
              height: MediaQuery.sizeOf(context).width * 0.135,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: !value.isPlaying ? ResColors.primaryGradient : LinearGradient(colors: [Colors.white, Colors.white])
              ),
              child: Center(
                  child: !value.isPlaying ?
                  Text(context.locale.start, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                      :
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Gradient icon
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return gradient.createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: SvgPicture.asset(
                          ResIcon.icPause,
                          height: 30,
                          width: 30,
                          color: Colors.white, // Bắt buộc để ShaderMask hoạt động
                        ),
                      ),

                      SizedBox(width: 10),

                      // Gradient text
                      ShaderMask(
                        shaderCallback: (bounds) => gradient.createShader(bounds),
                        blendMode: BlendMode.srcIn,
                        child: Text(
                          context.locale.stop,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white, // Bắt buộc để ShaderMask hoạt động
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        );
      },
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
          setState(() {
            carouselIndex = index;
          });
        },
      ),
      items: widget.categoryModel.sounds.asMap().entries.map((entry) {
        final index = entry.key;
        final sound = entry.value;

        final isSelected = index == carouselIndex;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(top: 10) ,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: isSelected ? 1 :0.3,
              child: PrankSoundItem(
                prankSoundModel: sound,
                isShadow: false,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
