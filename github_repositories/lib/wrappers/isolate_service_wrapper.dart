import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:github_repositories/remote/entities/commits.dart';

import '../remote/api_service.dart';
import '../res/string_constant.dart';
import 'data_wrapper.dart';

enum IsolateServiceType { commit }

// Should consider builder pattern here.
mixin IsolateServiceWrapper {
  Future<DataWrapper<List<Commits>?>> fetchCommitsInIsolate(
      {required String repoName});

  static IsolateServiceWrapper buildIsolateService(
      {required IsolateServiceType serviceType}) {
    if (serviceType == IsolateServiceType.commit) {
      return CommitIsolateServiceImpl();
    } else {
      throw StateError("Invalid IsolateServiceType");
    }
  }
}

final class CommitIsolateServiceImpl with IsolateServiceWrapper {
  CommitIsolateServiceImpl();

  @override
  Future<DataWrapper<List<Commits>?>> fetchCommitsInIsolate(
      {required String repoName}) async {
    final receivePort = ReceivePort();
    try {
      await Isolate.spawn(_isolatedCommitCall, {
        'repoName': repoName,
        'sendPort': receivePort.sendPort,
      });
      var commitsResponse =
          await receivePort.first as DataWrapper<List<Commits>?>;
      receivePort.close();
      return commitsResponse;
    } catch (e) {
      debugPrint("CommitIsolateServiceImpl : $e");
      return DataWrapper.failure(StringConstant.errorInCommitIsolate);
    }
  }

  void _isolatedCommitCall(Map<String, dynamic> params) async {
    String repoName = params['repoName'];
    SendPort sendPort = params['sendPort'] as SendPort;
    try {
      final apiService = ApiServiceImpl();
      final DataWrapper<List<Commits>> responseDataWrapper =
          await apiService.fetchCommits(repoName);
      final response = responseDataWrapper.data as List<Commits>;
      sendPort.send(DataWrapper.success(response));
    } catch (e) {
      sendPort.send(DataWrapper.failure(e.toString()));
    }
  }
}
