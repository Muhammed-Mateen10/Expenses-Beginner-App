import 'package:PersonnelExpenses/models/ExpenseData.dart';
import 'package:PersonnelExpenses/widgets/NewExpense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'AllExpenses.dart';
import 'chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ExpenseData> data = [];
  bool _turnswitch = false;

  void _addExpense(String title, double amount, DateTime pickedDate) {
    final tx = new ExpenseData(
      uniq: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: pickedDate,
    );
    setState(() {
      data.add(tx);
    });
  }

  void _delete(String uniq) {
    setState(() {
      data.removeWhere((t) => t.uniq == uniq);
    });
  }

  void startNewExpense(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewExpense(_addExpense);
        });
  }

  List<ExpenseData> get _data {
    return data.where((d) {
      return d.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        (MediaQuery.of(context).orientation == Orientation.landscape);
    final appBar2 = AppBar(
      title: const Text(
        'Personnel Expenses App',
        style: TextStyle(
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () => startNewExpense(context),
        )
      ],
    );
    final ExpenseList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar2.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: AllExpenses(data, _delete),
    );
    return Scaffold(
      appBar: appBar2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _turnswitch,
                      onChanged: (val) {
                        setState(() {
                          _turnswitch = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar2.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_data),
              ),
            if (!isLandscape) ExpenseList,
            if (isLandscape)
              _turnswitch
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar2.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_data),
                    )
                  : ExpenseList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              elevation: 10,
              tooltip: 'Click to Add New Expense',
              child: Icon(Icons.add),
              onPressed: () => startNewExpense(context),
            ),
    );
  }
}
