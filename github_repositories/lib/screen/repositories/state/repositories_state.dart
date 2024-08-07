import 'package:github_repositories/base/state/base_state.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';

abstract class RepositoriesState implements BaseState {}

final class BlankRepositoriesState implements RepositoriesState {}

final class FetchRepositoriesState implements RepositoriesState {
  final DataWrapper<List<RepositoryData>> repositories;

  FetchRepositoriesState({required this.repositories});

  FetchRepositoriesState.initial()
      : repositories = DataWrapper<List<RepositoryData>>.initial();
}

final class DisplayRepositoryDetailState implements RepositoriesState {
  final int index;
  final RepositoryData repository;

  DisplayRepositoryDetailState({required this.index, required this.repository});
}

class BaseFetchIsolatedCommitState {}

final class FetchIsolatedCommitState implements BaseFetchIsolatedCommitState {
  final int index;
  final RepositoryData repository;
  final DataWrapper<List<CommitData>> commitDataWrapper;

  FetchIsolatedCommitState({required this.index, required this.repository, required this.commitDataWrapper});

  FetchIsolatedCommitState.initial()
      : index = -1,
        repository = const RepositoryData(id: -1, name: 'xyz', nodeId: 'fadfbhbf'),  // provide a default or dummy RepositoryData
        commitDataWrapper = DataWrapper<List<CommitData>>.initial();
}
