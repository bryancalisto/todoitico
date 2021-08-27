// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String title;
  final String content;
  final String creator;
  final DateTime created;
  final DateTime limitDate;
  final DateTime modified;
  final String status;
  Todo(
      {@required this.id,
      @required this.title,
      @required this.content,
      @required this.creator,
      @required this.created,
      this.limitDate,
      this.modified,
      @required this.status});
  factory Todo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Todo(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      creator: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}creator']),
      created: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created']),
      limitDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}limit_date']),
      modified: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}modified']),
      status: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || creator != null) {
      map['creator'] = Variable<String>(creator);
    }
    if (!nullToAbsent || created != null) {
      map['created'] = Variable<DateTime>(created);
    }
    if (!nullToAbsent || limitDate != null) {
      map['limit_date'] = Variable<DateTime>(limitDate);
    }
    if (!nullToAbsent || modified != null) {
      map['modified'] = Variable<DateTime>(modified);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      creator: creator == null && nullToAbsent
          ? const Value.absent()
          : Value(creator),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
      limitDate: limitDate == null && nullToAbsent
          ? const Value.absent()
          : Value(limitDate),
      modified: modified == null && nullToAbsent
          ? const Value.absent()
          : Value(modified),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      creator: serializer.fromJson<String>(json['creator']),
      created: serializer.fromJson<DateTime>(json['created']),
      limitDate: serializer.fromJson<DateTime>(json['limitDate']),
      modified: serializer.fromJson<DateTime>(json['modified']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'creator': serializer.toJson<String>(creator),
      'created': serializer.toJson<DateTime>(created),
      'limitDate': serializer.toJson<DateTime>(limitDate),
      'modified': serializer.toJson<DateTime>(modified),
      'status': serializer.toJson<String>(status),
    };
  }

  Todo copyWith(
          {int id,
          String title,
          String content,
          String creator,
          DateTime created,
          DateTime limitDate,
          DateTime modified,
          String status}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        creator: creator ?? this.creator,
        created: created ?? this.created,
        limitDate: limitDate ?? this.limitDate,
        modified: modified ?? this.modified,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('creator: $creator, ')
          ..write('created: $created, ')
          ..write('limitDate: $limitDate, ')
          ..write('modified: $modified, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              content.hashCode,
              $mrjc(
                  creator.hashCode,
                  $mrjc(
                      created.hashCode,
                      $mrjc(limitDate.hashCode,
                          $mrjc(modified.hashCode, status.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.creator == this.creator &&
          other.created == this.created &&
          other.limitDate == this.limitDate &&
          other.modified == this.modified &&
          other.status == this.status);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> creator;
  final Value<DateTime> created;
  final Value<DateTime> limitDate;
  final Value<DateTime> modified;
  final Value<String> status;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.creator = const Value.absent(),
    this.created = const Value.absent(),
    this.limitDate = const Value.absent(),
    this.modified = const Value.absent(),
    this.status = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String content,
    @required String creator,
    this.created = const Value.absent(),
    this.limitDate = const Value.absent(),
    this.modified = const Value.absent(),
    @required String status,
  })  : title = Value(title),
        content = Value(content),
        creator = Value(creator),
        status = Value(status);
  static Insertable<Todo> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> content,
    Expression<String> creator,
    Expression<DateTime> created,
    Expression<DateTime> limitDate,
    Expression<DateTime> modified,
    Expression<String> status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (creator != null) 'creator': creator,
      if (created != null) 'created': created,
      if (limitDate != null) 'limit_date': limitDate,
      if (modified != null) 'modified': modified,
      if (status != null) 'status': status,
    });
  }

  TodosCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> content,
      Value<String> creator,
      Value<DateTime> created,
      Value<DateTime> limitDate,
      Value<DateTime> modified,
      Value<String> status}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      creator: creator ?? this.creator,
      created: created ?? this.created,
      limitDate: limitDate ?? this.limitDate,
      modified: modified ?? this.modified,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (creator.present) {
      map['creator'] = Variable<String>(creator.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (limitDate.present) {
      map['limit_date'] = Variable<DateTime>(limitDate.value);
    }
    if (modified.present) {
      map['modified'] = Variable<DateTime>(modified.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('creator: $creator, ')
          ..write('created: $created, ')
          ..write('limitDate: $limitDate, ')
          ..write('modified: $modified, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String _alias;
  $TodosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedColumn<String> _title;
  @override
  GeneratedColumn<String> get title =>
      _title ??= GeneratedColumn<String>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedColumn<String> _content;
  @override
  GeneratedColumn<String> get content =>
      _content ??= GeneratedColumn<String>('content', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 256),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _creatorMeta = const VerificationMeta('creator');
  GeneratedColumn<String> _creator;
  @override
  GeneratedColumn<String> get creator =>
      _creator ??= GeneratedColumn<String>('creator', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
          typeName: 'TEXT',
          requiredDuringInsert: true);
  final VerificationMeta _createdMeta = const VerificationMeta('created');
  GeneratedColumn<DateTime> _created;
  @override
  GeneratedColumn<DateTime> get created =>
      _created ??= GeneratedColumn<DateTime>('created', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultValue: currentDate);
  final VerificationMeta _limitDateMeta = const VerificationMeta('limitDate');
  GeneratedColumn<DateTime> _limitDate;
  @override
  GeneratedColumn<DateTime> get limitDate =>
      _limitDate ??= GeneratedColumn<DateTime>('limit_date', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _modifiedMeta = const VerificationMeta('modified');
  GeneratedColumn<DateTime> _modified;
  @override
  GeneratedColumn<DateTime> get modified =>
      _modified ??= GeneratedColumn<DateTime>('modified', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedColumn<String> _status;
  @override
  GeneratedColumn<String> get status => _status ??= GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, creator, created, limitDate, modified, status];
  @override
  String get aliasedName => _alias ?? 'todos';
  @override
  String get actualTableName => 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content'], _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('creator')) {
      context.handle(_creatorMeta,
          creator.isAcceptableOrUnknown(data['creator'], _creatorMeta));
    } else if (isInserting) {
      context.missing(_creatorMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created'], _createdMeta));
    }
    if (data.containsKey('limit_date')) {
      context.handle(_limitDateMeta,
          limitDate.isAcceptableOrUnknown(data['limit_date'], _limitDateMeta));
    }
    if (data.containsKey('modified')) {
      context.handle(_modifiedMeta,
          modified.isAcceptableOrUnknown(data['modified'], _modifiedMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String tablePrefix}) {
    return Todo.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

abstract class _$TheDatabase extends GeneratedDatabase {
  _$TheDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TodosTable _todos;
  $TodosTable get todos => _todos ??= $TodosTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}
