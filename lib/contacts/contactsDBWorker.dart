import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'contactsModel.dart';

class ContactsDBWorker {
  static final ContactsDBWorker db = ContactsDBWorker._();
  Database? _database;

  ContactsDBWorker._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY,
            name TEXT,
            phone TEXT
          )
        ''');
      },
    );
  }

  Future<int> create(Contact contact) async {
    Database db = await database;
    return await db.insert('contacts', {
      'name': contact.name,
      'phone': contact.phone,
    });
  }

  Future<Contact?> get(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return Contact(
      id: result.first['id'],
      name: result.first['name'],
      phone: result.first['phone'],
    );
  }

  Future<List<Contact>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('contacts');
    return result.map((map) {
      return Contact(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
      );
    }).toList();
  }

  Future<int> update(Contact contact) async {
    Database db = await database;
    return await db.update(
      'contacts',
      {
        'name': contact.name,
        'phone': contact.phone,
      },
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final ContactsDBWorker contactsDBWorker = ContactsDBWorker.db;

