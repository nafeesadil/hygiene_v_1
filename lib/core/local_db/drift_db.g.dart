// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_db.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _taskKeyMeta = const VerificationMeta(
    'taskKey',
  );
  @override
  late final GeneratedColumn<String> taskKey = GeneratedColumn<String>(
    'task_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _valuePointsMeta = const VerificationMeta(
    'valuePoints',
  );
  @override
  late final GeneratedColumn<int> valuePoints = GeneratedColumn<int>(
    'value_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastDoneAtMsMeta = const VerificationMeta(
    'lastDoneAtMs',
  );
  @override
  late final GeneratedColumn<int> lastDoneAtMs = GeneratedColumn<int>(
    'last_done_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskKey,
    isActive,
    level,
    valuePoints,
    lastDoneAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_key')) {
      context.handle(
        _taskKeyMeta,
        taskKey.isAcceptableOrUnknown(data['task_key']!, _taskKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_taskKeyMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('value_points')) {
      context.handle(
        _valuePointsMeta,
        valuePoints.isAcceptableOrUnknown(
          data['value_points']!,
          _valuePointsMeta,
        ),
      );
    }
    if (data.containsKey('last_done_at_ms')) {
      context.handle(
        _lastDoneAtMsMeta,
        lastDoneAtMs.isAcceptableOrUnknown(
          data['last_done_at_ms']!,
          _lastDoneAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {taskKey},
  ];
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_key'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      valuePoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value_points'],
      )!,
      lastDoneAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_done_at_ms'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String taskKey;
  final bool isActive;
  final int level;
  final int valuePoints;
  final int lastDoneAtMs;
  const Task({
    required this.id,
    required this.taskKey,
    required this.isActive,
    required this.level,
    required this.valuePoints,
    required this.lastDoneAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_key'] = Variable<String>(taskKey);
    map['is_active'] = Variable<bool>(isActive);
    map['level'] = Variable<int>(level);
    map['value_points'] = Variable<int>(valuePoints);
    map['last_done_at_ms'] = Variable<int>(lastDoneAtMs);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      taskKey: Value(taskKey),
      isActive: Value(isActive),
      level: Value(level),
      valuePoints: Value(valuePoints),
      lastDoneAtMs: Value(lastDoneAtMs),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      taskKey: serializer.fromJson<String>(json['taskKey']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      level: serializer.fromJson<int>(json['level']),
      valuePoints: serializer.fromJson<int>(json['valuePoints']),
      lastDoneAtMs: serializer.fromJson<int>(json['lastDoneAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskKey': serializer.toJson<String>(taskKey),
      'isActive': serializer.toJson<bool>(isActive),
      'level': serializer.toJson<int>(level),
      'valuePoints': serializer.toJson<int>(valuePoints),
      'lastDoneAtMs': serializer.toJson<int>(lastDoneAtMs),
    };
  }

  Task copyWith({
    int? id,
    String? taskKey,
    bool? isActive,
    int? level,
    int? valuePoints,
    int? lastDoneAtMs,
  }) => Task(
    id: id ?? this.id,
    taskKey: taskKey ?? this.taskKey,
    isActive: isActive ?? this.isActive,
    level: level ?? this.level,
    valuePoints: valuePoints ?? this.valuePoints,
    lastDoneAtMs: lastDoneAtMs ?? this.lastDoneAtMs,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      taskKey: data.taskKey.present ? data.taskKey.value : this.taskKey,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      level: data.level.present ? data.level.value : this.level,
      valuePoints: data.valuePoints.present
          ? data.valuePoints.value
          : this.valuePoints,
      lastDoneAtMs: data.lastDoneAtMs.present
          ? data.lastDoneAtMs.value
          : this.lastDoneAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('taskKey: $taskKey, ')
          ..write('isActive: $isActive, ')
          ..write('level: $level, ')
          ..write('valuePoints: $valuePoints, ')
          ..write('lastDoneAtMs: $lastDoneAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taskKey, isActive, level, valuePoints, lastDoneAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.taskKey == this.taskKey &&
          other.isActive == this.isActive &&
          other.level == this.level &&
          other.valuePoints == this.valuePoints &&
          other.lastDoneAtMs == this.lastDoneAtMs);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> taskKey;
  final Value<bool> isActive;
  final Value<int> level;
  final Value<int> valuePoints;
  final Value<int> lastDoneAtMs;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.taskKey = const Value.absent(),
    this.isActive = const Value.absent(),
    this.level = const Value.absent(),
    this.valuePoints = const Value.absent(),
    this.lastDoneAtMs = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String taskKey,
    this.isActive = const Value.absent(),
    this.level = const Value.absent(),
    this.valuePoints = const Value.absent(),
    this.lastDoneAtMs = const Value.absent(),
  }) : taskKey = Value(taskKey);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? taskKey,
    Expression<bool>? isActive,
    Expression<int>? level,
    Expression<int>? valuePoints,
    Expression<int>? lastDoneAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskKey != null) 'task_key': taskKey,
      if (isActive != null) 'is_active': isActive,
      if (level != null) 'level': level,
      if (valuePoints != null) 'value_points': valuePoints,
      if (lastDoneAtMs != null) 'last_done_at_ms': lastDoneAtMs,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? taskKey,
    Value<bool>? isActive,
    Value<int>? level,
    Value<int>? valuePoints,
    Value<int>? lastDoneAtMs,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      taskKey: taskKey ?? this.taskKey,
      isActive: isActive ?? this.isActive,
      level: level ?? this.level,
      valuePoints: valuePoints ?? this.valuePoints,
      lastDoneAtMs: lastDoneAtMs ?? this.lastDoneAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskKey.present) {
      map['task_key'] = Variable<String>(taskKey.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (valuePoints.present) {
      map['value_points'] = Variable<int>(valuePoints.value);
    }
    if (lastDoneAtMs.present) {
      map['last_done_at_ms'] = Variable<int>(lastDoneAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('taskKey: $taskKey, ')
          ..write('isActive: $isActive, ')
          ..write('level: $level, ')
          ..write('valuePoints: $valuePoints, ')
          ..write('lastDoneAtMs: $lastDoneAtMs')
          ..write(')'))
        .toString();
  }
}

class $TaskLogsTable extends TaskLogs with TableInfo<$TaskLogsTable, TaskLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _taskKeyMeta = const VerificationMeta(
    'taskKey',
  );
  @override
  late final GeneratedColumn<String> taskKey = GeneratedColumn<String>(
    'task_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateKeyMeta = const VerificationMeta(
    'dateKey',
  );
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
    'date_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMsMeta = const VerificationMeta(
    'timestampMs',
  );
  @override
  late final GeneratedColumn<int> timestampMs = GeneratedColumn<int>(
    'timestamp_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, taskKey, dateKey, timestampMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_key')) {
      context.handle(
        _taskKeyMeta,
        taskKey.isAcceptableOrUnknown(data['task_key']!, _taskKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_taskKeyMeta);
    }
    if (data.containsKey('date_key')) {
      context.handle(
        _dateKeyMeta,
        dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('timestamp_ms')) {
      context.handle(
        _timestampMsMeta,
        timestampMs.isAcceptableOrUnknown(
          data['timestamp_ms']!,
          _timestampMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_key'],
      )!,
      dateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_key'],
      )!,
      timestampMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_ms'],
      )!,
    );
  }

  @override
  $TaskLogsTable createAlias(String alias) {
    return $TaskLogsTable(attachedDatabase, alias);
  }
}

class TaskLog extends DataClass implements Insertable<TaskLog> {
  final int id;
  final String taskKey;
  final String dateKey;
  final int timestampMs;
  const TaskLog({
    required this.id,
    required this.taskKey,
    required this.dateKey,
    required this.timestampMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_key'] = Variable<String>(taskKey);
    map['date_key'] = Variable<String>(dateKey);
    map['timestamp_ms'] = Variable<int>(timestampMs);
    return map;
  }

  TaskLogsCompanion toCompanion(bool nullToAbsent) {
    return TaskLogsCompanion(
      id: Value(id),
      taskKey: Value(taskKey),
      dateKey: Value(dateKey),
      timestampMs: Value(timestampMs),
    );
  }

  factory TaskLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskLog(
      id: serializer.fromJson<int>(json['id']),
      taskKey: serializer.fromJson<String>(json['taskKey']),
      dateKey: serializer.fromJson<String>(json['dateKey']),
      timestampMs: serializer.fromJson<int>(json['timestampMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskKey': serializer.toJson<String>(taskKey),
      'dateKey': serializer.toJson<String>(dateKey),
      'timestampMs': serializer.toJson<int>(timestampMs),
    };
  }

  TaskLog copyWith({
    int? id,
    String? taskKey,
    String? dateKey,
    int? timestampMs,
  }) => TaskLog(
    id: id ?? this.id,
    taskKey: taskKey ?? this.taskKey,
    dateKey: dateKey ?? this.dateKey,
    timestampMs: timestampMs ?? this.timestampMs,
  );
  TaskLog copyWithCompanion(TaskLogsCompanion data) {
    return TaskLog(
      id: data.id.present ? data.id.value : this.id,
      taskKey: data.taskKey.present ? data.taskKey.value : this.taskKey,
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      timestampMs: data.timestampMs.present
          ? data.timestampMs.value
          : this.timestampMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskLog(')
          ..write('id: $id, ')
          ..write('taskKey: $taskKey, ')
          ..write('dateKey: $dateKey, ')
          ..write('timestampMs: $timestampMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskKey, dateKey, timestampMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskLog &&
          other.id == this.id &&
          other.taskKey == this.taskKey &&
          other.dateKey == this.dateKey &&
          other.timestampMs == this.timestampMs);
}

class TaskLogsCompanion extends UpdateCompanion<TaskLog> {
  final Value<int> id;
  final Value<String> taskKey;
  final Value<String> dateKey;
  final Value<int> timestampMs;
  const TaskLogsCompanion({
    this.id = const Value.absent(),
    this.taskKey = const Value.absent(),
    this.dateKey = const Value.absent(),
    this.timestampMs = const Value.absent(),
  });
  TaskLogsCompanion.insert({
    this.id = const Value.absent(),
    required String taskKey,
    required String dateKey,
    required int timestampMs,
  }) : taskKey = Value(taskKey),
       dateKey = Value(dateKey),
       timestampMs = Value(timestampMs);
  static Insertable<TaskLog> custom({
    Expression<int>? id,
    Expression<String>? taskKey,
    Expression<String>? dateKey,
    Expression<int>? timestampMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskKey != null) 'task_key': taskKey,
      if (dateKey != null) 'date_key': dateKey,
      if (timestampMs != null) 'timestamp_ms': timestampMs,
    });
  }

  TaskLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? taskKey,
    Value<String>? dateKey,
    Value<int>? timestampMs,
  }) {
    return TaskLogsCompanion(
      id: id ?? this.id,
      taskKey: taskKey ?? this.taskKey,
      dateKey: dateKey ?? this.dateKey,
      timestampMs: timestampMs ?? this.timestampMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskKey.present) {
      map['task_key'] = Variable<String>(taskKey.value);
    }
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (timestampMs.present) {
      map['timestamp_ms'] = Variable<int>(timestampMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskLogsCompanion(')
          ..write('id: $id, ')
          ..write('taskKey: $taskKey, ')
          ..write('dateKey: $dateKey, ')
          ..write('timestampMs: $timestampMs')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TaskLogsTable taskLogs = $TaskLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, taskLogs];
}

typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      required String taskKey,
      Value<bool> isActive,
      Value<int> level,
      Value<int> valuePoints,
      Value<int> lastDoneAtMs,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<int> id,
      Value<String> taskKey,
      Value<bool> isActive,
      Value<int> level,
      Value<int> valuePoints,
      Value<int> lastDoneAtMs,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDb, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskKey => $composableBuilder(
    column: $table.taskKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valuePoints => $composableBuilder(
    column: $table.valuePoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastDoneAtMs => $composableBuilder(
    column: $table.lastDoneAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer extends Composer<_$AppDb, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskKey => $composableBuilder(
    column: $table.taskKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valuePoints => $composableBuilder(
    column: $table.valuePoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastDoneAtMs => $composableBuilder(
    column: $table.lastDoneAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer extends Composer<_$AppDb, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskKey =>
      $composableBuilder(column: $table.taskKey, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get valuePoints => $composableBuilder(
    column: $table.valuePoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastDoneAtMs => $composableBuilder(
    column: $table.lastDoneAtMs,
    builder: (column) => column,
  );
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, BaseReferences<_$AppDb, $TasksTable, Task>),
          Task,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDb db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> taskKey = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> valuePoints = const Value.absent(),
                Value<int> lastDoneAtMs = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                taskKey: taskKey,
                isActive: isActive,
                level: level,
                valuePoints: valuePoints,
                lastDoneAtMs: lastDoneAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String taskKey,
                Value<bool> isActive = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> valuePoints = const Value.absent(),
                Value<int> lastDoneAtMs = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                taskKey: taskKey,
                isActive: isActive,
                level: level,
                valuePoints: valuePoints,
                lastDoneAtMs: lastDoneAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, BaseReferences<_$AppDb, $TasksTable, Task>),
      Task,
      PrefetchHooks Function()
    >;
typedef $$TaskLogsTableCreateCompanionBuilder =
    TaskLogsCompanion Function({
      Value<int> id,
      required String taskKey,
      required String dateKey,
      required int timestampMs,
    });
typedef $$TaskLogsTableUpdateCompanionBuilder =
    TaskLogsCompanion Function({
      Value<int> id,
      Value<String> taskKey,
      Value<String> dateKey,
      Value<int> timestampMs,
    });

class $$TaskLogsTableFilterComposer extends Composer<_$AppDb, $TaskLogsTable> {
  $$TaskLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskKey => $composableBuilder(
    column: $table.taskKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaskLogsTableOrderingComposer
    extends Composer<_$AppDb, $TaskLogsTable> {
  $$TaskLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskKey => $composableBuilder(
    column: $table.taskKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaskLogsTableAnnotationComposer
    extends Composer<_$AppDb, $TaskLogsTable> {
  $$TaskLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskKey =>
      $composableBuilder(column: $table.taskKey, builder: (column) => column);

  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => column,
  );
}

class $$TaskLogsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $TaskLogsTable,
          TaskLog,
          $$TaskLogsTableFilterComposer,
          $$TaskLogsTableOrderingComposer,
          $$TaskLogsTableAnnotationComposer,
          $$TaskLogsTableCreateCompanionBuilder,
          $$TaskLogsTableUpdateCompanionBuilder,
          (TaskLog, BaseReferences<_$AppDb, $TaskLogsTable, TaskLog>),
          TaskLog,
          PrefetchHooks Function()
        > {
  $$TaskLogsTableTableManager(_$AppDb db, $TaskLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> taskKey = const Value.absent(),
                Value<String> dateKey = const Value.absent(),
                Value<int> timestampMs = const Value.absent(),
              }) => TaskLogsCompanion(
                id: id,
                taskKey: taskKey,
                dateKey: dateKey,
                timestampMs: timestampMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String taskKey,
                required String dateKey,
                required int timestampMs,
              }) => TaskLogsCompanion.insert(
                id: id,
                taskKey: taskKey,
                dateKey: dateKey,
                timestampMs: timestampMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaskLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $TaskLogsTable,
      TaskLog,
      $$TaskLogsTableFilterComposer,
      $$TaskLogsTableOrderingComposer,
      $$TaskLogsTableAnnotationComposer,
      $$TaskLogsTableCreateCompanionBuilder,
      $$TaskLogsTableUpdateCompanionBuilder,
      (TaskLog, BaseReferences<_$AppDb, $TaskLogsTable, TaskLog>),
      TaskLog,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$TaskLogsTableTableManager get taskLogs =>
      $$TaskLogsTableTableManager(_db, _db.taskLogs);
}
