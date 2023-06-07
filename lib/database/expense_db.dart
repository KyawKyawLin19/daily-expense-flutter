import 'package:daily_expense/database/Model/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDatabaseHelper {
  //name, cost, datetime, category
  late Database _expensedb;
  final String dbName = "expense.db";
  final String expense = "expense_table";

  Future<void> init () async {
    await _createDatabase();
    await _createExpenseTable();
  }

  Future<Database> _createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    _expensedb = await openDatabase(path);
    return _expensedb;
  }

  Future<void> _createExpenseTable() async{
    return await _expensedb.execute('create table if not exists $expense(id integer primary key, name text, cost integer, time text, category text)');
  }

  Future<void> insertExpense({ required String name, required int cost, required String date, required String category}) async{
    _expensedb.execute('insert into $dbName (name,cost,time,category) values("$name", $cost, "$date", "$category")');
  }

  Future<List<ExpenseModel>> getAllExpense() async{
     List<Map<String,dynamic>> expenseMap = await _expensedb.rawQuery('select * from $expense');
     return expenseMap.map((e) {
       return ExpenseModel.fromJson(e);
     }).toList();
  }
}