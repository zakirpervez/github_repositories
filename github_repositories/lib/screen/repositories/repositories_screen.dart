import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/res/dimen_constant.dart';
import 'package:github_repositories/screen/app_widgets/custom_error.dart';
import 'package:github_repositories/screen/app_widgets/github_appbar.dart';
import 'package:github_repositories/screen/app_widgets/loader.dart';
import 'package:github_repositories/screen/repositories/bloc/repositories_bloc.dart';
import 'package:github_repositories/screen/repositories/state/repositories_state.dart';
import 'package:github_repositories/screen/repositories/view_model/repositories_view_model.dart';
import 'package:github_repositories/screen/repositories/widgets/callback/repository_item_tap.dart';
import 'package:github_repositories/screen/repositories/widgets/repositories_infinite_scroll_list.dart';
import 'package:github_repositories/screen/repositories/widgets/repositories_list_view.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';

import '../../res/string_constant.dart';
import '../app_widgets/bold_title_text.dart';

class RepositoriesScreen extends StatelessWidget {
  final RepositoriesViewModel viewModel;
  final OnRepositoryItemTap onRepositoryItemTap;

  const RepositoriesScreen(
      {super.key, required this.viewModel, required this.onRepositoryItemTap});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel.bloc,
      child: Scaffold(
        appBar: GithubAppBar(
          titleText: StringConstant.githubLabel,
        ),
        body: BlocBuilder<RepositoriesBloc, RepositoriesState>(
          builder: (context, state) {
            return _processStateAndBuildWidgets(context: context, state: state);
          },
        ),
      ),
    );
  }

  Widget _processStateAndBuildWidgets(
      {required BuildContext context, required RepositoriesState state}) {
    if (state is FetchRepositoriesState) {
      if (state.repositories.status == Status.loading ||
          state is BlankRepositoriesState) {
        return const Loader();
      } else if (state.repositories.status == Status.failure) {
        return CustomError(errorMessage: state.repositories.errorMessage!);
      } else if (state.repositories.status == Status.success) {
        return _buildRepositoryScreenContent(context: context, state: state);
      }
    } else if (state is DisplayRepositoryDetailState) {
      return _buildRepositoryScreenContent(context: context, state: state);
    }

    return CustomError(errorMessage: StringConstant.errorUniversal);
  }

  Widget _buildRepositoryScreenContent(
      {required BuildContext context, required RepositoriesState state}) {
    late List<RepositoryData> repositoryList = state is FetchRepositoriesState
        ? (state.repositories.data ?? [])
        : (viewModel.bloc.repositories.data ?? []);

    if (repositoryList.isEmpty) {
      return CustomError(errorMessage: StringConstant.errorNoData);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRepositoriesInfiniteScrollListView(
            infiniteScrollList: repositoryList.take(Dimen.magicFive).toList(),
            onRepositoryItemTap: onRepositoryItemTap),
        _buildGithubLabel(),
        _buildRepositoriesListView(
            repositoryList: repositoryList.skip(Dimen.magicFive).toList(),
            onRepositoryItemTap: onRepositoryItemTap)
      ],
    );
  }

  Widget _buildRepositoriesInfiniteScrollListView(
      {required List<RepositoryData> infiniteScrollList,
      required OnRepositoryItemTap onRepositoryItemTap}) {
    return SizedBox(
      width: double.infinity,
      height: Dimen.circularRepoItemHeight,
      child: Padding(
        padding: const EdgeInsets.all(Dimen.dimen_16),
        child: RepositoriesInfiniteScrollListView(
            repositoryList: infiniteScrollList,
            onRepositoryItemTap: onRepositoryItemTap),
      ),
    );
  }

  Widget _buildGithubLabel() {
    return SizedBox(
      height: Dimen.dimen_32, // Second section with fixed height
      child: Padding(
        padding:
            const EdgeInsets.only(left: Dimen.dimen_16, right: Dimen.dimen_16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoldTitleText(
              titleText: StringConstant.githubLabel,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRepositoriesListView(
      {required List<RepositoryData> repositoryList,
      required OnRepositoryItemTap onRepositoryItemTap}) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(Dimen.dimen_16),
          child: RepositoryListView(
            repositoryList: repositoryList,
            onRepositoryItemTap: onRepositoryItemTap,
          )),
    );
  }
}
