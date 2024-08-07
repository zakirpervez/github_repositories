import 'package:dio/dio.dart';

import '../res/string_constant.dart';
import '../wrappers/data_wrapper.dart';
import 'api_interceptor.dart';
import 'config.dart';
import 'entities/commits.dart';
import 'entities/repository.dart';

abstract class ApiService {
  void setupHeader();

  Future<DataWrapper<List<Repository>>> fetchRepositories();

  Future<DataWrapper<List<Commits>>> fetchCommits(String repoName);
}

class ApiServiceImpl extends ApiService {
  late Dio dio;
  late ApiInterceptor interceptor;

  ApiServiceImpl() {
    dio = Dio();
    interceptor = ApiInterceptor();
    setupHeader();
  }

  @override
  void setupHeader() {
    dio.options.baseUrl = Config.baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.interceptors.add(interceptor);
  }

    @override
    Future<DataWrapper<List<Repository>>> fetchRepositories() async {
      try {
        var responseData = await dio.get(Config.repositories);
        if (responseData.data == null) {
          return DataWrapper.failure(StringConstant.errorNullResponse);
        }
        List<dynamic> responseList = responseData.data;
        List<Repository> repositoryList =
            responseList.map((json) => Repository.fromJson(json)).toList();
        return DataWrapper.success(repositoryList);
      } on DioException catch (e) {
        return DataWrapper.failure('ApiService : $e');
      } on Error catch (e) {
        return DataWrapper.failure('ApiService : $e');
      }
    }

  @override
  Future<DataWrapper<List<Commits>>> fetchCommits(String repoName) async {
    try {
      var url = Config.commits.replaceAll('{repo-name}', repoName);
      var responseData = await dio.get(url);
      if (responseData.data == null) {
        return DataWrapper.failure(StringConstant.errorNullResponse);
      }
      List<Commits> commitsList = (responseData.data as List)
          .map((json) => Commits.fromJson(json))
          .toList();
      return DataWrapper.success(commitsList);
    } on DioException catch (e) {
      return DataWrapper.failure('ApiService : $e');
    } on Error catch (e) {
      return DataWrapper.failure('ApiService : $e');
    }
  }
}
