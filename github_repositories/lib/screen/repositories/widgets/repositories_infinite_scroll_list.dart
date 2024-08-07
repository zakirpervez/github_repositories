import 'package:flutter/material.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/screen/repositories/widgets/callback/repository_item_tap.dart';
import 'package:github_repositories/screen/repositories/widgets/repository_card.dart';

import '../../../res/dimen_constant.dart';
import '../../../res/string_constant.dart';
import '../../app_widgets/custom_error.dart';

class RepositoriesInfiniteScrollListView extends StatefulWidget {
  final List<RepositoryData> repositoryList;
  final OnRepositoryItemTap onRepositoryItemTap;

  const RepositoriesInfiniteScrollListView(
      {super.key,
      required this.repositoryList,
      required this.onRepositoryItemTap});

  @override
  State<StatefulWidget> createState() {
    return _CircularListViewState();
  }
}

class _CircularListViewState extends State<RepositoriesInfiniteScrollListView> {
  late ScrollController _scrollController;
  late double itemWidth;

  _CircularListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController
          .jumpTo(_scrollController.position.maxScrollExtent / Dimen.magicTwo);
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent) {
      double jumpPosition =
          _scrollController.position.maxScrollExtent / Dimen.magicTwo;
      _scrollController.jumpTo(jumpPosition);
    } else if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      double jumpPosition =
          _scrollController.position.maxScrollExtent / Dimen.magicTwo;
      _scrollController.jumpTo(jumpPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.repositoryList.isEmpty
        ? CustomError(errorMessage: StringConstant.errorNoData)
        : SizedBox(
            width: Dimen.repoItemWidth,
            height: Dimen.repoItemHeight,
            child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.repositoryList.length * Dimen.magicThree,
                itemBuilder: (context, index) {
                  final itemIndex = index % widget.repositoryList.length;
                  final repository = widget.repositoryList[itemIndex];
                  return RepositoryCard(
                    index: index,
                    repository: repository,
                    onRepositoryItemTap: widget.onRepositoryItemTap,
                    displayCommitFlag: false,
                  );
                }),
          );
  }
}
