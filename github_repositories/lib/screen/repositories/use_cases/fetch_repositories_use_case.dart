import 'package:github_repositories/base/base_use_case/base_use_case.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/repository/repository.dart';
import 'package:github_repositories/res/dimen_constant.dart';

import '../../../remote/config.dart';
import '../../../remote/entities/repository.dart';
import '../../../wrappers/data_wrapper.dart';

class FetchRepositoriesUseCase implements BaseUseCase {
  final RepositoryService repository;

  FetchRepositoriesUseCase({required this.repository});

  Future<DataWrapper<List<RepositoryData>>> call() async {
    DataWrapper<AuditData> auditDataWrapper =
        await repository.getAuditData(Config.repositories);
    AuditData? auditData = auditDataWrapper.data;
    bool isApiCallAllowed = _checkIfApiCallAllowed(auditData);

    if (isApiCallAllowed) {
      var apiResponseWrapper = await repository.fetchRepositoriesFromApi();
      if (apiResponseWrapper.status == Status.success) {
        repository.saveOrUpdateAuditData(Config.repositories);
        List<Repository> remoteRepositoryList = apiResponseWrapper.data ?? [];
        repository.deleteAllRepositories();
        repository.saveRepositoriesToLocal(remoteRepositoryList);
      }
    }

    return repository.fetchRepositoriesFromLocal();
  }

  bool _checkIfApiCallAllowed(AuditData? auditData) {
    if (auditData == null) {
      return true;
    }
    DateTime now = DateTime.now();
    Duration difference = now.difference(auditData.updatedAt!);
    return difference.inHours >= Dimen.magic12;
  }
}
