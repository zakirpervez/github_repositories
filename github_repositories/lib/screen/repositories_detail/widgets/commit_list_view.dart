import 'package:flutter/material.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/res/string_constant.dart';

import '../../../res/dimen_constant.dart';

class CommitListView extends StatelessWidget {
  final bool displayAll;
  final List<CommitData> commitList;

  const CommitListView(
      {super.key, required this.displayAll, required this.commitList});

  @override
  Widget build(BuildContext context) {
    List<CommitData> displayableCommits =
        displayAll ? commitList : commitList.take(Dimen.magicThree).toList();

    return commitList.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(Dimen.dimen_16),
            child: ListView.builder(
              itemCount: displayableCommits.length,
              itemBuilder: (context, index) {
                String titleText =
                    displayableCommits[index].message ?? StringConstant.empty;
                return ListTile(
                  title: Text(titleText),
                );
              },
            ),
          );
  }
}
