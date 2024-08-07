
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../res/dimen_constant.dart';

class AppAsyncImage extends StatelessWidget {
  final String _url;

  const AppAsyncImage(this._url, {super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: Dimen.asyncImageSize,
      height: Dimen.asyncImageSize,
      imageUrl: _url,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
