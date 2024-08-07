import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repositories/screen/repositories/actions/repositories_action.dart';
import 'package:github_repositories/screen/repositories/state/repositories_state.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';

import '../use_cases/fetch_isolated_commit_use_case.dart';

class IsolatedCommitBloc extends Bloc<RepositoriesAction, BaseFetchIsolatedCommitState> {
  final FetchIsolatedCommitUseCase fetchIsolatedCommitUseCase;

  IsolatedCommitBloc({required this.fetchIsolatedCommitUseCase})
      : super(BaseFetchIsolatedCommitState()) {
    on<FetchIsolatedCommitAction>(_fetchCommitInIsolates);
  }

  void _fetchCommitInIsolates(
      FetchIsolatedCommitAction event, Emitter<BaseFetchIsolatedCommitState> emit) async {
    emit(FetchIsolatedCommitState(
        index: event.index,
        repository: event.repository,
        commitDataWrapper: DataWrapper.loading()));
    final commitDataWrapper = await fetchIsolatedCommitUseCase.call(
        index: event.index, repository: event.repository);
    emit(FetchIsolatedCommitState(
        index: event.index,
        repository: event.repository,
        commitDataWrapper: commitDataWrapper));
  }
}
