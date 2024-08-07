import 'dart:convert';

import 'package:github_repositories/arguments_model/repository_detail_arguments.dart';
import 'package:github_repositories/base/arguments/base_arguments.dart';
import 'package:github_repositories/base/view_model/base_view_model.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/res/string_constant.dart';
import 'package:github_repositories/screen/repositories_detail/actions/repositories_detail_action.dart';
import 'package:github_repositories/screen/repositories_detail/bloc/repositories_detail_bloc.dart';
import 'package:github_repositories/screen/repositories_detail/use_cases/repository_detail_use_case.dart';

import '../model/closing_data_model.dart';

final class RepositoryDetailViewModel extends BaseViewModel {
  final RepositoryDetailBloc bloc;
  final FetchCommitUseCase useCase;
  final BaseArguments arguments;
  late RepositoryData repository;
  late int index;
  List<CommitData> commitList = [];

  RepositoryDetailViewModel(
      {required this.bloc, required this.useCase, required this.arguments}) {
    index = (arguments as RepositoryDetailsArguments).index;
    repository = (arguments as RepositoryDetailsArguments).repository;
  }

  String repositoryName() => repository.name ?? StringConstant.empty;

  int position() => index;

  List<CommitData> commits() => commitList;

  void fetchCommits() {
    bloc.add(FetchCommitAction(repository: repository, index: index));
  }

  void transferAndExit() {
    bloc.add(CloseItemTapAction(repository: repository, commits: commits()));
  }

  String prepareDataForTransfer() {
    try {
      return jsonEncode(
              ClosingDataModel(repository: repository, commits: commits())
                  .toJson())
          .toString();
    } catch (e) {
      return StringConstant.empty;
    }
  }
}
