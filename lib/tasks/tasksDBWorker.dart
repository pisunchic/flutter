import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'tasksModel.dart';

class TasksDBWorker {
  static final TasksDBWorker db = TasksDBWorker._();
  Database? _database;

  TasksDBWorker._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }

  Future<int> create(Task task) async {
    Database db = await database;
    return await db.insert('tasks', {
      'title': task.title,
      'isCompleted': task.isCompleted ? 1 : 0,
    });
  }

  Future<Task?> get(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Task(
      id: result.first['id'],
      title: result.first['title'],
      isCompleted: result.first['isCompleted'] == 1,
    );
  }

  Future<List<Task>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('tasks');
    return result.map((map) {
      return Task(
        id: map['id'],
        title: map['title'],
        isCompleted: map['isCompleted'] == 1,
      );
    }).toList();
  }

  Future<int> update(Task task) async {
    Database db = await database;
    return await db.update(
      'tasks',
      {
        'title': task.title,
        'isCompleted': task.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final TasksDBWorker tasksDBWorker = TasksDBWorker.db;
