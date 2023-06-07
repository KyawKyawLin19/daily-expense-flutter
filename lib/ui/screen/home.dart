import 'package:daily_expense/database/Model/expense_model.dart';
import 'package:daily_expense/database/expense_db.dart';
import 'package:daily_expense/ui/screen/save_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final ExpenseDatabaseHelper expenseDatabaseHelper;
  const Home({Key? key, required this.expenseDatabaseHelper}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<ExpenseModel>> _expenseFuture = widget.expenseDatabaseHelper.getAllExpense();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Expense'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ExpenseModel>>(
        future: _expenseFuture,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
          List<ExpenseModel> expenseList = snapshot.data ?? [];
          return ListView.builder(
              key: PageStorageKey('expense_list'),
              itemCount: expenseList.length,
              itemBuilder: (context, index) {
                ExpenseModel expenseModel = expenseList[index];
                return Card(
                  child: ListTile(
                    title: Text(expenseModel.name?? ''),
                    subtitle: Text('${expenseModel.cost} Ks'),
                    trailing: Text(expenseModel.category?? ''),
                  ),
                );
              },
            );
          }
          else if(snapshot.hasError) {

          }
          return const CircularProgressIndicator.adaptive();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          // widget.expenseDatabaseHelper.insertExpense(name: 'Lunch', cost: 50000, date: '07/06/2023 12:00PM', category: 'Food');
          // widget.expenseDatabaseHelper.getAllExpense();
          String? message = await showDialog(context: context, builder: (context){
            return AlertDialog(
              title: const Text('Enter the expense'),
              content: SaveScreen(expenseDatabaseHelper: widget.expenseDatabaseHelper),
            );
          });
          if(message == "inserted") {
            setState(() {
              _expenseFuture = widget.expenseDatabaseHelper.getAllExpense();
            });
          }
        },
      ),
    );
  }
}
