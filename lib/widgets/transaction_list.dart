import 'package:flutter/material.dart';
import 'package:walletapp/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;

  TransactionList(this.transaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      // height: MediaQuery.of(context).size.height * 0.6, //set height of trasanction list to 60% of height
      child: transaction.isEmpty
          ? LayoutBuilder(builder: (context, constraint) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: constraint.maxHeight * 0.6,
                      child: Image.asset('assets/images/not_found.png',
                          fit: BoxFit.cover)),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Can\'t find any transaction!',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              );
            })
          : Card(
              elevation: 8,
              shadowColor: Colors.tealAccent[700],
              child: ListView.builder(
                //listview must declared or use parent height, builder just render list in screen
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transaction[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMEd().format(transaction[index].date)),
                    trailing: MediaQuery.of(context).size.width >
                            460 //condition in other size screen device
                        ? FlatButton.icon(
                            onPressed: () =>
                                deleteTransaction(transaction[index].id),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () =>
                                deleteTransaction(transaction[index].id),
                          ),
                  );
                },
                itemCount: transaction.length,
              ),
            ),
    );
  }
}
