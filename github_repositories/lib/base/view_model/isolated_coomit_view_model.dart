import 'package:github_repositories/base/view_model/base_view_model.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/screen/repositories/actions/repositories_action.dart';
import 'package:github_repositories/screen/repositories/bloc/isolated_commit_bloc.dart';
import 'package:github_repositories/screen/repositories/use_cases/fetch_isolated_commit_use_case.dart';

class IsolatedCommitViewModel extends BaseViewModel {
  final IsolatedCommitBloc bloc;
  final FetchIsolatedCommitUseCase useCase;
  final dynamic arguments;

  late int index;
  late RepositoryData repository;

  IsolatedCommitViewModel({required this.bloc, required this.useCase, required this.arguments});

  void fetchCommitInIsolates() {
    bloc.add(FetchIsolatedCommitAction(index: index, repository: repository));
  }
}
