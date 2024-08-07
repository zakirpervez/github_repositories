import 'package:github_repositories/base/base_use_case/base_use_case.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/remote/config.dart';
import 'package:github_repositories/remote/entities/commits.dart';
import 'package:github_repositories/repository/repository.dart';

import '../../../wrappers/data_wrapper.dart';

abstract class RepositoryDetailUseCase extends CommitsBaseUseCase {}

final class FetchCommitUseCase extends RepositoryDetailUseCase {
  final RepositoryService repositoryService;

  FetchCommitUseCase({required this.repositoryService});

  Future<DataWrapper<List<CommitData>>> call(
      {required RepositoryData repository}) async {
    List<AuditData> auditDataList =
        await repositoryService.getCommitRecordByApiEndPointNameAndNodeId(
            Config.commits, repository.nodeId!);
    AuditData auditData = getCommitsAudit(auditDataList, repository.nodeId!);

    bool isApiCallAllowed =
        auditDataList.isEmpty || checkIfAtLeast12HoursApart(auditData);

    if (isApiCallAllowed) {
      final commitResponseWrapper =
          await repositoryService.fetchCommitFromApi(repository);
      if (commitResponseWrapper.status == Status.success) {
        List<Commits> commitList = commitResponseWrapper.data ?? [];
        repositoryService.deleteCommitsByNodeId(repository.nodeId!);
        repositoryService.saveNewAuditForCommit(
            Config.commits, repository.nodeId!);
        repositoryService.saveCommitsToLocal(
            commitList, repository.name!, repository.nodeId!);
      }
    }

    return repositoryService.fetchCommitsFromLocal(repository.nodeId!);
  }
}
