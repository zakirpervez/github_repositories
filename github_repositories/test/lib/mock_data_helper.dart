import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/remote/config.dart';
import 'package:github_repositories/remote/entities/commit.dart';
import 'package:github_repositories/remote/entities/commit_author.dart';
import 'package:github_repositories/remote/entities/commits.dart';
import 'package:github_repositories/remote/entities/owner.dart';
import 'package:github_repositories/remote/entities/repository.dart';

class MockDataHelper {
  static List<RepositoryData> getMockRepositoryDataList() {
    var repo1 = const RepositoryData(
        id: 1,
        nodeId: "1",
        fullName: "my/repo1",
        avatarUrl: "https://avatar1.com",
        description: "avatar1 description",
        name: "repo1");
    var repo2 = const RepositoryData(
        id: 1,
        nodeId: "2",
        fullName: "my/repo2",
        avatarUrl: "https://avatar2.com",
        description: "avatar2 description",
        name: "repo2");
    var repo3 = const RepositoryData(
        id: 1,
        nodeId: "3",
        fullName: "my/repo3",
        avatarUrl: "https://avatar3.com",
        description: "avatar3 description",
        name: "repo3");
    return [repo1, repo2, repo3];
  }

  static List<Repository> getRepositoryList() {
    var repo1 = Repository(
        id: 1,
        nodeId: "1",
        name: "Repo1",
        fullName: "my/Repo1",
        owner: Owner(avatarUrl: "https://Repo1Avatar"));
    var repo2 = Repository(
        id: 2,
        nodeId: "2",
        name: "Repo2",
        fullName: "my/Repo2",
        owner: Owner(avatarUrl: "https://Repo2Avatar"));
    var repo3 = Repository(
        id: 3,
        nodeId: "3",
        name: "Repo3",
        fullName: "my/Repo3",
        owner: Owner(avatarUrl: "https://Repo3Avatar"));

    return [repo1, repo2, repo3];
  }

  static List<Commits>? getCommitList() {
    final commit1 = Commits(
        nodeId: "1",
        sha: "fasdbhubgokadgoadg",
        url: "https://test.com",
        htmlUrl: "https://test.com",
        commit: Commit(committer: CommitAuthor(date: DateTime.now().toString(), name: 'xyz', email: 'xyz@gmail.com')),
        commentsUrl: "https://test.com");
    final commit2 = Commits(
        nodeId: "2",
        sha: "kgviyghiebijfajbfb",
        url: "https://test.com",
        htmlUrl: "https://test.com",
        commit: Commit(committer: CommitAuthor(date: DateTime.now().toString(), name: 'xyz', email: 'xyz@gmail.com')),
        commentsUrl: "https://test.com");
    final commit3 = Commits(
        nodeId: "3",
        sha: "errtoivadnfadkfdfe",
        url: "https://test.com",
        htmlUrl: "https://test.com",
        commit: Commit(committer: CommitAuthor(date: DateTime.now().toString(), name: 'xyz', email: 'xyz@gmail.com')),
        commentsUrl: "https://test.com");
    return [commit1, commit2, commit3];
  }

  static AuditData getAuditData() {
    return AuditData(
        id: 1,
        nodeId: 'node1',
        apiEndPointName: Config.repositories,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
  }

  static AuditData getAuditDataForCommits() {
    return AuditData(
        id: 1,
        nodeId: 'node1',
        apiEndPointName: Config.commits,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)));
  }

  static List<CommitData> getCommitDataList() {
    CommitData commitTableData1 = CommitData(
        id: 1,
        url: "https://test.com",
        sha: "bigygighifghsfhgidfg",
        nodeId: "nodeId1",
        message: "test message",
        commitDate: DateTime.now(),
        repositoryName: "myrepo",
        repositoryNodeId: "ogbugbhygrfasdfasf");
    CommitData commitTableData2 = CommitData(
        id: 2,
        url: "https://test.com",
        sha: "bigygighifghsfhgidfg",
        nodeId: "nodeId1",
        message: "test message",
        commitDate: DateTime.now(),
        repositoryName: "myrepo",
        repositoryNodeId: "ogbugbhygrfasdfasf");
    CommitData commitTableData3 = CommitData(
        id: 3,
        url: "https://test.com",
        sha: "bigygighifghsfhgidfg",
        nodeId: "nodeId1",
        message: "test message",
        commitDate: DateTime.now(),
        repositoryName: "myrepo",
        repositoryNodeId: "ogbugbhygrfasdfasf");
    return [commitTableData1, commitTableData2, commitTableData3];
  }
}
