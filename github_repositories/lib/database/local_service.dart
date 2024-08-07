import 'app_database.dart';

class LocalService {
  late AppDatabase _appDatabase;

  LocalService() {
    _appDatabase = AppDatabase();
  }

  Future<int> saveOrUpdateAuditData(AuditCompanion entry) {
    return _appDatabase.upsertAuditRecord(entry);
  }

  Future<int> saveAudit(AuditCompanion entry) {
    return _appDatabase.insertAudit(entry);
  }

  Future<void> deleteAllRepositories() {
    return _appDatabase.deleteAllRepositories();
  }

  Future<AuditData?> getAuditRecord(String apiEndPoint, String? nodeId) {
    return _appDatabase.getAuditRecord(apiEndPoint, nodeId);
  }

  Future<List<AuditData>> getCommitRecordByApiEndPointNameAndNodeId(
      String apiName, String repoNodeId) {
    return _appDatabase.getRecordsByApiEndPointNameAndNodeId(
        apiName, repoNodeId);
  }

  Future<void> saveRepositories(List<RepositoryCompanion> repositories) {
    return _appDatabase.insertRepositories(repositories);
  }

  Future<List<RepositoryData>> getAllRepositories() {
    return _appDatabase.getAllRepositories();
  }

  Future<void> saveCommits(List<CommitCompanion> entries) async {
    return _appDatabase.insertCommits(entries);
  }

  Future<List<CommitData>> getCommitsByRepositoryNodeId(
      String repositoryNodeId) {
    return _appDatabase.getCommitsByRepositoryNodeId(repositoryNodeId);
  }

  Future<void> deleteCommitsByNodeId(String repositoryNodeId) {
    return _appDatabase.deleteCommitsByNodeId(repositoryNodeId);
  }
}
