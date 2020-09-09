import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function handler;
  NewExpense(this.handler);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime selected;
  final titleC = TextEditingController();
  final amountC = TextEditingController();
  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked == null) {
        return;
      }
      setState(() {
        selected = picked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void add() {
      final enteredT = titleC.text;
      final enteredA = double.parse(amountC.text);
      DateTime enteredD;
      if (selected != null) {
        enteredD = selected;
      } else
        enteredD = DateTime.now();

      if (enteredT.isEmpty || enteredA <= 0) {
        return;
      }
      widget.handler(enteredT, enteredA, enteredD);
      Navigator.of(context).pop();
    }

    return Card(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Title',
                  contentPadding: EdgeInsets.all(6),
                ),
                onSubmitted: (_) => add(),
                controller: titleC,
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Amount',
                  contentPadding: EdgeInsets.all(6),
                ),
                onSubmitted: (_) => add(),
                controller: amountC,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selected == null
                      ? 'No Date Choosen!'
                      : 'Picked Date: ${DateFormat.yMMMEd().format(selected)}'),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    onPressed: datePicker,
                  ),
                ],
              ),
              Container(
                height: 200,
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: add,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
