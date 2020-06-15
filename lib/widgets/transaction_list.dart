import 'package:flutter/material.dart';
import 'package:walletapp/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 300,
      child: ListView.builder(
        //listview must declared or use parent height, builder just render list in screen
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal, width: 2)),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '\$${transaction[index].amount.toStringAsFixed(2)}', //toStringAsFixed to show fixed number amount ex: $12.0000 ->$12.00
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      DateFormat.jm().format(transaction[index].date),
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    Text(
                      DateFormat.yMMMEd().format(transaction[index].date),
                      style: TextStyle(color: Colors.blueGrey),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
