import 'package:github_repositories/base/state/base_state.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';

abstract class RepositoryDetailState implements BaseState {}

final class BlankRepositoryDetailState implements RepositoryDetailState {}

final class FetchCommitState implements RepositoryDetailState {
  final DataWrapper<List<CommitData>> commits;

  FetchCommitState({required this.commits});

  FetchCommitState.initial() : commits = DataWrapper<List<CommitData>>.initial();
}

class CloseItemTapState implements RepositoryDetailState {
  final RepositoryData repository;
  final List<CommitData> commits;

  CloseItemTapState({required this.repository, required this.commits});
}
