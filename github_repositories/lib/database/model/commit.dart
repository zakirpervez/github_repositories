import 'package:drift/drift.dart';

class Commit extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get repositoryName => text().nullable()();

  TextColumn get repositoryNodeId => text().nullable()();

  TextColumn get sha => text().nullable()();

  TextColumn get nodeId => text().unique().nullable()();

  TextColumn get message => text().nullable()();

  TextColumn get url => text().nullable()();

  DateTimeColumn get commitDate => dateTime().nullable()();
}
