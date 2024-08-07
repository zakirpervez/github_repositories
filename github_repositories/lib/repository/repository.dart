import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/remote/entities/commits.dart';
import 'package:github_repositories/res/string_constant.dart';

import '../database/local_service.dart';
import '../remote/api_service.dart';
import '../remote/entities/repository.dart';
import '../wrappers/data_wrapper.dart';
import '../wrappers/isolate_service_wrapper.dart';

abstract class RepositoryService {
  // Repositories end point
  Future<DataWrapper<List<Repository>>> fetchRepositoriesFromApi();
  Future<void> saveOrUpdateAuditData(String endPoint, [String? nodeId]);
  Future<DataWrapper<AuditData>> getAuditData(String endPoint, [String? nodeId]);
  Future<void> saveRepositoriesToLocal(List<Repository> repositories);
  Future<DataWrapper<List<RepositoryData>>> fetchRepositoriesFromLocal();
  Future<void> deleteAllRepositories();

  Future<DataWrapper<List<Commits>>> fetchCommitFromApi(RepositoryData repository);
  Future<DataWrapper<List<CommitData>>> fetchCommitsFromLocal(String repositoryNodeId);
  Future<void> saveCommitsToLocal(List<Commits> commits, String repositoryName, String repositoryNodeId);
  Future<void> saveNewAuditForCommit(String endPoint, String repositoryNodeId);
  Future<List<AuditData>> getCommitRecordByApiEndPointNameAndNodeId(String apiEndPoint, String repositoryNodeId);
  Future<void> deleteCommitsByNodeId(String repositoryNodeId);

  Future<DataWrapper<List<Commits>?>> fetchIsolatedCommit(String repositoryName);
}

class RepositoryServiceImpl extends RepositoryService {
  final ApiService apiService;
  final LocalService localService;
  final IsolateServiceWrapper? isolateServiceWrapper;

  RepositoryServiceImpl({required this.apiService, required this.localService, this.isolateServiceWrapper});

  @override
  Future<DataWrapper<List<Repository>>> fetchRepositoriesFromApi() {
    return apiService.fetchRepositories();
  }

  @override
  Future<DataWrapper<AuditData>> getAuditData(String endPoint, [String? nodeId]) async{
    try {
      AuditData? auditData = await localService.getAuditRecord(endPoint, nodeId);
      return DataWrapper.success(auditData);
    } catch (e) {
      return DataWrapper.failure(e.toString());
    }
  }

  @override
  Future<void> saveOrUpdateAuditData(String endPoint, [String? nodeId]) async{
    AuditData? auditData = await localService.getAuditRecord(endPoint, nodeId);
    await localService.saveOrUpdateAuditData(AuditCompanion(
      id: const Value.absent(),
      nodeId: Value(nodeId),
      apiEndPointName: Value(endPoint),
      createdAt: Value(auditData == null ? DateTime.now() : auditData.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<void> saveRepositoriesToLocal(List<Repository> repositories) async {
    List<RepositoryCompanion> repositoryCompanions = repositories.map((repository) {
      return RepositoryCompanion(
        id: const Value.absent(),
        nodeId: Value(repository.nodeId),
        name: Value(repository.name),
        fullName: Value(repository.fullName),
        avatarUrl: Value(repository.owner?.avatarUrl ?? ""),
        description: Value(repository.description),
      );
    }).toList();
    await localService.saveRepositories(repositoryCompanions);
  }

  @override
  Future<DataWrapper<List<RepositoryData>>> fetchRepositoriesFromLocal() async {
    try {
      List<RepositoryData> repositories = await localService.getAllRepositories();
      return DataWrapper.success(repositories);
    } catch (e) {
      return DataWrapper.failure(e.toString());
    }
  }

  @override
  Future<void> deleteAllRepositories() async {
    try{
      await localService.deleteAllRepositories();
    }catch(e) {
      debugPrint("${StringConstant.errorUniversal} while deleting repositories");
    }
  }

  @override
  Future<DataWrapper<List<Commits>>> fetchCommitFromApi(RepositoryData repository) {
    return apiService.fetchCommits(repository.name!);
  }

  @override
  Future<DataWrapper<List<CommitData>>> fetchCommitsFromLocal(String repositoryNodeId) async {
    try {
      List<CommitData> commits = await localService.getCommitsByRepositoryNodeId(repositoryNodeId);
      return DataWrapper.success(commits);
    } catch (e) {
      return DataWrapper.failure(e.toString());
    }
  }

  @override
  Future<void> saveCommitsToLocal(List<Commits> commits, String repositoryName, String repositoryNodeId) async {
    List<CommitCompanion> commitCompanions = commits.map((commit) {
      return CommitCompanion(
        id: const Value.absent(),
        repositoryName: Value(repositoryName),
        repositoryNodeId: Value(repositoryNodeId),
        sha: Value(commit.sha),
        nodeId: Value(commit.nodeId),
        message: Value(commit.commit?.message ?? ""),
        url: Value(commit.url),
        commitDate: Value(DateTime.parse(commit.commit?.committer?.date ?? "")),
      );
    }).toList();
    await localService.saveCommits(commitCompanions);
  }

  @override
  Future<void> saveNewAuditForCommit(String endPoint, String repositoryNodeId) async {
    AuditData? auditData = await localService.getAuditRecord(endPoint, repositoryNodeId);
    await localService.saveAudit(AuditCompanion(
      id: const Value.absent(),
      nodeId: Value(repositoryNodeId),
      apiEndPointName: Value(endPoint),
      createdAt: Value(auditData == null ? DateTime.now() : auditData.createdAt),
      updatedAt: Value(DateTime.now()),
    ));
  }

  @override
  Future<List<AuditData>> getCommitRecordByApiEndPointNameAndNodeId(String apiEndPoint, String repositoryNodeId) {
    return localService.getCommitRecordByApiEndPointNameAndNodeId(apiEndPoint, repositoryNodeId);
  }

  @override
  Future<void> deleteCommitsByNodeId(String repositoryNodeId) {
    return localService.deleteCommitsByNodeId(repositoryNodeId);
  }

  @override
  Future<DataWrapper<List<Commits>?>> fetchIsolatedCommit(String repositoryName) async {
    if (isolateServiceWrapper == null) {
      return DataWrapper<List<Commits>>.failure(StringConstant.errorNullResponse);
    } else {
      final result = await isolateServiceWrapper?.fetchCommitsInIsolate(repoName: repositoryName);
      return result ?? DataWrapper<List<Commits>>.failure(StringConstant.errorNullResponse);
    }
  }
}
