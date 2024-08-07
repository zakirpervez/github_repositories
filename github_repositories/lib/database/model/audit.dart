import 'package:drift/drift.dart';

class Audit extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nodeId => text().nullable()();

  TextColumn get apiEndPointName => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}
