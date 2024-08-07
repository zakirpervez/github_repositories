import 'package:flutter_test/flutter_test.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/screen/repositories/actions/repositories_action.dart';
import 'package:github_repositories/screen/repositories/bloc/repositories_bloc.dart';
import 'package:github_repositories/screen/repositories/state/repositories_state.dart';
import 'package:github_repositories/screen/repositories/use_cases/fetch_repositories_use_case.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../mock_data_helper.dart';
import 'repositories_bloc_test.mocks.dart';

@GenerateMocks([FetchRepositoriesUseCase])
void main() {
  late MockFetchRepositoriesUseCase mockFetchRepositoriesUseCase;
  late RepositoriesBloc repositoriesBloc;

  late List<RepositoryData> repositoryList;
  late DataWrapper<List<RepositoryData>> repositorySuccessDataWrapper;

  setUp(() {
    mockFetchRepositoriesUseCase = MockFetchRepositoriesUseCase();
    repositoriesBloc = RepositoriesBloc(
        fetchRepositoriesUseCase: mockFetchRepositoriesUseCase);

    repositoryList = MockDataHelper.getMockRepositoryDataList();
    repositorySuccessDataWrapper = DataWrapper.success(repositoryList);
    provideDummy(repositorySuccessDataWrapper);
  });
  tearDown(() {
    repositoriesBloc.close();
  });

  group('RepositoriesBloc', () {
    test('initial state is BlankRepositoriesState', () {
      expect(repositoriesBloc.state, isA<BlankRepositoriesState>());
    });
    test('RepositoriesBloc is emitting state', () async {
      final testRepositories = MockDataHelper.getMockRepositoryDataList();
      final DataWrapper<List<RepositoryData>> repositoriesDataWrapper = DataWrapper.success(testRepositories);
      final DataWrapper<List<RepositoryData>> repositoriesLoadingDataWrapper = DataWrapper.loading();

      provideDummy(repositoriesDataWrapper);

      when(mockFetchRepositoriesUseCase.call()).thenAnswer((_) async => repositoriesDataWrapper);
      
      repositoriesBloc.stream.listen((event) {
        expect(event, isA<FetchRepositoriesState>());
      });

      repositoriesBloc.add(FetchRepositoriesAction());
    });
  });
}
