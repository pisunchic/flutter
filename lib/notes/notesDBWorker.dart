import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'notesModel.dart';

class NotesDBWorker {
  static final NotesDBWorker db = NotesDBWorker._();
  Database? _database;

  NotesDBWorker._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<int> create(Note note) async {
    Database db = await database;
    return await db.insert('notes', {
      'title': note.title,
      'content': note.content,
    });
  }

  Future<Note?> get(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Note(
      id: result.first['id'],
      title: result.first['title'],
      content: result.first['content'],
    );
  }

  Future<List<Note>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('notes');
    return result.map((map) {
      return Note(
        id: map['id'],
        title: map['title'],
        content: map['content'],
      );
    }).toList();
  }

  Future<int> update(Note note) async {
    Database db = await database;
    return await db.update(
      'notes',
      {
        'title': note.title,
        'content': note.content,
      },
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final NotesDBWorker notesDBWorker = NotesDBWorker.db;

