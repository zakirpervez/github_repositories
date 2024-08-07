import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../res/dimen_constant.dart';

class ShadowedBannerImage extends StatelessWidget {
  final String imageUrl;

  const ShadowedBannerImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.grey, width: Dimen.magicOne.toDouble()),
        borderRadius: BorderRadius.circular(Dimen.dimen_12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(Dimen.magicHalf),
            spreadRadius: Dimen.magicFive.toDouble(),
            blurRadius: Dimen.magicSeven.toDouble(),
            offset:
                Offset(Dimen.magicZero.toDouble(), Dimen.magicThree.toDouble()),
          )
        ],
      ),
      child: CachedNetworkImage(
        width: Dimen.bannerImageWidth,
        height: Dimen.bannerImageHeight,
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}
