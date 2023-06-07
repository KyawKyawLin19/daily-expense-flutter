import 'package:daily_expense/database/expense_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({Key? key, required this.expenseDatabaseHelper}) : super(key: key);
  final ExpenseDatabaseHelper expenseDatabaseHelper;

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String? _name;
  String? _cost;
  String? _category;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (name){
                if(name == null || name.isEmpty) {
                  return 'Please Enter Name';
                }
              },
              onSaved: (name) {
                _name = name;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              validator: (cost){
                if( cost == null || cost.isEmpty ) {
                  return 'Please Enter Cost';
                }
              },
              onSaved: (cost){
                _cost = cost;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cost',
              ),
            ),
            TextFormField(
              validator: (category){
                if( category == null || category.isEmpty ) {
                  return 'Please Enter Category';
                }
              },
              onSaved: (category){
                _category = category;
              },
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            ElevatedButton(onPressed: () async{
              _formKey.currentState?.save();
              if(_formKey.currentState?.validate() ?? false) {
                DateTime now = DateTime.now();
                int? cost = int.tryParse(_cost!);
                if(cost!= null) {
                  await widget.expenseDatabaseHelper.insertExpense(name: _name!, cost: cost, date: now.toString(), category: _category!);
                  if(mounted) {
                    Navigator.pop(context, "inserted");
                    ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Successfully Saved')));
                  }
                }
              }
            }, child: const Text('Save')),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Cancel')),
          ],
        ),
      ),
    );
  }
}
