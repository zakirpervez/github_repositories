import 'package:flutter/cupertino.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/screen/repositories/widgets/callback/repository_item_tap.dart';
import 'package:github_repositories/screen/repositories/widgets/repository_card.dart';

import '../../../res/string_constant.dart';
import '../../app_widgets/custom_error.dart';

class RepositoryListView extends StatelessWidget {
  final List<RepositoryData> repositoryList;
  final OnRepositoryItemTap onRepositoryItemTap;

  const RepositoryListView(
      {super.key,
      required this.repositoryList,
      required this.onRepositoryItemTap});

  @override
  Widget build(BuildContext context) {
    return repositoryList.isEmpty
        ? CustomError(errorMessage: StringConstant.errorNoData)
        : ListView.builder(
            itemCount: repositoryList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              RepositoryData repository = repositoryList[index];
              return RepositoryCard(
                  index: index,
                  repository: repository,
                  onRepositoryItemTap: onRepositoryItemTap,
                  displayCommitFlag: true);
            });
  }
}
