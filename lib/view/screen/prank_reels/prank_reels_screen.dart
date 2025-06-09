import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:voice_changer_flutter/core/res/colors.dart';
import 'package:voice_changer_flutter/core/res/icons.dart';
import 'package:voice_changer_flutter/core/res/spacing.dart';
import 'package:voice_changer_flutter/core/utils/locator_support.dart';
import 'package:voice_changer_flutter/data/model/prank_sound_model.dart';
import 'package:voice_changer_flutter/service_locator/service_locator.dart';
import 'package:voice_changer_flutter/view/screen/prank_sound/list_prank_item_screen.dart';
import 'package:voice_changer_flutter/view/widgets/button/gradient_button.dart';
import 'package:voice_changer_flutter/view/widgets/button/icon_button.dart';

class PrankReelsScreen extends StatefulWidget {
  const PrankReelsScreen({super.key});

  @override
  State<PrankReelsScreen> createState() => _PrankReelsScreenState();
}

class _PrankReelsScreenState extends State<PrankReelsScreen> {
  PageController pageController = PageController();
  final _prefs = ServiceLocator.instance.get<SharedPreferences>();
  List<VideoPlayerController> _controllers = [];
  int _currentIndex = 0;

  List<Map<String, dynamic>> reelState = [];

  List<String> prankReels = [
    "assets/video_test.mp4",
    "assets/video_test.mp4",
    "assets/video_test.mp4",
    "assets/video_test.mp4",
    "assets/video_test.mp4",
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      _initializeVideoControllers();
    });
  }

  void _initializeVideoControllers() {
    // Initialize reelState for each video
    for (int i = 0; i < prankReels.length; i++) {
      reelState.add({
        'index': i,
        'videoPath': prankReels[i],
        'isLoading': true,
        'isInitialized': false,
        'isPlaying': false,
        'volume': 1.0,
        'duration': Duration.zero,
        'position': Duration.zero,
      });
    }

    for (int i = 0; i < prankReels.length; i++) {
      String videoPath = prankReels[i];
      VideoPlayerController controller = VideoPlayerController.asset(videoPath);
      _controllers.add(controller);

      controller.initialize().then((_) {
        if (mounted) {
          setState(() {
            reelState[i]['isLoading'] = false;
            reelState[i]['isInitialized'] = true;
            reelState[i]['duration'] = controller.value.duration;
          });

          // Auto play first video when it's ready
          if (i == 0) {
            controller.play();
            controller.setLooping(true);
          }
        }
      });

      // Add listener to track video state changes
      controller.addListener(() {
        if (mounted && i < reelState.length) {
          setState(() {
            reelState[i]['isPlaying'] = controller.value.isPlaying;
            reelState[i]['position'] = controller.value.position;
            reelState[i]['volume'] = controller.value.volume;
          });
        }
      });
    }
  }

  void _onPageChanged(int index) {
    // Pause current video
    if (_currentIndex < _controllers.length) {
      _controllers[_currentIndex].pause();
    }

    // Play new video
    _currentIndex = index;
    if (index < _controllers.length) {
      _controllers[index].play();
      _controllers[index].setLooping(true);
    }
  }

  void _useThisSound() {
    // Implement the logic to use the selected sound
    Navigator.push(context, CupertinoPageRoute(builder: (context) => ListPrankItemScreen(categoryModel: mockPrankSoundCategories[0]),),);
  }

  @override
  void dispose() {
    for (VideoPlayerController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full screen PageView
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemCount: prankReels.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              if (index >= _controllers.length ||
                  index >= reelState.length ||
                  !_controllers[index].value.isInitialized ||
                  reelState[index]['isLoading']) {
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                      radius: 30,
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      // Always use _currentIndex instead of index to ensure correct video control
                      if (_currentIndex < _controllers.length) {
                        // Toggle play/pause for current video
                        if (_controllers[_currentIndex].value.isPlaying) {
                          _controllers[_currentIndex].pause();
                        } else {
                          _controllers[_currentIndex].play();
                        }
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controllers[index].value.size.width,
                          height: _controllers[index].value.size.height,
                          child: VideoPlayer(_controllers[index]),
                        ),
                      ),
                    ),
                  ),

                  // Play/Pause indicator
                  if (!reelState[index]['isPlaying'])
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Play video when tapping on play icon
                          _controllers[index].play();
                        },
                        child: SvgPicture.asset(
                          ResIcon.icPlayCircle2,
                          width: 80,
                          height: 80,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withValues(alpha: 0.8),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          // UI Overlay
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButtonCustom(
                          icon: SvgPicture.asset(
                            ResIcon.icBack,
                            colorFilter:
                                ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const IconButtonCustomStyle(
                            backgroundColor: Colors.black12,
                            borderRadius: 15,
                            padding: EdgeInsets.all(11.0),
                          ),
                        ),
                        Text(
                          "Gun",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButtonCustom(
                          icon: SvgPicture.asset(
                            ResIcon.icShare,
                            colorFilter:
                                ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const IconButtonCustomStyle(
                            backgroundColor: Colors.black12,
                            borderRadius: 15,
                            padding: EdgeInsets.all(11.0),
                          ),
                        )
                      ],
                    ),
                    ResSpacing.h16,
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButtonCustom(
                        icon: SvgPicture.asset(
                          ResIcon.icVolume,
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        onPressed: () {
                          // Toggle mute/unmute
                          if (_currentIndex < _controllers.length) {
                            double currentVolume =
                                _controllers[_currentIndex].value.volume;
                            _controllers[_currentIndex]
                                .setVolume(currentVolume > 0 ? 0.0 : 1.0);
                          }
                        },
                        style: const IconButtonCustomStyle(
                          backgroundColor: Colors.black12,
                          borderRadius: 15,
                          padding: EdgeInsets.all(11.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GradientButton(
        margin: EdgeInsets.symmetric(horizontal: 24.0),
        padding: EdgeInsets.all(12),
        style: GradientButtonStyle(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [ResColors.lightPinkPurple, ResColors.deepViolet],
          ),
        ),
        onTap: _useThisSound,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ResIcon.icNoteStar,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            Text(
              context.locale.use_this_sound,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
