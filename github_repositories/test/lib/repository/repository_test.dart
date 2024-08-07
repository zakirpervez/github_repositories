import 'package:flutter_test/flutter_test.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/database/local_service.dart';
import 'package:github_repositories/remote/api_service.dart';
import 'package:github_repositories/remote/config.dart';
import 'package:github_repositories/remote/entities/commits.dart';
import 'package:github_repositories/remote/entities/repository.dart';
import 'package:github_repositories/repository/repository.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';
import 'package:github_repositories/wrappers/isolate_service_wrapper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data_helper.dart';
import 'repository_test.mocks.dart';

@GenerateMocks([ApiService, LocalService, IsolateServiceWrapper])
void main() {
  late MockApiService mockApiService;
  late MockLocalService mockLocalService;
  late MockIsolateServiceWrapper mockIsolateServiceWrapper;
  late RepositoryServiceImpl repositoryService;

  setUp(() {
    mockApiService = MockApiService();
    mockLocalService = MockLocalService();
    mockIsolateServiceWrapper = MockIsolateServiceWrapper();
    repositoryService = RepositoryServiceImpl(
      apiService: mockApiService,
      localService: mockLocalService,
      isolateServiceWrapper: mockIsolateServiceWrapper,
    );
  });

  group('RepositoryServiceImpl Tests', () {
    group("Repositories", () {
      group('fetchRepositoriesFromApi', () {
        test('should return success DataWrapper when fetch is successful', () async {
          final List<Repository> repositoryList = MockDataHelper.getRepositoryList();
          final DataWrapper<List<Repository>> repositoriesDataWrapper = DataWrapper<List<Repository>>.success(repositoryList);
          provideDummy(repositoriesDataWrapper);
          when(mockApiService.fetchRepositories())
              .thenAnswer((_) async => repositoriesDataWrapper);

          final result = await repositoryService.fetchRepositoriesFromApi();

          expect(result.status, repositoriesDataWrapper.status);
          expect(result.data?.length, repositoryList.length);
        });

        test('should return failure DataWrapper when fetch fails', () async {
          final DataWrapper<List<Repository>> repositoriesDataWrapper = DataWrapper.failure('Error');
          provideDummy(repositoriesDataWrapper);
          when(mockApiService.fetchRepositories())
              .thenAnswer((_) async => repositoriesDataWrapper);

          final result = await repositoryService.fetchRepositoriesFromApi();

          expect(result.status, DataWrapper.failure('Error').status);
          expect(result.errorMessage, 'Error');
        });
      });
      group('getAuditData', () {
        test('should return success DataWrapper when audit data is found', () async {
          final auditData = MockDataHelper.getAuditData();
          when(mockLocalService.getAuditRecord(Config.repositories, 'node1'))
              .thenAnswer((_) async => auditData);

          final result = await repositoryService.getAuditData(Config.repositories, 'node1');

          expect(result.status, DataWrapper.success(auditData).status);
          expect(result.data, auditData);
        });

        test('should return failure DataWrapper when audit data is not found', () async {
          when(mockLocalService.getAuditRecord(Config.repositories, 'node1'))
              .thenThrow(Exception('Error'));

          final result = await repositoryService.getAuditData(Config.repositories, 'node1');

          expect(result.status, DataWrapper.failure('Exception: Error').status);
          expect(result.errorMessage, 'Exception: Error');
        });
      });
      group('saveOrUpdateAuditData', () {
        test('should call saveOrUpdateAuditData on localService', () async {
          final auditData = MockDataHelper.getAuditData();
          provideDummy(auditData);
          when(mockLocalService.getAuditRecord(Config.repositories, "node1"))
              .thenAnswer((_) async => auditData);
          when(mockLocalService.saveOrUpdateAuditData(any))
              .thenAnswer((_) async => Future.value(1));

          await repositoryService.saveOrUpdateAuditData(Config.repositories, 'node1');

          verify(mockLocalService.saveOrUpdateAuditData(captureAny)).called(1);
        });
      });
      group('saveRepositoriesToLocal', () {
        test('should call saveRepositories on localService', () async {
          final repositoryList = MockDataHelper.getRepositoryList();
          await repositoryService.saveRepositoriesToLocal(repositoryList);
          verify(mockLocalService.saveRepositories(any)).called(1);
        });
      });
      group('fetchRepositoriesFromLocal', () {
        test('should return success DataWrapper when repositories are found', () async {
          final List<RepositoryData> repositoryDataList = MockDataHelper.getMockRepositoryDataList();
          when(mockLocalService.getAllRepositories())
              .thenAnswer((_) async => repositoryDataList);
          final result = await repositoryService.fetchRepositoriesFromLocal();

          expect(result.status, DataWrapper.success(repositoryDataList).status);
          expect(result.data, repositoryDataList);
        });

        test('should return failure DataWrapper when fetching repositories fails', () async {
          when(mockLocalService.getAllRepositories()).thenThrow(Exception('Error'));

          final result = await repositoryService.fetchRepositoriesFromLocal();

          expect(result.status, DataWrapper.failure('Exception: Error').status);
          expect(result.errorMessage, 'Exception: Error');
        });
      });
      group('deleteAllRepositories', () {
        test('should call deleteAllRepositories on localService', () async {
          await repositoryService.deleteAllRepositories();
          verify(mockLocalService.deleteAllRepositories()).called(1);
        });
      });
    });

    group("Commits", () {
      group('fetchCommitFromApi', () {
        test('should return success DataWrapper when fetch is successful', () async {
          final repositoryData = MockDataHelper.getMockRepositoryDataList().first;
          final commitList = MockDataHelper.getCommitList();
          final DataWrapper<List<Commits>> commitsDataWrapper = DataWrapper<List<Commits>>.success(commitList);
          provideDummy(commitsDataWrapper);
          when(mockApiService.fetchCommits(repositoryData.name))
              .thenAnswer((_) async => commitsDataWrapper);

          final result = await repositoryService.fetchCommitFromApi(repositoryData);
          expect(result.status, commitsDataWrapper.status);
          expect(result.data?.length, commitList?.length);
        });

        test('should return failure DataWrapper when fetch fails', () async {
          final repositoryData = MockDataHelper.getMockRepositoryDataList().first;
          final DataWrapper<List<Commits>> commitsDataWrapper = DataWrapper<List<Commits>>.failure("Error");
          provideDummy(commitsDataWrapper);
          when(mockApiService.fetchCommits(repositoryData.name))
              .thenAnswer((_) async => commitsDataWrapper);

          final result = await repositoryService.fetchCommitFromApi(repositoryData);

          expect(result.status, commitsDataWrapper.status);
          expect(result.errorMessage, 'Error');
        });
      });
      group('fetchCommitsFromLocal', () {
        test('should return success DataWrapper when commits are found', () async {
          final commitDataList = MockDataHelper.getCommitDataList();
          when(mockLocalService.getCommitsByRepositoryNodeId('node1'))
              .thenAnswer((_) async => commitDataList);

          final result = await repositoryService.fetchCommitsFromLocal('node1');

          expect(result.status, DataWrapper.success(commitDataList).status);
          expect(result.data, commitDataList);
        });

        test('should return failure DataWrapper when fetching commits fails', () async {
          when(mockLocalService.getCommitsByRepositoryNodeId('node1'))
              .thenThrow(Exception('Error'));

          final result = await repositoryService.fetchCommitsFromLocal('node1');

          expect(result.status, DataWrapper.failure('Exception: Error').status);
          expect(result.errorMessage, 'Exception: Error');
        });
      });
      group('saveCommitsToLocal', () {
        test('should call saveCommits on localService', () async {
          final commits = MockDataHelper.getCommitList()!;
          await repositoryService.saveCommitsToLocal(commits, 'repo1', 'node1');
          verify(mockLocalService.saveCommits(any)).called(1);
        });
      });
      group('saveNewAuditForCommit', () {
        test('should call saveAudit on localService', () async {
          final auditData = MockDataHelper.getAuditData();
          provideDummy(auditData);
          when(mockLocalService.getAuditRecord(Config.commits, "node1"))
              .thenAnswer((_) async => auditData);
          when(mockLocalService.saveAudit(any))
              .thenAnswer((_) async => Future.value(1));
          await repositoryService.saveNewAuditForCommit(Config.commits, 'node1');
          verify(mockLocalService.saveAudit(any)).called(1);
        });
      });
      group('getCommitRecordByApiEndPointNameAndNodeId', () {
        test('should return a list of AuditData', () async {
          final auditDataList = [
            MockDataHelper.getAuditDataForCommits(),
          ];
          when(mockLocalService.getCommitRecordByApiEndPointNameAndNodeId('endpoint1', 'node1'))
              .thenAnswer((_) async => auditDataList);

          final result = await repositoryService.getCommitRecordByApiEndPointNameAndNodeId('endpoint1', 'node1');

          expect(result, auditDataList);
        });
      });
      group('deleteCommitsByNodeId', () {
        test('should call deleteCommitsByNodeId on localService', () async {
          await repositoryService.deleteCommitsByNodeId('node1');
          verify(mockLocalService.deleteCommitsByNodeId('node1')).called(1);
        });
      });
    });
  });
}
