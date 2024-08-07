import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repositories/remote/api_interceptor.dart';
import 'package:github_repositories/remote/api_service.dart';
import 'package:github_repositories/remote/config.dart';
import 'package:github_repositories/res/string_constant.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_data_helper.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([Dio, ApiInterceptor])
void main() {
  late MockDio mockDio;
  late MockApiInterceptor mockApiInterceptor;
  late ApiServiceImpl apiService;

  setUp(() {
    mockDio = MockDio();
    mockApiInterceptor = MockApiInterceptor();
    when(mockDio.options)
        .thenReturn(BaseOptions(baseUrl: Config.baseUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }));
    Interceptors interceptors = Interceptors();
    interceptors.add(mockApiInterceptor);
    when(mockDio.interceptors).thenReturn(interceptors);
    apiService = ApiServiceImpl();
    apiService.dio = mockDio;
    apiService.interceptor = mockApiInterceptor;
  });

  group("ApiService fetchRepositories", () {
    test("test FetchRepositories success scenario", () async {
      final repositoryList = MockDataHelper.getRepositoryList();
      final response = Response(
        data: repositoryList.map((repo) => repo.toJson()).toList(),
        statusCode: 200,
        requestOptions: RequestOptions(path: Config.repositories),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);
      final result = await apiService.fetchRepositories();

      expect(result.status, DataWrapper.success(repositoryList).status);
      expect(result.errorMessage, isNull);
      expect(result.data, isNotNull);
      expect(result.data?.length, equals(repositoryList.length));
    });

    test('test FetchRepositories failure scenario', () async {
      when(mockDio.get(any))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      final result = await apiService.fetchRepositories();

      expect(result.status,
          DataWrapper.failure(StringConstant.errorUniversal).status);
      expect(result.data, isNull);
      expect(result.errorMessage, isNotNull);
    });

    test('test FetchRepositories null data scenario', () async {
      final response = Response(
        data: null,
        statusCode: 200,
        requestOptions: RequestOptions(path: Config.repositories),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);
      final result = await apiService.fetchRepositories();

      expect(result.status,
          DataWrapper.failure(StringConstant.errorNullResponse).status);
      expect(result.data, isNull);
      expect(result.errorMessage, StringConstant.errorNullResponse);
    });

    test('test FetchRepositories generic error scenario', () async {
      when(mockDio.get(any)).thenThrow(Error());
      final result = await apiService.fetchRepositories();

      expect(result.status, DataWrapper.failure('ApiService : Error').status);
      expect(result.data, isNull);
      expect(result.errorMessage, isNotNull);
    });
  });

  group("ApiService fetchCommits", () {
    test("test FetchCommits success scenario", () async {
      final commits = MockDataHelper.getCommitList()!;
      final response = Response(
        data: commits.map((commit) => commit.toJson()).toList(),
        statusCode: 200,
        requestOptions: RequestOptions(path: Config.commits),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);
      final result = await apiService.fetchCommits("test");

      expect(result.status, DataWrapper.success(commits).status);
      expect(result.errorMessage, isNull);
      expect(result.data, isNotNull);
      expect(result.data?.length, equals(commits.length));
    });

    test('test FetchCommits failure scenario', () async {
      when(mockDio.get(any))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      final result = await apiService.fetchCommits("test");

      expect(result.status,
          DataWrapper.failure(StringConstant.errorUniversal).status);
      expect(result.data, isNull);
      expect(result.errorMessage, isNotNull);
    });

    test('test FetchCommits null data scenario', () async {
      final response = Response(
        data: null,
        statusCode: 200,
        requestOptions: RequestOptions(path: Config.commits),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);
      final result = await apiService.fetchCommits("test");

      expect(result.status,
          DataWrapper.failure(StringConstant.errorNullResponse).status);
      expect(result.data, isNull);
      expect(result.errorMessage, StringConstant.errorNullResponse);
    });

    test('test FetchCommits generic error scenario', () async {
      when(mockDio.get(any)).thenThrow(Error());
      final result = await apiService.fetchCommits("test");

      expect(result.status, DataWrapper.failure('ApiService : Error').status);
      expect(result.data, isNull);
      expect(result.errorMessage, isNotNull);
    });
  });
}
