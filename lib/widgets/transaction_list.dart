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
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTransaction(transaction[index].id),
                    ),
                  );
                  // return Card(
                  //   elevation: 3,
                  //   child: Row(
                  //     children: <Widget>[
                  //       Container(
                  //         margin:
                  //             EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  //         decoration: BoxDecoration(
                  //             color: Theme.of(context).accentColor,
                  //             border: Border.all(
                  //                 color: Theme.of(context).accentColor,
                  //                 width: 2)),
                  //         padding: EdgeInsets.all(5),
                  //         child: Text(
                  //           'Rp.${transaction[index].amount.toStringAsFixed(0)}', //toStringAsFixed to show fixed number amount ex: $12.0000 ->$12.00
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 20,
                  //               color: Theme.of(context).primaryColor),
                  //         ),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(transaction[index].title,
                  //               style: Theme.of(context).textTheme.title
                  //               //                         TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  //               ),
                  //           Text(
                  //             DateFormat.jm().format(transaction[index].date),
                  //             style: TextStyle(color: Colors.blueGrey),
                  //           ),
                  //           Text(
                  //             DateFormat.yMMMEd().format(transaction[index].date),
                  //             style: TextStyle(color: Colors.blueGrey),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
                itemCount: transaction.length,
              ),
            ),
    );
  }
}
