import 'package:flutter/material.dart';
import 'package:github_repositories/res/color_constant.dart';

import '../../res/dimen_constant.dart';

class CustomError extends StatelessWidget {
  final String errorMessage;
  final EdgeInsets padding;
  final TextStyle textStyle;

  const CustomError(
      {super.key,
      required this.errorMessage,
      this.padding = const EdgeInsets.all(Dimen.dimen_16),
      this.textStyle = const TextStyle(color: ColorConstant.redAccent)});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Text(
          errorMessage,
          style: textStyle,
        ),
      ),
    );
  }
}
