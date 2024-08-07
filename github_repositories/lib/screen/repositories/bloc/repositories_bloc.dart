import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repositories/database/app_database.dart';

import '../../../wrappers/data_wrapper.dart';
import '../actions/repositories_action.dart';
import '../state/repositories_state.dart';
import '../use_cases/fetch_repositories_use_case.dart';

class RepositoriesBloc extends Bloc<RepositoriesAction, RepositoriesState> {
  final FetchRepositoriesUseCase fetchRepositoriesUseCase;
  late DataWrapper<List<RepositoryData>> repositories;

  RepositoriesBloc({required this.fetchRepositoriesUseCase})
      : super(BlankRepositoriesState()) {
    on<FetchRepositoriesAction>(_onFetchRepositories);
    on<DisplayRepositoryDetailAction>(_displayRepositoryDetail);
  }

  void _onFetchRepositories(
      FetchRepositoriesAction event, Emitter<RepositoriesState> emit) async {
    emit(FetchRepositoriesState(
      repositories: DataWrapper.loading(),
    ));
    repositories = await fetchRepositoriesUseCase.call();
    emit(FetchRepositoriesState(
      repositories: repositories,
    ));
  }

  void _displayRepositoryDetail(
      DisplayRepositoryDetailAction event, Emitter<RepositoriesState> emit) {
    emit(DisplayRepositoryDetailState(repository: event.repository, index: event.index));
  }
}
