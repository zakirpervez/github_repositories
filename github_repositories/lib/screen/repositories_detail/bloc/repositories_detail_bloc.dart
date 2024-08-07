import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';

import '../actions/repositories_detail_action.dart';
import '../state/repository_detail_state.dart';
import '../use_cases/repository_detail_use_case.dart';

final class RepositoryDetailBloc extends Bloc<RepositoryDetailAction, RepositoryDetailState> {
  final FetchCommitUseCase fetchCommitUseCase;

  RepositoryDetailBloc({required this.fetchCommitUseCase}): super(BlankRepositoryDetailState()) {
      on<FetchCommitAction>(_fetchCommits);
      on<CloseItemTapAction>(_transferAndExit);
  }

  void _fetchCommits(FetchCommitAction action, Emitter<RepositoryDetailState> emit) async {
    emit(FetchCommitState(commits: DataWrapper.loading()));
    final commits = await fetchCommitUseCase.call(repository: action.repository);
    emit(FetchCommitState(commits: commits));
  }

  void _transferAndExit(CloseItemTapAction action, Emitter<RepositoryDetailState> emit) {
    emit(CloseItemTapState(repository: action.repository, commits: action.commits));
  }
}
