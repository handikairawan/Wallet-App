import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitTransaction() {
    //avoid error add transaction when title is empty
    if (titleController.text.isEmpty) {
      return;
    }
    final submitTitle = titleController.text;
    final submitAmount = double.parse(amountController.text);

    //not execute addNewTransaction when title & amount empty
    if (submitTitle.isEmpty || submitAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addNewTransaction(
        submitTitle, submitAmount, selectedDate); //sent data to main.dart

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //make form in modalbottomsheet scrollable
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
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
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    //expanded same as flexible->flexfit.tight
                    Expanded(
                      child: Text(selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Date: ${DateFormat.yMEd().format(selectedDate)}'),
                    ),
                    FlatButton(
                      onPressed: _datePicker,
                      child: Text(
                        selectedDate == null ? 'Choose Date' : 'Change Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: submitTransaction
                    // (){
                    //   widget.addNewTransaction(
                    //       titleController.text,
                    //       double.parse(amountController
                    //           .text)); //convert string to double with double parse
                    // },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
