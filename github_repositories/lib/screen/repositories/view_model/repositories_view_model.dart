import 'package:github_repositories/base/view_model/base_view_model.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/screen/repositories/actions/repositories_action.dart';
import 'package:github_repositories/screen/repositories/bloc/repositories_bloc.dart';
import 'package:github_repositories/screen/repositories/use_cases/fetch_repositories_use_case.dart';

final class RepositoriesViewModel extends BaseViewModel {
  final RepositoriesBloc bloc;
  final FetchRepositoriesUseCase useCase;
  final dynamic inputData;

  RepositoriesViewModel(
      {required this.bloc, required this.useCase, required this.inputData});

  void fetchRepositories(RepositoriesAction action) {
    bloc.add(action);
  }

  void displayBottomSheet(
      {required int index, required RepositoryData repository}) {
    bloc.add(
        DisplayRepositoryDetailAction(index: index, repository: repository));
  }
}
