import 'package:PersonnelExpenses/models/ExpenseData.dart';
import 'package:PersonnelExpenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<ExpenseData> recents;
  Chart(this.recents);
  List<Map<String, Object>> get grouped {
    return List.generate(7, (index) {
      var sum = 0.0;
      final weekday = DateTime.now().subtract(Duration(days: index));
      for (int i = 0; i < recents.length; ++i) {
        if (recents[i].date.day == weekday.day &&
            recents[i].date.month == weekday.month &&
            recents[i].date.year == weekday.year) {
          sum += recents[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 3),
        'amount': sum
      };
    }).reversed.toList();
  }

  double get sumtotal {
    return grouped.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: grouped.map((e) {
            return Expanded(
              child: ChartBar(
                amount: e['amount'],
                weekday: e['day'],
                percentofAmount: sumtotal == 0.0
                    ? 0.0
                    : ((e['amount'] as double) / sumtotal),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
