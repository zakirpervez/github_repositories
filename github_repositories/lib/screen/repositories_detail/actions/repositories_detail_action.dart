import 'package:github_repositories/database/app_database.dart';

abstract class RepositoryDetailAction {}

final class FetchCommitAction extends RepositoryDetailAction {
  final int index;
  final RepositoryData repository;

  FetchCommitAction({required this.index, required this.repository});
}

final class CloseItemTapAction extends RepositoryDetailAction {
  final RepositoryData repository;
  final List<CommitData> commits;

  CloseItemTapAction({required this.repository, required this.commits});
}
