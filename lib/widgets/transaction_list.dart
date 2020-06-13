import 'package:flutter/material.dart';
import 'package:walletapp/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transaction.map((tx) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 2)),
                padding: EdgeInsets.all(5),
                child: Text(
                  '\$${tx.amount}',
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
                    tx.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    DateFormat.jm().format(tx.date),
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text(
                    DateFormat.yMMMEd().format(tx.date),
                    style: TextStyle(color: Colors.blueGrey),
                  )
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
