// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AuditTable extends Audit with TableInfo<$AuditTable, AuditData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
      'node_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _apiEndPointNameMeta =
      const VerificationMeta('apiEndPointName');
  @override
  late final GeneratedColumn<String> apiEndPointName = GeneratedColumn<String>(
      'api_end_point_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nodeId, apiEndPointName, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit';
  @override
  VerificationContext validateIntegrity(Insertable<AuditData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('node_id')) {
      context.handle(_nodeIdMeta,
          nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta));
    }
    if (data.containsKey('api_end_point_name')) {
      context.handle(
          _apiEndPointNameMeta,
          apiEndPointName.isAcceptableOrUnknown(
              data['api_end_point_name']!, _apiEndPointNameMeta));
    } else if (isInserting) {
      context.missing(_apiEndPointNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}node_id']),
      apiEndPointName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}api_end_point_name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $AuditTable createAlias(String alias) {
    return $AuditTable(attachedDatabase, alias);
  }
}

class AuditData extends DataClass implements Insertable<AuditData> {
  final int id;
  final String? nodeId;
  final String apiEndPointName;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const AuditData(
      {required this.id,
      this.nodeId,
      required this.apiEndPointName,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nodeId != null) {
      map['node_id'] = Variable<String>(nodeId);
    }
    map['api_end_point_name'] = Variable<String>(apiEndPointName);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  AuditCompanion toCompanion(bool nullToAbsent) {
    return AuditCompanion(
      id: Value(id),
      nodeId:
          nodeId == null && nullToAbsent ? const Value.absent() : Value(nodeId),
      apiEndPointName: Value(apiEndPointName),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory AuditData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditData(
      id: serializer.fromJson<int>(json['id']),
      nodeId: serializer.fromJson<String?>(json['nodeId']),
      apiEndPointName: serializer.fromJson<String>(json['apiEndPointName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nodeId': serializer.toJson<String?>(nodeId),
      'apiEndPointName': serializer.toJson<String>(apiEndPointName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  AuditData copyWith(
          {int? id,
          Value<String?> nodeId = const Value.absent(),
          String? apiEndPointName,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      AuditData(
        id: id ?? this.id,
        nodeId: nodeId.present ? nodeId.value : this.nodeId,
        apiEndPointName: apiEndPointName ?? this.apiEndPointName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('AuditData(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('apiEndPointName: $apiEndPointName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nodeId, apiEndPointName, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditData &&
          other.id == this.id &&
          other.nodeId == this.nodeId &&
          other.apiEndPointName == this.apiEndPointName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AuditCompanion extends UpdateCompanion<AuditData> {
  final Value<int> id;
  final Value<String?> nodeId;
  final Value<String> apiEndPointName;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const AuditCompanion({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.apiEndPointName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AuditCompanion.insert({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    required String apiEndPointName,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : apiEndPointName = Value(apiEndPointName);
  static Insertable<AuditData> custom({
    Expression<int>? id,
    Expression<String>? nodeId,
    Expression<String>? apiEndPointName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nodeId != null) 'node_id': nodeId,
      if (apiEndPointName != null) 'api_end_point_name': apiEndPointName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AuditCompanion copyWith(
      {Value<int>? id,
      Value<String?>? nodeId,
      Value<String>? apiEndPointName,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return AuditCompanion(
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      apiEndPointName: apiEndPointName ?? this.apiEndPointName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (apiEndPointName.present) {
      map['api_end_point_name'] = Variable<String>(apiEndPointName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditCompanion(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('apiEndPointName: $apiEndPointName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RepositoryTable extends Repository
    with TableInfo<$RepositoryTable, RepositoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepositoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
      'node_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nodeId, name, fullName, avatarUrl, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repository';
  @override
  VerificationContext validateIntegrity(Insertable<RepositoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('node_id')) {
      context.handle(_nodeIdMeta,
          nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepositoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepositoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}node_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name']),
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $RepositoryTable createAlias(String alias) {
    return $RepositoryTable(attachedDatabase, alias);
  }
}

class RepositoryData extends DataClass implements Insertable<RepositoryData> {
  final int id;
  final String? nodeId;
  final String? name;
  final String? fullName;
  final String? avatarUrl;
  final String? description;
  const RepositoryData(
      {required this.id,
      this.nodeId,
      this.name,
      this.fullName,
      this.avatarUrl,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nodeId != null) {
      map['node_id'] = Variable<String>(nodeId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  RepositoryCompanion toCompanion(bool nullToAbsent) {
    return RepositoryCompanion(
      id: Value(id),
      nodeId:
          nodeId == null && nullToAbsent ? const Value.absent() : Value(nodeId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory RepositoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepositoryData(
      id: serializer.fromJson<int>(json['id']),
      nodeId: serializer.fromJson<String?>(json['nodeId']),
      name: serializer.fromJson<String?>(json['name']),
      fullName: serializer.fromJson<String?>(json['fullName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nodeId': serializer.toJson<String?>(nodeId),
      'name': serializer.toJson<String?>(name),
      'fullName': serializer.toJson<String?>(fullName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'description': serializer.toJson<String?>(description),
    };
  }

  RepositoryData copyWith(
          {int? id,
          Value<String?> nodeId = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> fullName = const Value.absent(),
          Value<String?> avatarUrl = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      RepositoryData(
        id: id ?? this.id,
        nodeId: nodeId.present ? nodeId.value : this.nodeId,
        name: name.present ? name.value : this.name,
        fullName: fullName.present ? fullName.value : this.fullName,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('RepositoryData(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('name: $name, ')
          ..write('fullName: $fullName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nodeId, name, fullName, avatarUrl, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepositoryData &&
          other.id == this.id &&
          other.nodeId == this.nodeId &&
          other.name == this.name &&
          other.fullName == this.fullName &&
          other.avatarUrl == this.avatarUrl &&
          other.description == this.description);
}

class RepositoryCompanion extends UpdateCompanion<RepositoryData> {
  final Value<int> id;
  final Value<String?> nodeId;
  final Value<String?> name;
  final Value<String?> fullName;
  final Value<String?> avatarUrl;
  final Value<String?> description;
  const RepositoryCompanion({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.name = const Value.absent(),
    this.fullName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.description = const Value.absent(),
  });
  RepositoryCompanion.insert({
    this.id = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.name = const Value.absent(),
    this.fullName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.description = const Value.absent(),
  });
  static Insertable<RepositoryData> custom({
    Expression<int>? id,
    Expression<String>? nodeId,
    Expression<String>? name,
    Expression<String>? fullName,
    Expression<String>? avatarUrl,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nodeId != null) 'node_id': nodeId,
      if (name != null) 'name': name,
      if (fullName != null) 'full_name': fullName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (description != null) 'description': description,
    });
  }

  RepositoryCompanion copyWith(
      {Value<int>? id,
      Value<String?>? nodeId,
      Value<String?>? name,
      Value<String?>? fullName,
      Value<String?>? avatarUrl,
      Value<String?>? description}) {
    return RepositoryCompanion(
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepositoryCompanion(')
          ..write('id: $id, ')
          ..write('nodeId: $nodeId, ')
          ..write('name: $name, ')
          ..write('fullName: $fullName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $CommitTable extends Commit with TableInfo<$CommitTable, CommitData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommitTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _repositoryNameMeta =
      const VerificationMeta('repositoryName');
  @override
  late final GeneratedColumn<String> repositoryName = GeneratedColumn<String>(
      'repository_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _repositoryNodeIdMeta =
      const VerificationMeta('repositoryNodeId');
  @override
  late final GeneratedColumn<String> repositoryNodeId = GeneratedColumn<String>(
      'repository_node_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _shaMeta = const VerificationMeta('sha');
  @override
  late final GeneratedColumn<String> sha = GeneratedColumn<String>(
      'sha', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nodeIdMeta = const VerificationMeta('nodeId');
  @override
  late final GeneratedColumn<String> nodeId = GeneratedColumn<String>(
      'node_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commitDateMeta =
      const VerificationMeta('commitDate');
  @override
  late final GeneratedColumn<DateTime> commitDate = GeneratedColumn<DateTime>(
      'commit_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        repositoryName,
        repositoryNodeId,
        sha,
        nodeId,
        message,
        url,
        commitDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commit';
  @override
  VerificationContext validateIntegrity(Insertable<CommitData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('repository_name')) {
      context.handle(
          _repositoryNameMeta,
          repositoryName.isAcceptableOrUnknown(
              data['repository_name']!, _repositoryNameMeta));
    }
    if (data.containsKey('repository_node_id')) {
      context.handle(
          _repositoryNodeIdMeta,
          repositoryNodeId.isAcceptableOrUnknown(
              data['repository_node_id']!, _repositoryNodeIdMeta));
    }
    if (data.containsKey('sha')) {
      context.handle(
          _shaMeta, sha.isAcceptableOrUnknown(data['sha']!, _shaMeta));
    }
    if (data.containsKey('node_id')) {
      context.handle(_nodeIdMeta,
          nodeId.isAcceptableOrUnknown(data['node_id']!, _nodeIdMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('commit_date')) {
      context.handle(
          _commitDateMeta,
          commitDate.isAcceptableOrUnknown(
              data['commit_date']!, _commitDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommitData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommitData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      repositoryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repository_name']),
      repositoryNodeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}repository_node_id']),
      sha: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sha']),
      nodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}node_id']),
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message']),
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      commitDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}commit_date']),
    );
  }

  @override
  $CommitTable createAlias(String alias) {
    return $CommitTable(attachedDatabase, alias);
  }
}

class CommitData extends DataClass implements Insertable<CommitData> {
  final int id;
  final String? repositoryName;
  final String? repositoryNodeId;
  final String? sha;
  final String? nodeId;
  final String? message;
  final String? url;
  final DateTime? commitDate;
  const CommitData(
      {required this.id,
      this.repositoryName,
      this.repositoryNodeId,
      this.sha,
      this.nodeId,
      this.message,
      this.url,
      this.commitDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || repositoryName != null) {
      map['repository_name'] = Variable<String>(repositoryName);
    }
    if (!nullToAbsent || repositoryNodeId != null) {
      map['repository_node_id'] = Variable<String>(repositoryNodeId);
    }
    if (!nullToAbsent || sha != null) {
      map['sha'] = Variable<String>(sha);
    }
    if (!nullToAbsent || nodeId != null) {
      map['node_id'] = Variable<String>(nodeId);
    }
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || commitDate != null) {
      map['commit_date'] = Variable<DateTime>(commitDate);
    }
    return map;
  }

  CommitCompanion toCompanion(bool nullToAbsent) {
    return CommitCompanion(
      id: Value(id),
      repositoryName: repositoryName == null && nullToAbsent
          ? const Value.absent()
          : Value(repositoryName),
      repositoryNodeId: repositoryNodeId == null && nullToAbsent
          ? const Value.absent()
          : Value(repositoryNodeId),
      sha: sha == null && nullToAbsent ? const Value.absent() : Value(sha),
      nodeId:
          nodeId == null && nullToAbsent ? const Value.absent() : Value(nodeId),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      commitDate: commitDate == null && nullToAbsent
          ? const Value.absent()
          : Value(commitDate),
    );
  }

  factory CommitData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommitData(
      id: serializer.fromJson<int>(json['id']),
      repositoryName: serializer.fromJson<String?>(json['repositoryName']),
      repositoryNodeId: serializer.fromJson<String?>(json['repositoryNodeId']),
      sha: serializer.fromJson<String?>(json['sha']),
      nodeId: serializer.fromJson<String?>(json['nodeId']),
      message: serializer.fromJson<String?>(json['message']),
      url: serializer.fromJson<String?>(json['url']),
      commitDate: serializer.fromJson<DateTime?>(json['commitDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'repositoryName': serializer.toJson<String?>(repositoryName),
      'repositoryNodeId': serializer.toJson<String?>(repositoryNodeId),
      'sha': serializer.toJson<String?>(sha),
      'nodeId': serializer.toJson<String?>(nodeId),
      'message': serializer.toJson<String?>(message),
      'url': serializer.toJson<String?>(url),
      'commitDate': serializer.toJson<DateTime?>(commitDate),
    };
  }

  CommitData copyWith(
          {int? id,
          Value<String?> repositoryName = const Value.absent(),
          Value<String?> repositoryNodeId = const Value.absent(),
          Value<String?> sha = const Value.absent(),
          Value<String?> nodeId = const Value.absent(),
          Value<String?> message = const Value.absent(),
          Value<String?> url = const Value.absent(),
          Value<DateTime?> commitDate = const Value.absent()}) =>
      CommitData(
        id: id ?? this.id,
        repositoryName:
            repositoryName.present ? repositoryName.value : this.repositoryName,
        repositoryNodeId: repositoryNodeId.present
            ? repositoryNodeId.value
            : this.repositoryNodeId,
        sha: sha.present ? sha.value : this.sha,
        nodeId: nodeId.present ? nodeId.value : this.nodeId,
        message: message.present ? message.value : this.message,
        url: url.present ? url.value : this.url,
        commitDate: commitDate.present ? commitDate.value : this.commitDate,
      );
  @override
  String toString() {
    return (StringBuffer('CommitData(')
          ..write('id: $id, ')
          ..write('repositoryName: $repositoryName, ')
          ..write('repositoryNodeId: $repositoryNodeId, ')
          ..write('sha: $sha, ')
          ..write('nodeId: $nodeId, ')
          ..write('message: $message, ')
          ..write('url: $url, ')
          ..write('commitDate: $commitDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, repositoryName, repositoryNodeId, sha,
      nodeId, message, url, commitDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommitData &&
          other.id == this.id &&
          other.repositoryName == this.repositoryName &&
          other.repositoryNodeId == this.repositoryNodeId &&
          other.sha == this.sha &&
          other.nodeId == this.nodeId &&
          other.message == this.message &&
          other.url == this.url &&
          other.commitDate == this.commitDate);
}

class CommitCompanion extends UpdateCompanion<CommitData> {
  final Value<int> id;
  final Value<String?> repositoryName;
  final Value<String?> repositoryNodeId;
  final Value<String?> sha;
  final Value<String?> nodeId;
  final Value<String?> message;
  final Value<String?> url;
  final Value<DateTime?> commitDate;
  const CommitCompanion({
    this.id = const Value.absent(),
    this.repositoryName = const Value.absent(),
    this.repositoryNodeId = const Value.absent(),
    this.sha = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.message = const Value.absent(),
    this.url = const Value.absent(),
    this.commitDate = const Value.absent(),
  });
  CommitCompanion.insert({
    this.id = const Value.absent(),
    this.repositoryName = const Value.absent(),
    this.repositoryNodeId = const Value.absent(),
    this.sha = const Value.absent(),
    this.nodeId = const Value.absent(),
    this.message = const Value.absent(),
    this.url = const Value.absent(),
    this.commitDate = const Value.absent(),
  });
  static Insertable<CommitData> custom({
    Expression<int>? id,
    Expression<String>? repositoryName,
    Expression<String>? repositoryNodeId,
    Expression<String>? sha,
    Expression<String>? nodeId,
    Expression<String>? message,
    Expression<String>? url,
    Expression<DateTime>? commitDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repositoryName != null) 'repository_name': repositoryName,
      if (repositoryNodeId != null) 'repository_node_id': repositoryNodeId,
      if (sha != null) 'sha': sha,
      if (nodeId != null) 'node_id': nodeId,
      if (message != null) 'message': message,
      if (url != null) 'url': url,
      if (commitDate != null) 'commit_date': commitDate,
    });
  }

  CommitCompanion copyWith(
      {Value<int>? id,
      Value<String?>? repositoryName,
      Value<String?>? repositoryNodeId,
      Value<String?>? sha,
      Value<String?>? nodeId,
      Value<String?>? message,
      Value<String?>? url,
      Value<DateTime?>? commitDate}) {
    return CommitCompanion(
      id: id ?? this.id,
      repositoryName: repositoryName ?? this.repositoryName,
      repositoryNodeId: repositoryNodeId ?? this.repositoryNodeId,
      sha: sha ?? this.sha,
      nodeId: nodeId ?? this.nodeId,
      message: message ?? this.message,
      url: url ?? this.url,
      commitDate: commitDate ?? this.commitDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (repositoryName.present) {
      map['repository_name'] = Variable<String>(repositoryName.value);
    }
    if (repositoryNodeId.present) {
      map['repository_node_id'] = Variable<String>(repositoryNodeId.value);
    }
    if (sha.present) {
      map['sha'] = Variable<String>(sha.value);
    }
    if (nodeId.present) {
      map['node_id'] = Variable<String>(nodeId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (commitDate.present) {
      map['commit_date'] = Variable<DateTime>(commitDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommitCompanion(')
          ..write('id: $id, ')
          ..write('repositoryName: $repositoryName, ')
          ..write('repositoryNodeId: $repositoryNodeId, ')
          ..write('sha: $sha, ')
          ..write('nodeId: $nodeId, ')
          ..write('message: $message, ')
          ..write('url: $url, ')
          ..write('commitDate: $commitDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $AuditTable audit = $AuditTable(this);
  late final $RepositoryTable repository = $RepositoryTable(this);
  late final $CommitTable commit = $CommitTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [audit, repository, commit];
}

typedef $$AuditTableInsertCompanionBuilder = AuditCompanion Function({
  Value<int> id,
  Value<String?> nodeId,
  required String apiEndPointName,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$AuditTableUpdateCompanionBuilder = AuditCompanion Function({
  Value<int> id,
  Value<String?> nodeId,
  Value<String> apiEndPointName,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

class $$AuditTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditTable,
    AuditData,
    $$AuditTableFilterComposer,
    $$AuditTableOrderingComposer,
    $$AuditTableProcessedTableManager,
    $$AuditTableInsertCompanionBuilder,
    $$AuditTableUpdateCompanionBuilder> {
  $$AuditTableTableManager(_$AppDatabase db, $AuditTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AuditTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AuditTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$AuditTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            Value<String> apiEndPointName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              AuditCompanion(
            id: id,
            nodeId: nodeId,
            apiEndPointName: apiEndPointName,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            required String apiEndPointName,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              AuditCompanion.insert(
            id: id,
            nodeId: nodeId,
            apiEndPointName: apiEndPointName,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$AuditTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AuditTable,
    AuditData,
    $$AuditTableFilterComposer,
    $$AuditTableOrderingComposer,
    $$AuditTableProcessedTableManager,
    $$AuditTableInsertCompanionBuilder,
    $$AuditTableUpdateCompanionBuilder> {
  $$AuditTableProcessedTableManager(super.$state);
}

class $$AuditTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AuditTable> {
  $$AuditTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nodeId => $state.composableBuilder(
      column: $state.table.nodeId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get apiEndPointName => $state.composableBuilder(
      column: $state.table.apiEndPointName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AuditTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AuditTable> {
  $$AuditTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nodeId => $state.composableBuilder(
      column: $state.table.nodeId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get apiEndPointName => $state.composableBuilder(
      column: $state.table.apiEndPointName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$RepositoryTableInsertCompanionBuilder = RepositoryCompanion Function({
  Value<int> id,
  Value<String?> nodeId,
  Value<String?> name,
  Value<String?> fullName,
  Value<String?> avatarUrl,
  Value<String?> description,
});
typedef $$RepositoryTableUpdateCompanionBuilder = RepositoryCompanion Function({
  Value<int> id,
  Value<String?> nodeId,
  Value<String?> name,
  Value<String?> fullName,
  Value<String?> avatarUrl,
  Value<String?> description,
});

class $$RepositoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepositoryTable,
    RepositoryData,
    $$RepositoryTableFilterComposer,
    $$RepositoryTableOrderingComposer,
    $$RepositoryTableProcessedTableManager,
    $$RepositoryTableInsertCompanionBuilder,
    $$RepositoryTableUpdateCompanionBuilder> {
  $$RepositoryTableTableManager(_$AppDatabase db, $RepositoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RepositoryTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RepositoryTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$RepositoryTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> fullName = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              RepositoryCompanion(
            id: id,
            nodeId: nodeId,
            name: name,
            fullName: fullName,
            avatarUrl: avatarUrl,
            description: description,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> fullName = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              RepositoryCompanion.insert(
            id: id,
            nodeId: nodeId,
            name: name,
            fullName: fullName,
            avatarUrl: avatarUrl,
            description: description,
          ),
        ));
}

class $$RepositoryTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $RepositoryTable,
    RepositoryData,
    $$RepositoryTableFilterComposer,
    $$RepositoryTableOrderingComposer,
    $$RepositoryTableProcessedTableManager,
    $$RepositoryTableInsertCompanionBuilder,
    $$RepositoryTableUpdateCompanionBuilder> {
  $$RepositoryTableProcessedTableManager(super.$state);
}

class $$RepositoryTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RepositoryTable> {
  $$RepositoryTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nodeId => $state.composableBuilder(
      column: $state.table.nodeId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fullName => $state.composableBuilder(
      column: $state.table.fullName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get avatarUrl => $state.composableBuilder(
      column: $state.table.avatarUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$RepositoryTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RepositoryTable> {
  $$RepositoryTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nodeId => $state.composableBuilder(
      column: $state.table.nodeId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fullName => $state.composableBuilder(
      column: $state.table.fullName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get avatarUrl => $state.composableBuilder(
      column: $state.table.avatarUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CommitTableInsertCompanionBuilder = CommitCompanion Function({
  Value<int> id,
  Value<String?> repositoryName,
  Value<String?> repositoryNodeId,
  Value<String?> sha,
  Value<String?> nodeId,
  Value<String?> message,
  Value<String?> url,
  Value<DateTime?> commitDate,
});
typedef $$CommitTableUpdateCompanionBuilder = CommitCompanion Function({
  Value<int> id,
  Value<String?> repositoryName,
  Value<String?> repositoryNodeId,
  Value<String?> sha,
  Value<String?> nodeId,
  Value<String?> message,
  Value<String?> url,
  Value<DateTime?> commitDate,
});

class $$CommitTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommitTable,
    CommitData,
    $$CommitTableFilterComposer,
    $$CommitTableOrderingComposer,
    $$CommitTableProcessedTableManager,
    $$CommitTableInsertCompanionBuilder,
    $$CommitTableUpdateCompanionBuilder> {
  $$CommitTableTableManager(_$AppDatabase db, $CommitTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CommitTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CommitTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$CommitTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> repositoryName = const Value.absent(),
            Value<String?> repositoryNodeId = const Value.absent(),
            Value<String?> sha = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            Value<String?> message = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<DateTime?> commitDate = const Value.absent(),
          }) =>
              CommitCompanion(
            id: id,
            repositoryName: repositoryName,
            repositoryNodeId: repositoryNodeId,
            sha: sha,
            nodeId: nodeId,
            message: message,
            url: url,
            commitDate: commitDate,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> repositoryName = const Value.absent(),
            Value<String?> repositoryNodeId = const Value.absent(),
            Value<String?> sha = const Value.absent(),
            Value<String?> nodeId = const Value.absent(),
            Value<String?> message = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<DateTime?> commitDate = const Value.absent(),
          }) =>
              CommitCompanion.insert(
            id: id,
            repositoryName: repositoryName,
            repositoryNodeId: repositoryNodeId,
            sha: sha,
            nodeId: nodeId,
            message: message,
            url: url,
            commitDate: commitDate,
          ),
        ));
}

class $$CommitTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $CommitTable,
    CommitData,
    $$CommitTableFilterComposer,
    $$CommitTableOrderingComposer,
    $$CommitTableProcessedTableManager,
    $$CommitTableInsertCompanionBuilder,
    $$CommitTableUpdateCompanionBuilder> {
  $$CommitTableProcessedTableManager(super.$state);
}

class $$CommitTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CommitTable> {
  $$CommitTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get repositoryName => $state.composableBuilder(
      column: $state.table.repositoryName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get repositoryNodeId => $state.composableBuilder(
      column: $state.table.repositoryNodeId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sha => $state.composableBuilder(
      column: $state.table.sha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nodeId => $state.composableBuilder(
      column: $state.table.nodeId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get commitDate => $state.composableBuilder(
      column: $state.table.commitDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CommitTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CommitTable> {
  $$CommitTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get repositoryName => $state.composableBuilder(
      column: $state.table.repositoryName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get repositoryNodeId => $state.composableBuilder(
      column: $state.table.repositoryNodeId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sha => $state.composableBuilder(
      column: $state.table.sha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nodeId => $state.composableBuilder(
      column: $state.table.nodeId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get commitDate => $state.composableBuilder(
      column: $state.table.commitDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$AuditTableTableManager get audit =>
      $$AuditTableTableManager(_db, _db.audit);
  $$RepositoryTableTableManager get repository =>
      $$RepositoryTableTableManager(_db, _db.repository);
  $$CommitTableTableManager get commit =>
      $$CommitTableTableManager(_db, _db.commit);
}
