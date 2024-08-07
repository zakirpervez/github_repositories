import 'package:drift/drift.dart';
import 'package:github_repositories/database/config.dart';
import 'package:github_repositories/database/model/audit.dart';
import 'package:github_repositories/database/model/commit.dart';
import 'package:github_repositories/database/model/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:drift/native.dart';
import 'dart:io';

part 'app_database.g.dart';

@DriftDatabase(tables: [Audit, Repository, Commit])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => Config.databaseSchemaVersion;

  // Methods for AuditTable
  Future<int> upsertAuditRecord(AuditCompanion entry) async {
    // Insert if there is no record; update if there is already a record.
    return await into(audit).insertOnConflictUpdate(entry);
  }

  Future<int> insertAudit(AuditCompanion entry) async {
    // Insert if there is no record; update if there is already a record.
    return await into(audit).insert(entry);
  }

  Future<AuditData?> getAuditRecord(String apiEndPoint, String? nodeId) async {
    final query = select(audit)
      ..where((tbl) {
        final nodeIdCondition =
            nodeId != null ? tbl.nodeId.equals(nodeId) : tbl.nodeId.isNull();
        return tbl.apiEndPointName.equals(apiEndPoint) & nodeIdCondition;
      })
      ..limit(1);

    return await query.getSingleOrNull();
  }

  // Fetch records where apiEndPointName and nodeId match
  Future<List<AuditData>> getRecordsByApiEndPointNameAndNodeId(
      String apiName, String nodeId) {
    return (select(audit)
          ..where((tbl) => tbl.apiEndPointName.equals(apiName))
          ..where((tbl) => tbl.nodeId.equals(nodeId)))
        .get();
  }

  // Methods to interact with RepositoryTable
  Future<List<RepositoryData>> getAllRepositories() => select(repository).get();

  Future<void> insertRepositories(
      List<RepositoryCompanion> repositories) async {
    await batch((batch) {
      batch.insertAll(repository, repositories);
    });
  }

  Future<void> deleteAllRepositories() async {
    await delete(repository).go();
  }

  // Stream<List<RepositoryData>> watchAllRepositories() =>
  //     select(repository).watch();
  //
  // Future insertRepository(RepositoryCompanion companion) =>
  //     into(repository).insert(companion);
  //
  // Future updateRepository(RepositoryCompanion companion) =>
  //     update(repository).replace(companion);
  //
  // Future deleteRepository(RepositoryCompanion companion) =>
  //     delete(repository).delete(companion);

  // Methods for commit table
  Future<void> insertCommits(List<CommitCompanion> entries) async {
    try {
      await batch((batch) {
        batch.insertAllOnConflictUpdate(commit, entries);
      });
    } catch (e) {
      for (var entry in entries) {
        try {
          await into(commit).insertOnConflictUpdate(entry);
        } catch (e) {
          e.toString();
        }
      }
    }
  }

  Future<List<CommitData>> getCommitsByRepositoryNodeId(
      String repositoryNodeId) async {
    final query = select(commit)
      ..where((tbl) => tbl.repositoryNodeId.equals(repositoryNodeId));
    return await query.get();
  }

  Future<void> deleteCommitsByNodeId(String repositoryNodeId) async {
    await (delete(commit)..where((tbl) => tbl.repositoryNodeId.equals(repositoryNodeId))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, Config.databaseName));
    return NativeDatabase(file);
  });
}
