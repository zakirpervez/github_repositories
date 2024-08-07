import 'package:flutter/material.dart';
class HorizontalLine extends StatelessWidget {
  final Color lineColor;
  final double lineIndent;
  final double lineEndIndent;

  const HorizontalLine(
      {super.key,
      required this.lineColor,
      required this.lineIndent,
      required this.lineEndIndent});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: lineColor,
      indent: lineIndent,
      endIndent: lineEndIndent,
    );
  }
}
