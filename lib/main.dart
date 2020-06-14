import 'package:flutter/material.dart';
import 'package:walletapp/widgets/user_transaction.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //use controller to move data
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  child: Text('Chart'),
                  color: Colors.redAccent,
                  elevation: 5,
                ),
              ),
              UserTransaction()
            ],
          ),
        ));
  }
}
