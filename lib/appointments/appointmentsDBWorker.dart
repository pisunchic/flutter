import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'appointmentsModel.dart';

class AppointmentsDBWorker {
  static final AppointmentsDBWorker db = AppointmentsDBWorker._();
  Database? _database;

  AppointmentsDBWorker._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'appointments.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE appointments(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            dateTime TEXT
          )
        ''');
      },
    );
  }

  Future<int> create(Appointment appointment) async {
    Database db = await database;
    return await db.insert('appointments', {
      'title': appointment.title,
      'description': appointment.description,
      'dateTime': appointment.dateTime.toIso8601String(),
    });
  }

  Future<Appointment?> get(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Appointment(
      id: result.first['id'],
      title: result.first['title'],
      description: result.first['description'],
      dateTime: DateTime.parse(result.first['dateTime']),
    );
  }

  Future<List<Appointment>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('appointments');
    return result.map((map) {
      return Appointment(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        dateTime: DateTime.parse(map['dateTime']),
      );
    }).toList();
  }

  Future<int> update(Appointment appointment) async {
    Database db = await database;
    return await db.update(
      'appointments',
      {
        'title': appointment.title,
        'description': appointment.description,
        'dateTime': appointment.dateTime.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final AppointmentsDBWorker appointmentsDBWorker = AppointmentsDBWorker.db;
