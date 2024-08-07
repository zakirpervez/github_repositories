

import 'package:flutter/material.dart';

import '../../res/color_constant.dart';
import '../../res/dimen_constant.dart';

class BoldTitleText extends StatelessWidget {
  final String titleText;

  const BoldTitleText({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Title(
        color: ColorConstant.shadyBlackColor,
        child: Text(
          titleText,
          maxLines: Dimen.magicOne,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: ColorConstant.shadyBlackColor),
        ));
  }
}
