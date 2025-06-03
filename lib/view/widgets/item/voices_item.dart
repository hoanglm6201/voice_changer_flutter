import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/data/model/voice_model.dart';

class VoicesItem extends StatelessWidget {
  final VoiceModel voiceModel;
  const VoicesItem({super.key, required this.voiceModel});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.only(bottom: 2, right: 2, left:  2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(voiceModel.image), fit: BoxFit.cover)
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBlur(screenSize, voiceModel.name),
          ),
        ],
      ),
    );
  }
  Widget _buildBlur(double screenSize, String name) {
    return SizedBox(
      width: screenSize,
      height: screenSize * 0.067,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withValues(alpha: 0.2),
            alignment: Alignment.center,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
