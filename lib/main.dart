import 'package:daily_expense/database/expense_db.dart';
import 'package:daily_expense/ui/screen/home.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ExpenseDatabaseHelper expenseDatabaseHelper = ExpenseDatabaseHelper();
  expenseDatabaseHelper.init();
  runApp(Myapp(expenseDatabaseHelper: expenseDatabaseHelper));
}

class Myapp extends StatelessWidget {
  final ExpenseDatabaseHelper expenseDatabaseHelper;
  const Myapp({Key? key, required this.expenseDatabaseHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: Home(expenseDatabaseHelper: expenseDatabaseHelper,)
    );
  }
}

