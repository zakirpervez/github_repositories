
import 'package:flutter/material.dart';
import 'package:github_repositories/screen/repositories_detail/widgets/callback/close_item_tap.dart';
import '../../../res/dimen_constant.dart';
import '../../app_widgets/bold_title_text.dart';

class CloseableHeader extends StatelessWidget {
  final String title;
  final OnCloseItemTap onCloseItemTap;

  const CloseableHeader({super.key,
        required this.title,
        required this.onCloseItemTap
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: Dimen.dimen_16),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                onCloseItemTap();
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: Dimen.dimen_32),
            child: BoldTitleText(titleText: title,),
          ),
        )
      ],
    );
  }
}
