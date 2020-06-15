import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitTransaction() {
    final submitTitle = titleController.text;
    final submitAmount = double.parse(amountController.text);

    //not execute addNewTransaction when title & amount empty
    if (submitTitle.isEmpty || submitAmount <= 0) {
      return;
    }
    widget.addNewTransaction(submitTitle, submitAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) =>
                  submitTransaction(), // underscore in bracket for ignored
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitTransaction(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.teal,
              onPressed: () {
                widget.addNewTransaction(
                    titleController.text,
                    double.parse(amountController
                        .text)); //convert string to double with double parse
              },
            ),
          ],
        ),
      ),
    );
  }
}
