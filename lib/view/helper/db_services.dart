import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  Database? _database;

  static DbService dbService = DbService._();

  DbService._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String sql =
          'CREATE TABLE Notes (Id INTEGER PRIMARY KEY AUTOINCREMENT,Title TEXT,Content TEXT,Datetime TEXT,Category TEXT)';
      await db.execute(sql);
    });
    return database;
  }

  Future<void> insertDatabase(Map notesDetails) async {
    final db = await database;
    List args = [
      notesDetails['Title'],
      notesDetails['Content'],
      notesDetails['Datetime'],
      notesDetails['Category']
    ];
    String sql =
        'INSERT INTO Notes(Title,Content,Datetime,Category) VALUES(?,?,?,?)';
    db!.rawInsert(sql, args);
  }

  Future<void> updateDatabase(Map notesDetails,int id) async {
    print(id.toString());
    final db = await database;
    List args = [
      notesDetails['Title'],
      notesDetails['Content'],
      notesDetails['Datetime'],
      notesDetails['Category'],
      id,
    ];
    String sql =
        'UPDATE Notes SET Title = ? , Content = ?,Datetime = ?,Category=? WHERE Id = ?';
    db!.rawUpdate(sql, args);
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    List args = [id];
    String sql = 'DELETE FROM Notes WHERE Id = ?';
    db!.rawDelete(sql, args);
  }

  Future<List> dataShow() async {
    final db = await database;

    String sql = 'SELECT * FROM Notes';
    List data = await db!.rawQuery(sql);
    return data;
  }
}
