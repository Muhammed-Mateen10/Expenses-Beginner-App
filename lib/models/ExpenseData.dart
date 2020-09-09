import 'package:flutter/foundation.dart';

class ExpenseData {
  final String uniq;
  final String title;
  final double amount;
  final DateTime date;
  ExpenseData(
      {@required this.title,
      @required this.amount,
      @required this.date,
      @required this.uniq});
}
