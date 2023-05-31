import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDatabaseHelper {
  late Database _expensedb;
  final String dbName = "expense.db";

  Future<Database> createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    _expensedb = await openDatabase(path);
    return _expensedb;
  }
}