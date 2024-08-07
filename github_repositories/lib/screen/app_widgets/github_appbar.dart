import 'package:flutter/material.dart';

class GithubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Color titleTextColor;
  final Color backgroundColor;

  const GithubAppBar({
    super.key,
    required this.titleText,
    this.titleTextColor = Colors.white, // Default text color
    this.backgroundColor = Colors.blue, // Default background color
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          titleText,
          style: TextStyle(color: titleTextColor),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
