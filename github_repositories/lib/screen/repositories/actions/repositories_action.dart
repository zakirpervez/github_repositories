import 'package:github_repositories/database/app_database.dart';

abstract class RepositoriesAction {}

final class FetchRepositoriesAction extends RepositoriesAction {}

final class FetchIsolatedCommitAction extends RepositoriesAction {
  final int index;
  final RepositoryData repository;

  FetchIsolatedCommitAction({required this.index, required this.repository});
}

final class DisplayRepositoryDetailAction extends RepositoriesAction {
  final int index;
  final RepositoryData repository;

  DisplayRepositoryDetailAction({required this.index, required this.repository});
}
