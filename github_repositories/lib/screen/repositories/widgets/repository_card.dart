import 'package:flutter/material.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/res/string_constant.dart';
import 'package:github_repositories/screen/repositories/widgets/callback/repository_item_tap.dart';
import 'package:github_repositories/screen/repositories/widgets/isolated_commit_list_view.dart';

import '../../../res/color_constant.dart';
import '../../../res/dimen_constant.dart';
import '../../app_widgets/app_async_image.dart';
import '../../app_widgets/bold_title_text.dart';

class RepositoryCard extends StatelessWidget {
  final int index;
  final RepositoryData repository;
  final OnRepositoryItemTap onRepositoryItemTap;
  final bool displayCommitFlag;

  const RepositoryCard({
      super.key,
      required this.index,
      required this.repository,
      required this.onRepositoryItemTap,
      required this.displayCommitFlag
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onRepositoryItemTap(index: index, repository: repository);
      },
      child: Card(
        color: ColorConstant.darkGreyColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimen.dimen_12)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: Dimen.dimen_16, right: Dimen.dimen_16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimen.dimen_12),
            child: Column(
              children: [
                SizedBox(
                  width: Dimen.repoItemWidth,
                  height: Dimen.repoItemHeight,
                  child: Row(
                    children: [
                      AppAsyncImage(repository.avatarUrl ?? StringConstant.empty),
                      const SizedBox(width: Dimen.dimen_8),
                      Flexible(
                          child: BoldTitleText(
                        titleText: repository.name!,
                      )),
                    ],
                  ),
                ),
                IsolatedCommitListView(
                    index: index,
                    repository: repository,
                    displayCommitFlag: displayCommitFlag
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
