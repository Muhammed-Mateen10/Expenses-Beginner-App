import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ExpenseData.dart';

class AllExpenses extends StatelessWidget {
  final List<ExpenseData> data;
  final Function del;
  AllExpenses(this.data, this.del);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return data.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text('No Expense Added yet',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.4,
                    child: Image.asset(
                      'assets/images/yettoenter.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.redAccent[400],
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 3),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(25),
                        child: Text(
                          '\$${data[index].amount.toStringAsPrecision(4)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].title,
                            style: TextStyle(
                                wordSpacing: 1.5,
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.yMMMEd().format(data[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      deviceWidth > 460
                          ? FlatButton.icon(
                              onPressed: () => del(data[index].uniq),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              label: Text('Delete'),
                            )
                          : GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              onTap: () => del(data[index].uniq),
                            ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
