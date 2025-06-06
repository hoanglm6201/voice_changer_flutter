import 'package:flutter/material.dart';
import 'package:voice_changer_flutter/core/res/images.dart';
import 'package:voice_changer_flutter/data/model/prank_sound_model.dart';

class PrankSoundItem extends StatelessWidget {
  final PrankSound prankSoundModel;
  final bool? isShadow;
  const PrankSoundItem({super.key, required this.prankSoundModel, this.isShadow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          isShadow == true ? BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 3, offset: Offset(0, 3))
              :BoxShadow()
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100),topRight: Radius.circular(100)),
                image: DecorationImage(image: AssetImage(prankSoundModel.image), fit: BoxFit.cover)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              prankSoundModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
