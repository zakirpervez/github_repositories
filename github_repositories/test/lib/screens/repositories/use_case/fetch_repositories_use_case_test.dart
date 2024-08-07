import 'package:flutter_test/flutter_test.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/remote/config.dart';
import 'package:github_repositories/remote/entities/repository.dart';
import 'package:github_repositories/repository/repository.dart';
import 'package:github_repositories/res/dimen_constant.dart';
import 'package:github_repositories/screen/repositories/use_cases/fetch_repositories_use_case.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../mock_data_helper.dart';
import 'fetch_repositories_use_case_test.mocks.dart';

@GenerateMocks([RepositoryService])
void main() {
  late MockRepositoryService mockRepositoryService;
  late FetchRepositoriesUseCase fetchRepositoriesUseCase;

  setUp(() {
    mockRepositoryService = MockRepositoryService();
    fetchRepositoriesUseCase =
        FetchRepositoriesUseCase(repository: mockRepositoryService);
  });

  group('FetchRepositoriesUseCase Tests', () {
    test('should return success DataWrapper when fetch is successful',
        () async {
      final repositoryList = MockDataHelper.getRepositoryList();
      final repositoryDataList = MockDataHelper.getMockRepositoryDataList();

      DataWrapper<AuditData> auditDataWrapper = DataWrapper.success(null);
      DataWrapper<List<Repository>> repositoryDataWrapper =
          DataWrapper.success(repositoryList);
      DataWrapper<List<RepositoryData>> localRepositoryDataWrapper =
          DataWrapper.success(repositoryDataList);

      provideDummy(auditDataWrapper);
      provideDummy(repositoryDataWrapper);
      provideDummy(localRepositoryDataWrapper);

      when(mockRepositoryService.getAuditData(Config.repositories))
          .thenAnswer((_) async => auditDataWrapper); // Allow API call
      when(mockRepositoryService.fetchRepositoriesFromApi())
          .thenAnswer((_) async => repositoryDataWrapper);
      when(mockRepositoryService.fetchRepositoriesFromLocal())
          .thenAnswer((_) async => localRepositoryDataWrapper);
      when(mockRepositoryService.saveOrUpdateAuditData(Config.repositories))
          .thenAnswer((_) async {});
      when(mockRepositoryService.deleteAllRepositories())
          .thenAnswer((_) async {});
      when(mockRepositoryService.saveRepositoriesToLocal(any))
          .thenAnswer((_) async {});

      final result = await fetchRepositoriesUseCase.call();

      expect(result.status, DataWrapper.success(repositoryDataList).status);
      expect(result.data?.length, repositoryDataList.length);
      verify(mockRepositoryService.getAuditData(Config.repositories)).called(1);
      verify(mockRepositoryService.fetchRepositoriesFromApi()).called(1);
      verify(mockRepositoryService.saveOrUpdateAuditData(Config.repositories))
          .called(1);
      verify(mockRepositoryService.deleteAllRepositories()).called(1);
      verify(mockRepositoryService.saveRepositoriesToLocal(repositoryList))
          .called(1);
      verify(mockRepositoryService.fetchRepositoriesFromLocal()).called(1);
    });
    test(
        'should not make API call if audit data timestamp is less than 12 hours old',
        () async {
      final repositoryDataList = MockDataHelper.getMockRepositoryDataList();
      final auditData = AuditData(
        id: 1,
        apiEndPointName: Config.repositories,
        createdAt:
            DateTime.now().subtract(const Duration(hours: Dimen.magicSeven)),
        updatedAt:
            DateTime.now().subtract(const Duration(hours: Dimen.magicSeven)),
      );

      DataWrapper<AuditData> auditDataWrapper = DataWrapper.success(auditData);
      DataWrapper<List<RepositoryData>> localRepositoryDataWrapper =
          DataWrapper.success(repositoryDataList);

      provideDummy(auditDataWrapper);
      provideDummy(localRepositoryDataWrapper);

      when(mockRepositoryService.getAuditData(Config.repositories))
          .thenAnswer((_) async => DataWrapper.success(auditData));
      when(mockRepositoryService.fetchRepositoriesFromLocal()).thenAnswer(
          (_) async => localRepositoryDataWrapper); // Return empty local data

      final result = await fetchRepositoriesUseCase.call();

      expect(result.status, DataWrapper.success([]).status);
      expect(result.data?.isNotEmpty, true);
      verify(mockRepositoryService.getAuditData(Config.repositories)).called(1);
    });
  });
}
