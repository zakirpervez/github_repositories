import 'package:flutter/material.dart';

class SemiBoldTitleText extends StatelessWidget {
  final String titleText;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextOverflow overflow;

  const SemiBoldTitleText({
    super.key,
    required this.titleText,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
    required this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Title(
        color: color,
        child: Text(
          titleText,
          overflow: overflow,
          style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
        ));
  }
}
