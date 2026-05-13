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

class $ShopStateTable extends ShopState
    with TableInfo<$ShopStateTable, ShopStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOpenMeta = const VerificationMeta('isOpen');
  @override
  late final GeneratedColumn<bool> isOpen = GeneratedColumn<bool>(
    'is_open',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_open" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _openedAtMsMeta = const VerificationMeta(
    'openedAtMs',
  );
  @override
  late final GeneratedColumn<int> openedAtMs = GeneratedColumn<int>(
    'opened_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, isOpen, openedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shop_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_open')) {
      context.handle(
        _isOpenMeta,
        isOpen.isAcceptableOrUnknown(data['is_open']!, _isOpenMeta),
      );
    }
    if (data.containsKey('opened_at_ms')) {
      context.handle(
        _openedAtMsMeta,
        openedAtMs.isAcceptableOrUnknown(
          data['opened_at_ms']!,
          _openedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isOpen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_open'],
      )!,
      openedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opened_at_ms'],
      )!,
    );
  }

  @override
  $ShopStateTable createAlias(String alias) {
    return $ShopStateTable(attachedDatabase, alias);
  }
}

class ShopStateData extends DataClass implements Insertable<ShopStateData> {
  final int id;
  final bool isOpen;
  final int openedAtMs;
  const ShopStateData({
    required this.id,
    required this.isOpen,
    required this.openedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_open'] = Variable<bool>(isOpen);
    map['opened_at_ms'] = Variable<int>(openedAtMs);
    return map;
  }

  ShopStateCompanion toCompanion(bool nullToAbsent) {
    return ShopStateCompanion(
      id: Value(id),
      isOpen: Value(isOpen),
      openedAtMs: Value(openedAtMs),
    );
  }

  factory ShopStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopStateData(
      id: serializer.fromJson<int>(json['id']),
      isOpen: serializer.fromJson<bool>(json['isOpen']),
      openedAtMs: serializer.fromJson<int>(json['openedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isOpen': serializer.toJson<bool>(isOpen),
      'openedAtMs': serializer.toJson<int>(openedAtMs),
    };
  }

  ShopStateData copyWith({int? id, bool? isOpen, int? openedAtMs}) =>
      ShopStateData(
        id: id ?? this.id,
        isOpen: isOpen ?? this.isOpen,
        openedAtMs: openedAtMs ?? this.openedAtMs,
      );
  ShopStateData copyWithCompanion(ShopStateCompanion data) {
    return ShopStateData(
      id: data.id.present ? data.id.value : this.id,
      isOpen: data.isOpen.present ? data.isOpen.value : this.isOpen,
      openedAtMs: data.openedAtMs.present
          ? data.openedAtMs.value
          : this.openedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopStateData(')
          ..write('id: $id, ')
          ..write('isOpen: $isOpen, ')
          ..write('openedAtMs: $openedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isOpen, openedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopStateData &&
          other.id == this.id &&
          other.isOpen == this.isOpen &&
          other.openedAtMs == this.openedAtMs);
}

class ShopStateCompanion extends UpdateCompanion<ShopStateData> {
  final Value<int> id;
  final Value<bool> isOpen;
  final Value<int> openedAtMs;
  const ShopStateCompanion({
    this.id = const Value.absent(),
    this.isOpen = const Value.absent(),
    this.openedAtMs = const Value.absent(),
  });
  ShopStateCompanion.insert({
    this.id = const Value.absent(),
    this.isOpen = const Value.absent(),
    this.openedAtMs = const Value.absent(),
  });
  static Insertable<ShopStateData> custom({
    Expression<int>? id,
    Expression<bool>? isOpen,
    Expression<int>? openedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isOpen != null) 'is_open': isOpen,
      if (openedAtMs != null) 'opened_at_ms': openedAtMs,
    });
  }

  ShopStateCompanion copyWith({
    Value<int>? id,
    Value<bool>? isOpen,
    Value<int>? openedAtMs,
  }) {
    return ShopStateCompanion(
      id: id ?? this.id,
      isOpen: isOpen ?? this.isOpen,
      openedAtMs: openedAtMs ?? this.openedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isOpen.present) {
      map['is_open'] = Variable<bool>(isOpen.value);
    }
    if (openedAtMs.present) {
      map['opened_at_ms'] = Variable<int>(openedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopStateCompanion(')
          ..write('id: $id, ')
          ..write('isOpen: $isOpen, ')
          ..write('openedAtMs: $openedAtMs')
          ..write(')'))
        .toString();
  }
}

class $VendorStateTable extends VendorState
    with TableInfo<$VendorStateTable, VendorStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendorStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vendorLevelMeta = const VerificationMeta(
    'vendorLevel',
  );
  @override
  late final GeneratedColumn<int> vendorLevel = GeneratedColumn<int>(
    'vendor_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _vendorScoreMeta = const VerificationMeta(
    'vendorScore',
  );
  @override
  late final GeneratedColumn<double> vendorScore = GeneratedColumn<double>(
    'vendor_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bestStreakMeta = const VerificationMeta(
    'bestStreak',
  );
  @override
  late final GeneratedColumn<int> bestStreak = GeneratedColumn<int>(
    'best_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    totalXp,
    vendorLevel,
    vendorScore,
    bestStreak,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendor_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<VendorStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('vendor_level')) {
      context.handle(
        _vendorLevelMeta,
        vendorLevel.isAcceptableOrUnknown(
          data['vendor_level']!,
          _vendorLevelMeta,
        ),
      );
    }
    if (data.containsKey('vendor_score')) {
      context.handle(
        _vendorScoreMeta,
        vendorScore.isAcceptableOrUnknown(
          data['vendor_score']!,
          _vendorScoreMeta,
        ),
      );
    }
    if (data.containsKey('best_streak')) {
      context.handle(
        _bestStreakMeta,
        bestStreak.isAcceptableOrUnknown(data['best_streak']!, _bestStreakMeta),
      );
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VendorStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VendorStateData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      vendorLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vendor_level'],
      )!,
      vendorScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vendor_score'],
      )!,
      bestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_streak'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $VendorStateTable createAlias(String alias) {
    return $VendorStateTable(attachedDatabase, alias);
  }
}

class VendorStateData extends DataClass implements Insertable<VendorStateData> {
  final int id;
  final int totalXp;
  final int vendorLevel;
  final double vendorScore;
  final int bestStreak;
  final int updatedAtMs;
  const VendorStateData({
    required this.id,
    required this.totalXp,
    required this.vendorLevel,
    required this.vendorScore,
    required this.bestStreak,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_xp'] = Variable<int>(totalXp);
    map['vendor_level'] = Variable<int>(vendorLevel);
    map['vendor_score'] = Variable<double>(vendorScore);
    map['best_streak'] = Variable<int>(bestStreak);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  VendorStateCompanion toCompanion(bool nullToAbsent) {
    return VendorStateCompanion(
      id: Value(id),
      totalXp: Value(totalXp),
      vendorLevel: Value(vendorLevel),
      vendorScore: Value(vendorScore),
      bestStreak: Value(bestStreak),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory VendorStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VendorStateData(
      id: serializer.fromJson<int>(json['id']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      vendorLevel: serializer.fromJson<int>(json['vendorLevel']),
      vendorScore: serializer.fromJson<double>(json['vendorScore']),
      bestStreak: serializer.fromJson<int>(json['bestStreak']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalXp': serializer.toJson<int>(totalXp),
      'vendorLevel': serializer.toJson<int>(vendorLevel),
      'vendorScore': serializer.toJson<double>(vendorScore),
      'bestStreak': serializer.toJson<int>(bestStreak),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  VendorStateData copyWith({
    int? id,
    int? totalXp,
    int? vendorLevel,
    double? vendorScore,
    int? bestStreak,
    int? updatedAtMs,
  }) => VendorStateData(
    id: id ?? this.id,
    totalXp: totalXp ?? this.totalXp,
    vendorLevel: vendorLevel ?? this.vendorLevel,
    vendorScore: vendorScore ?? this.vendorScore,
    bestStreak: bestStreak ?? this.bestStreak,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  VendorStateData copyWithCompanion(VendorStateCompanion data) {
    return VendorStateData(
      id: data.id.present ? data.id.value : this.id,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      vendorLevel: data.vendorLevel.present
          ? data.vendorLevel.value
          : this.vendorLevel,
      vendorScore: data.vendorScore.present
          ? data.vendorScore.value
          : this.vendorScore,
      bestStreak: data.bestStreak.present
          ? data.bestStreak.value
          : this.bestStreak,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VendorStateData(')
          ..write('id: $id, ')
          ..write('totalXp: $totalXp, ')
          ..write('vendorLevel: $vendorLevel, ')
          ..write('vendorScore: $vendorScore, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    totalXp,
    vendorLevel,
    vendorScore,
    bestStreak,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VendorStateData &&
          other.id == this.id &&
          other.totalXp == this.totalXp &&
          other.vendorLevel == this.vendorLevel &&
          other.vendorScore == this.vendorScore &&
          other.bestStreak == this.bestStreak &&
          other.updatedAtMs == this.updatedAtMs);
}

class VendorStateCompanion extends UpdateCompanion<VendorStateData> {
  final Value<int> id;
  final Value<int> totalXp;
  final Value<int> vendorLevel;
  final Value<double> vendorScore;
  final Value<int> bestStreak;
  final Value<int> updatedAtMs;
  const VendorStateCompanion({
    this.id = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.vendorLevel = const Value.absent(),
    this.vendorScore = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  VendorStateCompanion.insert({
    this.id = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.vendorLevel = const Value.absent(),
    this.vendorScore = const Value.absent(),
    this.bestStreak = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  static Insertable<VendorStateData> custom({
    Expression<int>? id,
    Expression<int>? totalXp,
    Expression<int>? vendorLevel,
    Expression<double>? vendorScore,
    Expression<int>? bestStreak,
    Expression<int>? updatedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalXp != null) 'total_xp': totalXp,
      if (vendorLevel != null) 'vendor_level': vendorLevel,
      if (vendorScore != null) 'vendor_score': vendorScore,
      if (bestStreak != null) 'best_streak': bestStreak,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
    });
  }

  VendorStateCompanion copyWith({
    Value<int>? id,
    Value<int>? totalXp,
    Value<int>? vendorLevel,
    Value<double>? vendorScore,
    Value<int>? bestStreak,
    Value<int>? updatedAtMs,
  }) {
    return VendorStateCompanion(
      id: id ?? this.id,
      totalXp: totalXp ?? this.totalXp,
      vendorLevel: vendorLevel ?? this.vendorLevel,
      vendorScore: vendorScore ?? this.vendorScore,
      bestStreak: bestStreak ?? this.bestStreak,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (vendorLevel.present) {
      map['vendor_level'] = Variable<int>(vendorLevel.value);
    }
    if (vendorScore.present) {
      map['vendor_score'] = Variable<double>(vendorScore.value);
    }
    if (bestStreak.present) {
      map['best_streak'] = Variable<int>(bestStreak.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendorStateCompanion(')
          ..write('id: $id, ')
          ..write('totalXp: $totalXp, ')
          ..write('vendorLevel: $vendorLevel, ')
          ..write('vendorScore: $vendorScore, ')
          ..write('bestStreak: $bestStreak, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }
}

class $VendorDailyStatsTable extends VendorDailyStats
    with TableInfo<$VendorDailyStatsTable, VendorDailyStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendorDailyStatsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _earnedXpMeta = const VerificationMeta(
    'earnedXp',
  );
  @override
  late final GeneratedColumn<int> earnedXp = GeneratedColumn<int>(
    'earned_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetXpMeta = const VerificationMeta(
    'targetXp',
  );
  @override
  late final GeneratedColumn<int> targetXp = GeneratedColumn<int>(
    'target_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(300),
  );
  static const VerificationMeta _hitHalfTargetFlagMeta = const VerificationMeta(
    'hitHalfTargetFlag',
  );
  @override
  late final GeneratedColumn<bool> hitHalfTargetFlag = GeneratedColumn<bool>(
    'hit_half_target_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hit_half_target_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _shopOpenedMeta = const VerificationMeta(
    'shopOpened',
  );
  @override
  late final GeneratedColumn<bool> shopOpened = GeneratedColumn<bool>(
    'shop_opened',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("shop_opened" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hitFullTargetFlagMeta = const VerificationMeta(
    'hitFullTargetFlag',
  );
  @override
  late final GeneratedColumn<bool> hitFullTargetFlag = GeneratedColumn<bool>(
    'hit_full_target_flag',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hit_full_target_flag" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notified30Meta = const VerificationMeta(
    'notified30',
  );
  @override
  late final GeneratedColumn<bool> notified30 = GeneratedColumn<bool>(
    'notified30',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notified30" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notified70Meta = const VerificationMeta(
    'notified70',
  );
  @override
  late final GeneratedColumn<bool> notified70 = GeneratedColumn<bool>(
    'notified70',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notified70" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notified100Meta = const VerificationMeta(
    'notified100',
  );
  @override
  late final GeneratedColumn<bool> notified100 = GeneratedColumn<bool>(
    'notified100',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notified100" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    dateKey,
    earnedXp,
    targetXp,
    hitHalfTargetFlag,
    shopOpened,
    hitFullTargetFlag,
    notified30,
    notified70,
    notified100,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendor_daily_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<VendorDailyStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date_key')) {
      context.handle(
        _dateKeyMeta,
        dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('earned_xp')) {
      context.handle(
        _earnedXpMeta,
        earnedXp.isAcceptableOrUnknown(data['earned_xp']!, _earnedXpMeta),
      );
    }
    if (data.containsKey('target_xp')) {
      context.handle(
        _targetXpMeta,
        targetXp.isAcceptableOrUnknown(data['target_xp']!, _targetXpMeta),
      );
    }
    if (data.containsKey('hit_half_target_flag')) {
      context.handle(
        _hitHalfTargetFlagMeta,
        hitHalfTargetFlag.isAcceptableOrUnknown(
          data['hit_half_target_flag']!,
          _hitHalfTargetFlagMeta,
        ),
      );
    }
    if (data.containsKey('shop_opened')) {
      context.handle(
        _shopOpenedMeta,
        shopOpened.isAcceptableOrUnknown(data['shop_opened']!, _shopOpenedMeta),
      );
    }
    if (data.containsKey('hit_full_target_flag')) {
      context.handle(
        _hitFullTargetFlagMeta,
        hitFullTargetFlag.isAcceptableOrUnknown(
          data['hit_full_target_flag']!,
          _hitFullTargetFlagMeta,
        ),
      );
    }
    if (data.containsKey('notified30')) {
      context.handle(
        _notified30Meta,
        notified30.isAcceptableOrUnknown(data['notified30']!, _notified30Meta),
      );
    }
    if (data.containsKey('notified70')) {
      context.handle(
        _notified70Meta,
        notified70.isAcceptableOrUnknown(data['notified70']!, _notified70Meta),
      );
    }
    if (data.containsKey('notified100')) {
      context.handle(
        _notified100Meta,
        notified100.isAcceptableOrUnknown(
          data['notified100']!,
          _notified100Meta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dateKey};
  @override
  VendorDailyStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VendorDailyStat(
      dateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_key'],
      )!,
      earnedXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}earned_xp'],
      )!,
      targetXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_xp'],
      )!,
      hitHalfTargetFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hit_half_target_flag'],
      )!,
      shopOpened: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}shop_opened'],
      )!,
      hitFullTargetFlag: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hit_full_target_flag'],
      )!,
      notified30: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notified30'],
      )!,
      notified70: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notified70'],
      )!,
      notified100: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notified100'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $VendorDailyStatsTable createAlias(String alias) {
    return $VendorDailyStatsTable(attachedDatabase, alias);
  }
}

class VendorDailyStat extends DataClass implements Insertable<VendorDailyStat> {
  final String dateKey;
  final int earnedXp;
  final int targetXp;
  final bool hitHalfTargetFlag;
  final bool shopOpened;
  final bool hitFullTargetFlag;
  final bool notified30;
  final bool notified70;
  final bool notified100;
  final int createdAtMs;
  final int updatedAtMs;
  const VendorDailyStat({
    required this.dateKey,
    required this.earnedXp,
    required this.targetXp,
    required this.hitHalfTargetFlag,
    required this.shopOpened,
    required this.hitFullTargetFlag,
    required this.notified30,
    required this.notified70,
    required this.notified100,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date_key'] = Variable<String>(dateKey);
    map['earned_xp'] = Variable<int>(earnedXp);
    map['target_xp'] = Variable<int>(targetXp);
    map['hit_half_target_flag'] = Variable<bool>(hitHalfTargetFlag);
    map['shop_opened'] = Variable<bool>(shopOpened);
    map['hit_full_target_flag'] = Variable<bool>(hitFullTargetFlag);
    map['notified30'] = Variable<bool>(notified30);
    map['notified70'] = Variable<bool>(notified70);
    map['notified100'] = Variable<bool>(notified100);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  VendorDailyStatsCompanion toCompanion(bool nullToAbsent) {
    return VendorDailyStatsCompanion(
      dateKey: Value(dateKey),
      earnedXp: Value(earnedXp),
      targetXp: Value(targetXp),
      hitHalfTargetFlag: Value(hitHalfTargetFlag),
      shopOpened: Value(shopOpened),
      hitFullTargetFlag: Value(hitFullTargetFlag),
      notified30: Value(notified30),
      notified70: Value(notified70),
      notified100: Value(notified100),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory VendorDailyStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VendorDailyStat(
      dateKey: serializer.fromJson<String>(json['dateKey']),
      earnedXp: serializer.fromJson<int>(json['earnedXp']),
      targetXp: serializer.fromJson<int>(json['targetXp']),
      hitHalfTargetFlag: serializer.fromJson<bool>(json['hitHalfTargetFlag']),
      shopOpened: serializer.fromJson<bool>(json['shopOpened']),
      hitFullTargetFlag: serializer.fromJson<bool>(json['hitFullTargetFlag']),
      notified30: serializer.fromJson<bool>(json['notified30']),
      notified70: serializer.fromJson<bool>(json['notified70']),
      notified100: serializer.fromJson<bool>(json['notified100']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dateKey': serializer.toJson<String>(dateKey),
      'earnedXp': serializer.toJson<int>(earnedXp),
      'targetXp': serializer.toJson<int>(targetXp),
      'hitHalfTargetFlag': serializer.toJson<bool>(hitHalfTargetFlag),
      'shopOpened': serializer.toJson<bool>(shopOpened),
      'hitFullTargetFlag': serializer.toJson<bool>(hitFullTargetFlag),
      'notified30': serializer.toJson<bool>(notified30),
      'notified70': serializer.toJson<bool>(notified70),
      'notified100': serializer.toJson<bool>(notified100),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  VendorDailyStat copyWith({
    String? dateKey,
    int? earnedXp,
    int? targetXp,
    bool? hitHalfTargetFlag,
    bool? shopOpened,
    bool? hitFullTargetFlag,
    bool? notified30,
    bool? notified70,
    bool? notified100,
    int? createdAtMs,
    int? updatedAtMs,
  }) => VendorDailyStat(
    dateKey: dateKey ?? this.dateKey,
    earnedXp: earnedXp ?? this.earnedXp,
    targetXp: targetXp ?? this.targetXp,
    hitHalfTargetFlag: hitHalfTargetFlag ?? this.hitHalfTargetFlag,
    shopOpened: shopOpened ?? this.shopOpened,
    hitFullTargetFlag: hitFullTargetFlag ?? this.hitFullTargetFlag,
    notified30: notified30 ?? this.notified30,
    notified70: notified70 ?? this.notified70,
    notified100: notified100 ?? this.notified100,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  VendorDailyStat copyWithCompanion(VendorDailyStatsCompanion data) {
    return VendorDailyStat(
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      earnedXp: data.earnedXp.present ? data.earnedXp.value : this.earnedXp,
      targetXp: data.targetXp.present ? data.targetXp.value : this.targetXp,
      hitHalfTargetFlag: data.hitHalfTargetFlag.present
          ? data.hitHalfTargetFlag.value
          : this.hitHalfTargetFlag,
      shopOpened: data.shopOpened.present
          ? data.shopOpened.value
          : this.shopOpened,
      hitFullTargetFlag: data.hitFullTargetFlag.present
          ? data.hitFullTargetFlag.value
          : this.hitFullTargetFlag,
      notified30: data.notified30.present
          ? data.notified30.value
          : this.notified30,
      notified70: data.notified70.present
          ? data.notified70.value
          : this.notified70,
      notified100: data.notified100.present
          ? data.notified100.value
          : this.notified100,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VendorDailyStat(')
          ..write('dateKey: $dateKey, ')
          ..write('earnedXp: $earnedXp, ')
          ..write('targetXp: $targetXp, ')
          ..write('hitHalfTargetFlag: $hitHalfTargetFlag, ')
          ..write('shopOpened: $shopOpened, ')
          ..write('hitFullTargetFlag: $hitFullTargetFlag, ')
          ..write('notified30: $notified30, ')
          ..write('notified70: $notified70, ')
          ..write('notified100: $notified100, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    dateKey,
    earnedXp,
    targetXp,
    hitHalfTargetFlag,
    shopOpened,
    hitFullTargetFlag,
    notified30,
    notified70,
    notified100,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VendorDailyStat &&
          other.dateKey == this.dateKey &&
          other.earnedXp == this.earnedXp &&
          other.targetXp == this.targetXp &&
          other.hitHalfTargetFlag == this.hitHalfTargetFlag &&
          other.shopOpened == this.shopOpened &&
          other.hitFullTargetFlag == this.hitFullTargetFlag &&
          other.notified30 == this.notified30 &&
          other.notified70 == this.notified70 &&
          other.notified100 == this.notified100 &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class VendorDailyStatsCompanion extends UpdateCompanion<VendorDailyStat> {
  final Value<String> dateKey;
  final Value<int> earnedXp;
  final Value<int> targetXp;
  final Value<bool> hitHalfTargetFlag;
  final Value<bool> shopOpened;
  final Value<bool> hitFullTargetFlag;
  final Value<bool> notified30;
  final Value<bool> notified70;
  final Value<bool> notified100;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const VendorDailyStatsCompanion({
    this.dateKey = const Value.absent(),
    this.earnedXp = const Value.absent(),
    this.targetXp = const Value.absent(),
    this.hitHalfTargetFlag = const Value.absent(),
    this.shopOpened = const Value.absent(),
    this.hitFullTargetFlag = const Value.absent(),
    this.notified30 = const Value.absent(),
    this.notified70 = const Value.absent(),
    this.notified100 = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VendorDailyStatsCompanion.insert({
    required String dateKey,
    this.earnedXp = const Value.absent(),
    this.targetXp = const Value.absent(),
    this.hitHalfTargetFlag = const Value.absent(),
    this.shopOpened = const Value.absent(),
    this.hitFullTargetFlag = const Value.absent(),
    this.notified30 = const Value.absent(),
    this.notified70 = const Value.absent(),
    this.notified100 = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : dateKey = Value(dateKey);
  static Insertable<VendorDailyStat> custom({
    Expression<String>? dateKey,
    Expression<int>? earnedXp,
    Expression<int>? targetXp,
    Expression<bool>? hitHalfTargetFlag,
    Expression<bool>? shopOpened,
    Expression<bool>? hitFullTargetFlag,
    Expression<bool>? notified30,
    Expression<bool>? notified70,
    Expression<bool>? notified100,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dateKey != null) 'date_key': dateKey,
      if (earnedXp != null) 'earned_xp': earnedXp,
      if (targetXp != null) 'target_xp': targetXp,
      if (hitHalfTargetFlag != null) 'hit_half_target_flag': hitHalfTargetFlag,
      if (shopOpened != null) 'shop_opened': shopOpened,
      if (hitFullTargetFlag != null) 'hit_full_target_flag': hitFullTargetFlag,
      if (notified30 != null) 'notified30': notified30,
      if (notified70 != null) 'notified70': notified70,
      if (notified100 != null) 'notified100': notified100,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VendorDailyStatsCompanion copyWith({
    Value<String>? dateKey,
    Value<int>? earnedXp,
    Value<int>? targetXp,
    Value<bool>? hitHalfTargetFlag,
    Value<bool>? shopOpened,
    Value<bool>? hitFullTargetFlag,
    Value<bool>? notified30,
    Value<bool>? notified70,
    Value<bool>? notified100,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return VendorDailyStatsCompanion(
      dateKey: dateKey ?? this.dateKey,
      earnedXp: earnedXp ?? this.earnedXp,
      targetXp: targetXp ?? this.targetXp,
      hitHalfTargetFlag: hitHalfTargetFlag ?? this.hitHalfTargetFlag,
      shopOpened: shopOpened ?? this.shopOpened,
      hitFullTargetFlag: hitFullTargetFlag ?? this.hitFullTargetFlag,
      notified30: notified30 ?? this.notified30,
      notified70: notified70 ?? this.notified70,
      notified100: notified100 ?? this.notified100,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (earnedXp.present) {
      map['earned_xp'] = Variable<int>(earnedXp.value);
    }
    if (targetXp.present) {
      map['target_xp'] = Variable<int>(targetXp.value);
    }
    if (hitHalfTargetFlag.present) {
      map['hit_half_target_flag'] = Variable<bool>(hitHalfTargetFlag.value);
    }
    if (shopOpened.present) {
      map['shop_opened'] = Variable<bool>(shopOpened.value);
    }
    if (hitFullTargetFlag.present) {
      map['hit_full_target_flag'] = Variable<bool>(hitFullTargetFlag.value);
    }
    if (notified30.present) {
      map['notified30'] = Variable<bool>(notified30.value);
    }
    if (notified70.present) {
      map['notified70'] = Variable<bool>(notified70.value);
    }
    if (notified100.present) {
      map['notified100'] = Variable<bool>(notified100.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendorDailyStatsCompanion(')
          ..write('dateKey: $dateKey, ')
          ..write('earnedXp: $earnedXp, ')
          ..write('targetXp: $targetXp, ')
          ..write('hitHalfTargetFlag: $hitHalfTargetFlag, ')
          ..write('shopOpened: $shopOpened, ')
          ..write('hitFullTargetFlag: $hitFullTargetFlag, ')
          ..write('notified30: $notified30, ')
          ..write('notified70: $notified70, ')
          ..write('notified100: $notified100, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalVendorProfilesTable extends LocalVendorProfiles
    with TableInfo<$LocalVendorProfilesTable, LocalVendorProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalVendorProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vendorIdMeta = const VerificationMeta(
    'vendorId',
  );
  @override
  late final GeneratedColumn<String> vendorId = GeneratedColumn<String>(
    'vendor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerUidMeta = const VerificationMeta(
    'ownerUid',
  );
  @override
  late final GeneratedColumn<String> ownerUid = GeneratedColumn<String>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopNameMeta = const VerificationMeta(
    'shopName',
  );
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
    'shop_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodCategoryMeta = const VerificationMeta(
    'foodCategory',
  );
  @override
  late final GeneratedColumn<String> foodCategory = GeneratedColumn<String>(
    'food_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _locationTextMeta = const VerificationMeta(
    'locationText',
  );
  @override
  late final GeneratedColumn<String> locationText = GeneratedColumn<String>(
    'location_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Bangladesh'),
  );
  static const VerificationMeta _preferredLanguageMeta = const VerificationMeta(
    'preferredLanguage',
  );
  @override
  late final GeneratedColumn<String> preferredLanguage =
      GeneratedColumn<String>(
        'preferred_language',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('en'),
      );
  static const VerificationMeta _profileImageUrlMeta = const VerificationMeta(
    'profileImageUrl',
  );
  @override
  late final GeneratedColumn<String> profileImageUrl = GeneratedColumn<String>(
    'profile_image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewUrlMeta = const VerificationMeta(
    'reviewUrl',
  );
  @override
  late final GeneratedColumn<String> reviewUrl = GeneratedColumn<String>(
    'review_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _averageRatingMeta = const VerificationMeta(
    'averageRating',
  );
  @override
  late final GeneratedColumn<double> averageRating = GeneratedColumn<double>(
    'average_rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReviewCommentMeta = const VerificationMeta(
    'lastReviewComment',
  );
  @override
  late final GeneratedColumn<String> lastReviewComment =
      GeneratedColumn<String>(
        'last_review_comment',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMsMeta = const VerificationMeta(
    'lastSyncedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAtMs = GeneratedColumn<int>(
    'last_synced_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    vendorId,
    ownerUid,
    vendorName,
    shopName,
    foodCategory,
    description,
    phoneNumber,
    locationText,
    city,
    country,
    preferredLanguage,
    profileImageUrl,
    reviewUrl,
    averageRating,
    reviewCount,
    lastReviewComment,
    createdAtMs,
    updatedAtMs,
    lastSyncedAtMs,
    isDirty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_vendor_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalVendorProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vendor_id')) {
      context.handle(
        _vendorIdMeta,
        vendorId.isAcceptableOrUnknown(data['vendor_id']!, _vendorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vendorIdMeta);
    }
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_vendorNameMeta);
    }
    if (data.containsKey('shop_name')) {
      context.handle(
        _shopNameMeta,
        shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta),
      );
    } else if (isInserting) {
      context.missing(_shopNameMeta);
    }
    if (data.containsKey('food_category')) {
      context.handle(
        _foodCategoryMeta,
        foodCategory.isAcceptableOrUnknown(
          data['food_category']!,
          _foodCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_foodCategoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('location_text')) {
      context.handle(
        _locationTextMeta,
        locationText.isAcceptableOrUnknown(
          data['location_text']!,
          _locationTextMeta,
        ),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('preferred_language')) {
      context.handle(
        _preferredLanguageMeta,
        preferredLanguage.isAcceptableOrUnknown(
          data['preferred_language']!,
          _preferredLanguageMeta,
        ),
      );
    }
    if (data.containsKey('profile_image_url')) {
      context.handle(
        _profileImageUrlMeta,
        profileImageUrl.isAcceptableOrUnknown(
          data['profile_image_url']!,
          _profileImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('review_url')) {
      context.handle(
        _reviewUrlMeta,
        reviewUrl.isAcceptableOrUnknown(data['review_url']!, _reviewUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewUrlMeta);
    }
    if (data.containsKey('average_rating')) {
      context.handle(
        _averageRatingMeta,
        averageRating.isAcceptableOrUnknown(
          data['average_rating']!,
          _averageRatingMeta,
        ),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('last_review_comment')) {
      context.handle(
        _lastReviewCommentMeta,
        lastReviewComment.isAcceptableOrUnknown(
          data['last_review_comment']!,
          _lastReviewCommentMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('last_synced_at_ms')) {
      context.handle(
        _lastSyncedAtMsMeta,
        lastSyncedAtMs.isAcceptableOrUnknown(
          data['last_synced_at_ms']!,
          _lastSyncedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vendorId};
  @override
  LocalVendorProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalVendorProfile(
      vendorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_id'],
      )!,
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_uid'],
      )!,
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      )!,
      shopName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_name'],
      )!,
      foodCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      locationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_text'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      preferredLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_language'],
      )!,
      profileImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_image_url'],
      ),
      reviewUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_url'],
      )!,
      averageRating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_rating'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      lastReviewComment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_review_comment'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      lastSyncedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at_ms'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
    );
  }

  @override
  $LocalVendorProfilesTable createAlias(String alias) {
    return $LocalVendorProfilesTable(attachedDatabase, alias);
  }
}

class LocalVendorProfile extends DataClass
    implements Insertable<LocalVendorProfile> {
  final String vendorId;
  final String ownerUid;
  final String vendorName;
  final String shopName;
  final String foodCategory;
  final String description;
  final String phoneNumber;
  final String locationText;
  final String city;
  final String country;
  final String preferredLanguage;
  final String? profileImageUrl;
  final String reviewUrl;
  final double averageRating;
  final int reviewCount;
  final String? lastReviewComment;
  final int createdAtMs;
  final int updatedAtMs;
  final int lastSyncedAtMs;
  final bool isDirty;
  const LocalVendorProfile({
    required this.vendorId,
    required this.ownerUid,
    required this.vendorName,
    required this.shopName,
    required this.foodCategory,
    required this.description,
    required this.phoneNumber,
    required this.locationText,
    required this.city,
    required this.country,
    required this.preferredLanguage,
    this.profileImageUrl,
    required this.reviewUrl,
    required this.averageRating,
    required this.reviewCount,
    this.lastReviewComment,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.lastSyncedAtMs,
    required this.isDirty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vendor_id'] = Variable<String>(vendorId);
    map['owner_uid'] = Variable<String>(ownerUid);
    map['vendor_name'] = Variable<String>(vendorName);
    map['shop_name'] = Variable<String>(shopName);
    map['food_category'] = Variable<String>(foodCategory);
    map['description'] = Variable<String>(description);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['location_text'] = Variable<String>(locationText);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    map['preferred_language'] = Variable<String>(preferredLanguage);
    if (!nullToAbsent || profileImageUrl != null) {
      map['profile_image_url'] = Variable<String>(profileImageUrl);
    }
    map['review_url'] = Variable<String>(reviewUrl);
    map['average_rating'] = Variable<double>(averageRating);
    map['review_count'] = Variable<int>(reviewCount);
    if (!nullToAbsent || lastReviewComment != null) {
      map['last_review_comment'] = Variable<String>(lastReviewComment);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  LocalVendorProfilesCompanion toCompanion(bool nullToAbsent) {
    return LocalVendorProfilesCompanion(
      vendorId: Value(vendorId),
      ownerUid: Value(ownerUid),
      vendorName: Value(vendorName),
      shopName: Value(shopName),
      foodCategory: Value(foodCategory),
      description: Value(description),
      phoneNumber: Value(phoneNumber),
      locationText: Value(locationText),
      city: Value(city),
      country: Value(country),
      preferredLanguage: Value(preferredLanguage),
      profileImageUrl: profileImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImageUrl),
      reviewUrl: Value(reviewUrl),
      averageRating: Value(averageRating),
      reviewCount: Value(reviewCount),
      lastReviewComment: lastReviewComment == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewComment),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      lastSyncedAtMs: Value(lastSyncedAtMs),
      isDirty: Value(isDirty),
    );
  }

  factory LocalVendorProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalVendorProfile(
      vendorId: serializer.fromJson<String>(json['vendorId']),
      ownerUid: serializer.fromJson<String>(json['ownerUid']),
      vendorName: serializer.fromJson<String>(json['vendorName']),
      shopName: serializer.fromJson<String>(json['shopName']),
      foodCategory: serializer.fromJson<String>(json['foodCategory']),
      description: serializer.fromJson<String>(json['description']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      locationText: serializer.fromJson<String>(json['locationText']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      preferredLanguage: serializer.fromJson<String>(json['preferredLanguage']),
      profileImageUrl: serializer.fromJson<String?>(json['profileImageUrl']),
      reviewUrl: serializer.fromJson<String>(json['reviewUrl']),
      averageRating: serializer.fromJson<double>(json['averageRating']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      lastReviewComment: serializer.fromJson<String?>(
        json['lastReviewComment'],
      ),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      lastSyncedAtMs: serializer.fromJson<int>(json['lastSyncedAtMs']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vendorId': serializer.toJson<String>(vendorId),
      'ownerUid': serializer.toJson<String>(ownerUid),
      'vendorName': serializer.toJson<String>(vendorName),
      'shopName': serializer.toJson<String>(shopName),
      'foodCategory': serializer.toJson<String>(foodCategory),
      'description': serializer.toJson<String>(description),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'locationText': serializer.toJson<String>(locationText),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'preferredLanguage': serializer.toJson<String>(preferredLanguage),
      'profileImageUrl': serializer.toJson<String?>(profileImageUrl),
      'reviewUrl': serializer.toJson<String>(reviewUrl),
      'averageRating': serializer.toJson<double>(averageRating),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'lastReviewComment': serializer.toJson<String?>(lastReviewComment),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'lastSyncedAtMs': serializer.toJson<int>(lastSyncedAtMs),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  LocalVendorProfile copyWith({
    String? vendorId,
    String? ownerUid,
    String? vendorName,
    String? shopName,
    String? foodCategory,
    String? description,
    String? phoneNumber,
    String? locationText,
    String? city,
    String? country,
    String? preferredLanguage,
    Value<String?> profileImageUrl = const Value.absent(),
    String? reviewUrl,
    double? averageRating,
    int? reviewCount,
    Value<String?> lastReviewComment = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    int? lastSyncedAtMs,
    bool? isDirty,
  }) => LocalVendorProfile(
    vendorId: vendorId ?? this.vendorId,
    ownerUid: ownerUid ?? this.ownerUid,
    vendorName: vendorName ?? this.vendorName,
    shopName: shopName ?? this.shopName,
    foodCategory: foodCategory ?? this.foodCategory,
    description: description ?? this.description,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    locationText: locationText ?? this.locationText,
    city: city ?? this.city,
    country: country ?? this.country,
    preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    profileImageUrl: profileImageUrl.present
        ? profileImageUrl.value
        : this.profileImageUrl,
    reviewUrl: reviewUrl ?? this.reviewUrl,
    averageRating: averageRating ?? this.averageRating,
    reviewCount: reviewCount ?? this.reviewCount,
    lastReviewComment: lastReviewComment.present
        ? lastReviewComment.value
        : this.lastReviewComment,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    lastSyncedAtMs: lastSyncedAtMs ?? this.lastSyncedAtMs,
    isDirty: isDirty ?? this.isDirty,
  );
  LocalVendorProfile copyWithCompanion(LocalVendorProfilesCompanion data) {
    return LocalVendorProfile(
      vendorId: data.vendorId.present ? data.vendorId.value : this.vendorId,
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      foodCategory: data.foodCategory.present
          ? data.foodCategory.value
          : this.foodCategory,
      description: data.description.present
          ? data.description.value
          : this.description,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      locationText: data.locationText.present
          ? data.locationText.value
          : this.locationText,
      city: data.city.present ? data.city.value : this.city,
      country: data.country.present ? data.country.value : this.country,
      preferredLanguage: data.preferredLanguage.present
          ? data.preferredLanguage.value
          : this.preferredLanguage,
      profileImageUrl: data.profileImageUrl.present
          ? data.profileImageUrl.value
          : this.profileImageUrl,
      reviewUrl: data.reviewUrl.present ? data.reviewUrl.value : this.reviewUrl,
      averageRating: data.averageRating.present
          ? data.averageRating.value
          : this.averageRating,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      lastReviewComment: data.lastReviewComment.present
          ? data.lastReviewComment.value
          : this.lastReviewComment,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      lastSyncedAtMs: data.lastSyncedAtMs.present
          ? data.lastSyncedAtMs.value
          : this.lastSyncedAtMs,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalVendorProfile(')
          ..write('vendorId: $vendorId, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('vendorName: $vendorName, ')
          ..write('shopName: $shopName, ')
          ..write('foodCategory: $foodCategory, ')
          ..write('description: $description, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('locationText: $locationText, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('reviewUrl: $reviewUrl, ')
          ..write('averageRating: $averageRating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lastReviewComment: $lastReviewComment, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    vendorId,
    ownerUid,
    vendorName,
    shopName,
    foodCategory,
    description,
    phoneNumber,
    locationText,
    city,
    country,
    preferredLanguage,
    profileImageUrl,
    reviewUrl,
    averageRating,
    reviewCount,
    lastReviewComment,
    createdAtMs,
    updatedAtMs,
    lastSyncedAtMs,
    isDirty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalVendorProfile &&
          other.vendorId == this.vendorId &&
          other.ownerUid == this.ownerUid &&
          other.vendorName == this.vendorName &&
          other.shopName == this.shopName &&
          other.foodCategory == this.foodCategory &&
          other.description == this.description &&
          other.phoneNumber == this.phoneNumber &&
          other.locationText == this.locationText &&
          other.city == this.city &&
          other.country == this.country &&
          other.preferredLanguage == this.preferredLanguage &&
          other.profileImageUrl == this.profileImageUrl &&
          other.reviewUrl == this.reviewUrl &&
          other.averageRating == this.averageRating &&
          other.reviewCount == this.reviewCount &&
          other.lastReviewComment == this.lastReviewComment &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.lastSyncedAtMs == this.lastSyncedAtMs &&
          other.isDirty == this.isDirty);
}

class LocalVendorProfilesCompanion extends UpdateCompanion<LocalVendorProfile> {
  final Value<String> vendorId;
  final Value<String> ownerUid;
  final Value<String> vendorName;
  final Value<String> shopName;
  final Value<String> foodCategory;
  final Value<String> description;
  final Value<String> phoneNumber;
  final Value<String> locationText;
  final Value<String> city;
  final Value<String> country;
  final Value<String> preferredLanguage;
  final Value<String?> profileImageUrl;
  final Value<String> reviewUrl;
  final Value<double> averageRating;
  final Value<int> reviewCount;
  final Value<String?> lastReviewComment;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> lastSyncedAtMs;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const LocalVendorProfilesCompanion({
    this.vendorId = const Value.absent(),
    this.ownerUid = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.shopName = const Value.absent(),
    this.foodCategory = const Value.absent(),
    this.description = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.locationText = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    this.reviewUrl = const Value.absent(),
    this.averageRating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lastReviewComment = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.lastSyncedAtMs = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalVendorProfilesCompanion.insert({
    required String vendorId,
    required String ownerUid,
    required String vendorName,
    required String shopName,
    required String foodCategory,
    this.description = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.locationText = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.profileImageUrl = const Value.absent(),
    required String reviewUrl,
    this.averageRating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lastReviewComment = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.lastSyncedAtMs = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : vendorId = Value(vendorId),
       ownerUid = Value(ownerUid),
       vendorName = Value(vendorName),
       shopName = Value(shopName),
       foodCategory = Value(foodCategory),
       reviewUrl = Value(reviewUrl),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LocalVendorProfile> custom({
    Expression<String>? vendorId,
    Expression<String>? ownerUid,
    Expression<String>? vendorName,
    Expression<String>? shopName,
    Expression<String>? foodCategory,
    Expression<String>? description,
    Expression<String>? phoneNumber,
    Expression<String>? locationText,
    Expression<String>? city,
    Expression<String>? country,
    Expression<String>? preferredLanguage,
    Expression<String>? profileImageUrl,
    Expression<String>? reviewUrl,
    Expression<double>? averageRating,
    Expression<int>? reviewCount,
    Expression<String>? lastReviewComment,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? lastSyncedAtMs,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vendorId != null) 'vendor_id': vendorId,
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (vendorName != null) 'vendor_name': vendorName,
      if (shopName != null) 'shop_name': shopName,
      if (foodCategory != null) 'food_category': foodCategory,
      if (description != null) 'description': description,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (locationText != null) 'location_text': locationText,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (preferredLanguage != null) 'preferred_language': preferredLanguage,
      if (profileImageUrl != null) 'profile_image_url': profileImageUrl,
      if (reviewUrl != null) 'review_url': reviewUrl,
      if (averageRating != null) 'average_rating': averageRating,
      if (reviewCount != null) 'review_count': reviewCount,
      if (lastReviewComment != null) 'last_review_comment': lastReviewComment,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (lastSyncedAtMs != null) 'last_synced_at_ms': lastSyncedAtMs,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalVendorProfilesCompanion copyWith({
    Value<String>? vendorId,
    Value<String>? ownerUid,
    Value<String>? vendorName,
    Value<String>? shopName,
    Value<String>? foodCategory,
    Value<String>? description,
    Value<String>? phoneNumber,
    Value<String>? locationText,
    Value<String>? city,
    Value<String>? country,
    Value<String>? preferredLanguage,
    Value<String?>? profileImageUrl,
    Value<String>? reviewUrl,
    Value<double>? averageRating,
    Value<int>? reviewCount,
    Value<String?>? lastReviewComment,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? lastSyncedAtMs,
    Value<bool>? isDirty,
    Value<int>? rowid,
  }) {
    return LocalVendorProfilesCompanion(
      vendorId: vendorId ?? this.vendorId,
      ownerUid: ownerUid ?? this.ownerUid,
      vendorName: vendorName ?? this.vendorName,
      shopName: shopName ?? this.shopName,
      foodCategory: foodCategory ?? this.foodCategory,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      locationText: locationText ?? this.locationText,
      city: city ?? this.city,
      country: country ?? this.country,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      reviewUrl: reviewUrl ?? this.reviewUrl,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      lastReviewComment: lastReviewComment ?? this.lastReviewComment,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      lastSyncedAtMs: lastSyncedAtMs ?? this.lastSyncedAtMs,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vendorId.present) {
      map['vendor_id'] = Variable<String>(vendorId.value);
    }
    if (ownerUid.present) {
      map['owner_uid'] = Variable<String>(ownerUid.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (foodCategory.present) {
      map['food_category'] = Variable<String>(foodCategory.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (locationText.present) {
      map['location_text'] = Variable<String>(locationText.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (preferredLanguage.present) {
      map['preferred_language'] = Variable<String>(preferredLanguage.value);
    }
    if (profileImageUrl.present) {
      map['profile_image_url'] = Variable<String>(profileImageUrl.value);
    }
    if (reviewUrl.present) {
      map['review_url'] = Variable<String>(reviewUrl.value);
    }
    if (averageRating.present) {
      map['average_rating'] = Variable<double>(averageRating.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (lastReviewComment.present) {
      map['last_review_comment'] = Variable<String>(lastReviewComment.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (lastSyncedAtMs.present) {
      map['last_synced_at_ms'] = Variable<int>(lastSyncedAtMs.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalVendorProfilesCompanion(')
          ..write('vendorId: $vendorId, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('vendorName: $vendorName, ')
          ..write('shopName: $shopName, ')
          ..write('foodCategory: $foodCategory, ')
          ..write('description: $description, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('locationText: $locationText, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('profileImageUrl: $profileImageUrl, ')
          ..write('reviewUrl: $reviewUrl, ')
          ..write('averageRating: $averageRating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lastReviewComment: $lastReviewComment, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('lastSyncedAtMs: $lastSyncedAtMs, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    createdAtMs,
    retryCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String entityType;
  final String entityId;
  final String operation;
  final String payloadJson;
  final int createdAtMs;
  final int retryCount;
  final String? lastError;
  const SyncQueueData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadJson,
    required this.createdAtMs,
    required this.retryCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      createdAtMs: Value(createdAtMs),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? entityType,
    String? entityId,
    String? operation,
    String? payloadJson,
    int? createdAtMs,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    createdAtMs,
    retryCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.createdAtMs == this.createdAtMs &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<int> createdAtMs;
  final Value<int> retryCount;
  final Value<String?> lastError;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String operation,
    required String payloadJson,
    required int createdAtMs,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payloadJson = Value(payloadJson),
       createdAtMs = Value(createdAtMs);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? createdAtMs,
    Expression<int>? retryCount,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<int>? createdAtMs,
    Value<int>? retryCount,
    Value<String?>? lastError,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TaskLogsTable taskLogs = $TaskLogsTable(this);
  late final $ShopStateTable shopState = $ShopStateTable(this);
  late final $VendorStateTable vendorState = $VendorStateTable(this);
  late final $VendorDailyStatsTable vendorDailyStats = $VendorDailyStatsTable(
    this,
  );
  late final $LocalVendorProfilesTable localVendorProfiles =
      $LocalVendorProfilesTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tasks,
    taskLogs,
    shopState,
    vendorState,
    vendorDailyStats,
    localVendorProfiles,
    syncQueue,
  ];
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
typedef $$ShopStateTableCreateCompanionBuilder =
    ShopStateCompanion Function({
      Value<int> id,
      Value<bool> isOpen,
      Value<int> openedAtMs,
    });
typedef $$ShopStateTableUpdateCompanionBuilder =
    ShopStateCompanion Function({
      Value<int> id,
      Value<bool> isOpen,
      Value<int> openedAtMs,
    });

class $$ShopStateTableFilterComposer
    extends Composer<_$AppDb, $ShopStateTable> {
  $$ShopStateTableFilterComposer({
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

  ColumnFilters<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openedAtMs => $composableBuilder(
    column: $table.openedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopStateTableOrderingComposer
    extends Composer<_$AppDb, $ShopStateTable> {
  $$ShopStateTableOrderingComposer({
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

  ColumnOrderings<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openedAtMs => $composableBuilder(
    column: $table.openedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopStateTableAnnotationComposer
    extends Composer<_$AppDb, $ShopStateTable> {
  $$ShopStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isOpen =>
      $composableBuilder(column: $table.isOpen, builder: (column) => column);

  GeneratedColumn<int> get openedAtMs => $composableBuilder(
    column: $table.openedAtMs,
    builder: (column) => column,
  );
}

class $$ShopStateTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $ShopStateTable,
          ShopStateData,
          $$ShopStateTableFilterComposer,
          $$ShopStateTableOrderingComposer,
          $$ShopStateTableAnnotationComposer,
          $$ShopStateTableCreateCompanionBuilder,
          $$ShopStateTableUpdateCompanionBuilder,
          (
            ShopStateData,
            BaseReferences<_$AppDb, $ShopStateTable, ShopStateData>,
          ),
          ShopStateData,
          PrefetchHooks Function()
        > {
  $$ShopStateTableTableManager(_$AppDb db, $ShopStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isOpen = const Value.absent(),
                Value<int> openedAtMs = const Value.absent(),
              }) => ShopStateCompanion(
                id: id,
                isOpen: isOpen,
                openedAtMs: openedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isOpen = const Value.absent(),
                Value<int> openedAtMs = const Value.absent(),
              }) => ShopStateCompanion.insert(
                id: id,
                isOpen: isOpen,
                openedAtMs: openedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $ShopStateTable,
      ShopStateData,
      $$ShopStateTableFilterComposer,
      $$ShopStateTableOrderingComposer,
      $$ShopStateTableAnnotationComposer,
      $$ShopStateTableCreateCompanionBuilder,
      $$ShopStateTableUpdateCompanionBuilder,
      (ShopStateData, BaseReferences<_$AppDb, $ShopStateTable, ShopStateData>),
      ShopStateData,
      PrefetchHooks Function()
    >;
typedef $$VendorStateTableCreateCompanionBuilder =
    VendorStateCompanion Function({
      Value<int> id,
      Value<int> totalXp,
      Value<int> vendorLevel,
      Value<double> vendorScore,
      Value<int> bestStreak,
      Value<int> updatedAtMs,
    });
typedef $$VendorStateTableUpdateCompanionBuilder =
    VendorStateCompanion Function({
      Value<int> id,
      Value<int> totalXp,
      Value<int> vendorLevel,
      Value<double> vendorScore,
      Value<int> bestStreak,
      Value<int> updatedAtMs,
    });

class $$VendorStateTableFilterComposer
    extends Composer<_$AppDb, $VendorStateTable> {
  $$VendorStateTableFilterComposer({
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

  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vendorLevel => $composableBuilder(
    column: $table.vendorLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vendorScore => $composableBuilder(
    column: $table.vendorScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VendorStateTableOrderingComposer
    extends Composer<_$AppDb, $VendorStateTable> {
  $$VendorStateTableOrderingComposer({
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

  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vendorLevel => $composableBuilder(
    column: $table.vendorLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vendorScore => $composableBuilder(
    column: $table.vendorScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VendorStateTableAnnotationComposer
    extends Composer<_$AppDb, $VendorStateTable> {
  $$VendorStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get vendorLevel => $composableBuilder(
    column: $table.vendorLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get vendorScore => $composableBuilder(
    column: $table.vendorScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bestStreak => $composableBuilder(
    column: $table.bestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$VendorStateTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $VendorStateTable,
          VendorStateData,
          $$VendorStateTableFilterComposer,
          $$VendorStateTableOrderingComposer,
          $$VendorStateTableAnnotationComposer,
          $$VendorStateTableCreateCompanionBuilder,
          $$VendorStateTableUpdateCompanionBuilder,
          (
            VendorStateData,
            BaseReferences<_$AppDb, $VendorStateTable, VendorStateData>,
          ),
          VendorStateData,
          PrefetchHooks Function()
        > {
  $$VendorStateTableTableManager(_$AppDb db, $VendorStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendorStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendorStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VendorStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> vendorLevel = const Value.absent(),
                Value<double> vendorScore = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => VendorStateCompanion(
                id: id,
                totalXp: totalXp,
                vendorLevel: vendorLevel,
                vendorScore: vendorScore,
                bestStreak: bestStreak,
                updatedAtMs: updatedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> vendorLevel = const Value.absent(),
                Value<double> vendorScore = const Value.absent(),
                Value<int> bestStreak = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => VendorStateCompanion.insert(
                id: id,
                totalXp: totalXp,
                vendorLevel: vendorLevel,
                vendorScore: vendorScore,
                bestStreak: bestStreak,
                updatedAtMs: updatedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VendorStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $VendorStateTable,
      VendorStateData,
      $$VendorStateTableFilterComposer,
      $$VendorStateTableOrderingComposer,
      $$VendorStateTableAnnotationComposer,
      $$VendorStateTableCreateCompanionBuilder,
      $$VendorStateTableUpdateCompanionBuilder,
      (
        VendorStateData,
        BaseReferences<_$AppDb, $VendorStateTable, VendorStateData>,
      ),
      VendorStateData,
      PrefetchHooks Function()
    >;
typedef $$VendorDailyStatsTableCreateCompanionBuilder =
    VendorDailyStatsCompanion Function({
      required String dateKey,
      Value<int> earnedXp,
      Value<int> targetXp,
      Value<bool> hitHalfTargetFlag,
      Value<bool> shopOpened,
      Value<bool> hitFullTargetFlag,
      Value<bool> notified30,
      Value<bool> notified70,
      Value<bool> notified100,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });
typedef $$VendorDailyStatsTableUpdateCompanionBuilder =
    VendorDailyStatsCompanion Function({
      Value<String> dateKey,
      Value<int> earnedXp,
      Value<int> targetXp,
      Value<bool> hitHalfTargetFlag,
      Value<bool> shopOpened,
      Value<bool> hitFullTargetFlag,
      Value<bool> notified30,
      Value<bool> notified70,
      Value<bool> notified100,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

class $$VendorDailyStatsTableFilterComposer
    extends Composer<_$AppDb, $VendorDailyStatsTable> {
  $$VendorDailyStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get earnedXp => $composableBuilder(
    column: $table.earnedXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetXp => $composableBuilder(
    column: $table.targetXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hitHalfTargetFlag => $composableBuilder(
    column: $table.hitHalfTargetFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get shopOpened => $composableBuilder(
    column: $table.shopOpened,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hitFullTargetFlag => $composableBuilder(
    column: $table.hitFullTargetFlag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notified30 => $composableBuilder(
    column: $table.notified30,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notified70 => $composableBuilder(
    column: $table.notified70,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notified100 => $composableBuilder(
    column: $table.notified100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VendorDailyStatsTableOrderingComposer
    extends Composer<_$AppDb, $VendorDailyStatsTable> {
  $$VendorDailyStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dateKey => $composableBuilder(
    column: $table.dateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get earnedXp => $composableBuilder(
    column: $table.earnedXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetXp => $composableBuilder(
    column: $table.targetXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hitHalfTargetFlag => $composableBuilder(
    column: $table.hitHalfTargetFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get shopOpened => $composableBuilder(
    column: $table.shopOpened,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hitFullTargetFlag => $composableBuilder(
    column: $table.hitFullTargetFlag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notified30 => $composableBuilder(
    column: $table.notified30,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notified70 => $composableBuilder(
    column: $table.notified70,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notified100 => $composableBuilder(
    column: $table.notified100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VendorDailyStatsTableAnnotationComposer
    extends Composer<_$AppDb, $VendorDailyStatsTable> {
  $$VendorDailyStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<int> get earnedXp =>
      $composableBuilder(column: $table.earnedXp, builder: (column) => column);

  GeneratedColumn<int> get targetXp =>
      $composableBuilder(column: $table.targetXp, builder: (column) => column);

  GeneratedColumn<bool> get hitHalfTargetFlag => $composableBuilder(
    column: $table.hitHalfTargetFlag,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get shopOpened => $composableBuilder(
    column: $table.shopOpened,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hitFullTargetFlag => $composableBuilder(
    column: $table.hitFullTargetFlag,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notified30 => $composableBuilder(
    column: $table.notified30,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notified70 => $composableBuilder(
    column: $table.notified70,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notified100 => $composableBuilder(
    column: $table.notified100,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$VendorDailyStatsTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $VendorDailyStatsTable,
          VendorDailyStat,
          $$VendorDailyStatsTableFilterComposer,
          $$VendorDailyStatsTableOrderingComposer,
          $$VendorDailyStatsTableAnnotationComposer,
          $$VendorDailyStatsTableCreateCompanionBuilder,
          $$VendorDailyStatsTableUpdateCompanionBuilder,
          (
            VendorDailyStat,
            BaseReferences<_$AppDb, $VendorDailyStatsTable, VendorDailyStat>,
          ),
          VendorDailyStat,
          PrefetchHooks Function()
        > {
  $$VendorDailyStatsTableTableManager(_$AppDb db, $VendorDailyStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendorDailyStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendorDailyStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VendorDailyStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> dateKey = const Value.absent(),
                Value<int> earnedXp = const Value.absent(),
                Value<int> targetXp = const Value.absent(),
                Value<bool> hitHalfTargetFlag = const Value.absent(),
                Value<bool> shopOpened = const Value.absent(),
                Value<bool> hitFullTargetFlag = const Value.absent(),
                Value<bool> notified30 = const Value.absent(),
                Value<bool> notified70 = const Value.absent(),
                Value<bool> notified100 = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VendorDailyStatsCompanion(
                dateKey: dateKey,
                earnedXp: earnedXp,
                targetXp: targetXp,
                hitHalfTargetFlag: hitHalfTargetFlag,
                shopOpened: shopOpened,
                hitFullTargetFlag: hitFullTargetFlag,
                notified30: notified30,
                notified70: notified70,
                notified100: notified100,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dateKey,
                Value<int> earnedXp = const Value.absent(),
                Value<int> targetXp = const Value.absent(),
                Value<bool> hitHalfTargetFlag = const Value.absent(),
                Value<bool> shopOpened = const Value.absent(),
                Value<bool> hitFullTargetFlag = const Value.absent(),
                Value<bool> notified30 = const Value.absent(),
                Value<bool> notified70 = const Value.absent(),
                Value<bool> notified100 = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VendorDailyStatsCompanion.insert(
                dateKey: dateKey,
                earnedXp: earnedXp,
                targetXp: targetXp,
                hitHalfTargetFlag: hitHalfTargetFlag,
                shopOpened: shopOpened,
                hitFullTargetFlag: hitFullTargetFlag,
                notified30: notified30,
                notified70: notified70,
                notified100: notified100,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VendorDailyStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $VendorDailyStatsTable,
      VendorDailyStat,
      $$VendorDailyStatsTableFilterComposer,
      $$VendorDailyStatsTableOrderingComposer,
      $$VendorDailyStatsTableAnnotationComposer,
      $$VendorDailyStatsTableCreateCompanionBuilder,
      $$VendorDailyStatsTableUpdateCompanionBuilder,
      (
        VendorDailyStat,
        BaseReferences<_$AppDb, $VendorDailyStatsTable, VendorDailyStat>,
      ),
      VendorDailyStat,
      PrefetchHooks Function()
    >;
typedef $$LocalVendorProfilesTableCreateCompanionBuilder =
    LocalVendorProfilesCompanion Function({
      required String vendorId,
      required String ownerUid,
      required String vendorName,
      required String shopName,
      required String foodCategory,
      Value<String> description,
      Value<String> phoneNumber,
      Value<String> locationText,
      Value<String> city,
      Value<String> country,
      Value<String> preferredLanguage,
      Value<String?> profileImageUrl,
      required String reviewUrl,
      Value<double> averageRating,
      Value<int> reviewCount,
      Value<String?> lastReviewComment,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int> lastSyncedAtMs,
      Value<bool> isDirty,
      Value<int> rowid,
    });
typedef $$LocalVendorProfilesTableUpdateCompanionBuilder =
    LocalVendorProfilesCompanion Function({
      Value<String> vendorId,
      Value<String> ownerUid,
      Value<String> vendorName,
      Value<String> shopName,
      Value<String> foodCategory,
      Value<String> description,
      Value<String> phoneNumber,
      Value<String> locationText,
      Value<String> city,
      Value<String> country,
      Value<String> preferredLanguage,
      Value<String?> profileImageUrl,
      Value<String> reviewUrl,
      Value<double> averageRating,
      Value<int> reviewCount,
      Value<String?> lastReviewComment,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int> lastSyncedAtMs,
      Value<bool> isDirty,
      Value<int> rowid,
    });

class $$LocalVendorProfilesTableFilterComposer
    extends Composer<_$AppDb, $LocalVendorProfilesTable> {
  $$LocalVendorProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodCategory => $composableBuilder(
    column: $table.foodCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profileImageUrl => $composableBuilder(
    column: $table.profileImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reviewUrl => $composableBuilder(
    column: $table.reviewUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageRating => $composableBuilder(
    column: $table.averageRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastReviewComment => $composableBuilder(
    column: $table.lastReviewComment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalVendorProfilesTableOrderingComposer
    extends Composer<_$AppDb, $LocalVendorProfilesTable> {
  $$LocalVendorProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodCategory => $composableBuilder(
    column: $table.foodCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileImageUrl => $composableBuilder(
    column: $table.profileImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reviewUrl => $composableBuilder(
    column: $table.reviewUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageRating => $composableBuilder(
    column: $table.averageRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastReviewComment => $composableBuilder(
    column: $table.lastReviewComment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalVendorProfilesTableAnnotationComposer
    extends Composer<_$AppDb, $LocalVendorProfilesTable> {
  $$LocalVendorProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get vendorId =>
      $composableBuilder(column: $table.vendorId, builder: (column) => column);

  GeneratedColumn<String> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<String> get foodCategory => $composableBuilder(
    column: $table.foodCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profileImageUrl => $composableBuilder(
    column: $table.profileImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reviewUrl =>
      $composableBuilder(column: $table.reviewUrl, builder: (column) => column);

  GeneratedColumn<double> get averageRating => $composableBuilder(
    column: $table.averageRating,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastReviewComment => $composableBuilder(
    column: $table.lastReviewComment,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastSyncedAtMs => $composableBuilder(
    column: $table.lastSyncedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$LocalVendorProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $LocalVendorProfilesTable,
          LocalVendorProfile,
          $$LocalVendorProfilesTableFilterComposer,
          $$LocalVendorProfilesTableOrderingComposer,
          $$LocalVendorProfilesTableAnnotationComposer,
          $$LocalVendorProfilesTableCreateCompanionBuilder,
          $$LocalVendorProfilesTableUpdateCompanionBuilder,
          (
            LocalVendorProfile,
            BaseReferences<
              _$AppDb,
              $LocalVendorProfilesTable,
              LocalVendorProfile
            >,
          ),
          LocalVendorProfile,
          PrefetchHooks Function()
        > {
  $$LocalVendorProfilesTableTableManager(
    _$AppDb db,
    $LocalVendorProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalVendorProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalVendorProfilesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalVendorProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> vendorId = const Value.absent(),
                Value<String> ownerUid = const Value.absent(),
                Value<String> vendorName = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> foodCategory = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> locationText = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<String?> profileImageUrl = const Value.absent(),
                Value<String> reviewUrl = const Value.absent(),
                Value<double> averageRating = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<String?> lastReviewComment = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> lastSyncedAtMs = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVendorProfilesCompanion(
                vendorId: vendorId,
                ownerUid: ownerUid,
                vendorName: vendorName,
                shopName: shopName,
                foodCategory: foodCategory,
                description: description,
                phoneNumber: phoneNumber,
                locationText: locationText,
                city: city,
                country: country,
                preferredLanguage: preferredLanguage,
                profileImageUrl: profileImageUrl,
                reviewUrl: reviewUrl,
                averageRating: averageRating,
                reviewCount: reviewCount,
                lastReviewComment: lastReviewComment,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                lastSyncedAtMs: lastSyncedAtMs,
                isDirty: isDirty,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String vendorId,
                required String ownerUid,
                required String vendorName,
                required String shopName,
                required String foodCategory,
                Value<String> description = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> locationText = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<String?> profileImageUrl = const Value.absent(),
                required String reviewUrl,
                Value<double> averageRating = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<String?> lastReviewComment = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int> lastSyncedAtMs = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalVendorProfilesCompanion.insert(
                vendorId: vendorId,
                ownerUid: ownerUid,
                vendorName: vendorName,
                shopName: shopName,
                foodCategory: foodCategory,
                description: description,
                phoneNumber: phoneNumber,
                locationText: locationText,
                city: city,
                country: country,
                preferredLanguage: preferredLanguage,
                profileImageUrl: profileImageUrl,
                reviewUrl: reviewUrl,
                averageRating: averageRating,
                reviewCount: reviewCount,
                lastReviewComment: lastReviewComment,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                lastSyncedAtMs: lastSyncedAtMs,
                isDirty: isDirty,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalVendorProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $LocalVendorProfilesTable,
      LocalVendorProfile,
      $$LocalVendorProfilesTableFilterComposer,
      $$LocalVendorProfilesTableOrderingComposer,
      $$LocalVendorProfilesTableAnnotationComposer,
      $$LocalVendorProfilesTableCreateCompanionBuilder,
      $$LocalVendorProfilesTableUpdateCompanionBuilder,
      (
        LocalVendorProfile,
        BaseReferences<_$AppDb, $LocalVendorProfilesTable, LocalVendorProfile>,
      ),
      LocalVendorProfile,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String entityType,
      required String entityId,
      required String operation,
      required String payloadJson,
      required int createdAtMs,
      Value<int> retryCount,
      Value<String?> lastError,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String> payloadJson,
      Value<int> createdAtMs,
      Value<int> retryCount,
      Value<String?> lastError,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDb, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
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

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDb, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
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

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDb, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDb,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDb, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDb db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                createdAtMs: createdAtMs,
                retryCount: retryCount,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required String entityId,
                required String operation,
                required String payloadJson,
                required int createdAtMs,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                createdAtMs: createdAtMs,
                retryCount: retryCount,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (SyncQueueData, BaseReferences<_$AppDb, $SyncQueueTable, SyncQueueData>),
      SyncQueueData,
      PrefetchHooks Function()
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$TaskLogsTableTableManager get taskLogs =>
      $$TaskLogsTableTableManager(_db, _db.taskLogs);
  $$ShopStateTableTableManager get shopState =>
      $$ShopStateTableTableManager(_db, _db.shopState);
  $$VendorStateTableTableManager get vendorState =>
      $$VendorStateTableTableManager(_db, _db.vendorState);
  $$VendorDailyStatsTableTableManager get vendorDailyStats =>
      $$VendorDailyStatsTableTableManager(_db, _db.vendorDailyStats);
  $$LocalVendorProfilesTableTableManager get localVendorProfiles =>
      $$LocalVendorProfilesTableTableManager(_db, _db.localVendorProfiles);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
}
