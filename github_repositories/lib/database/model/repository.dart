import 'package:drift/drift.dart';

class Repository extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nodeId => text().nullable()();

  TextColumn get name => text().nullable()();

  TextColumn get fullName => text().nullable()();

  TextColumn get avatarUrl => text().nullable()();

  TextColumn get description => text().nullable()();
}
