import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:walletapp/widgets/chart.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.tealAccent,
          errorColor: Colors.red,
          fontFamily: 'Product Sans',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'Usuazi',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '1', title: 'Order GoFood', amount: 20.000, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Top Up OVO', amount: 50.000, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());

    //set new transaction to list
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _popUpAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        enableDrag: true,
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery =
        MediaQuery.of(context); //make MediaQuery to variabele, more efficient
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Home'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _popUpAddTransaction(context))
              ],
            ),
          )
        : AppBar(
            centerTitle: true,
            title: Text('Home'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _popUpAddTransaction(context),
              )
            ],
          );
    final transactionListWidget = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7, //MediaQuery.of(context).padding.top means status bar
        child: TransactionList(_userTransactions, _deleteTransaction));
    final bodyPage = SafeArea(
      //add safearea, adjusting top page with navigation bar in ios
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) //can use if() statement but dont use curly {} cause its a special "if"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Switch.adaptive(
                      //set adaptive make toggle switch different look in ios
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          appbar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3, //appbar preferedsize to take height from appbar
                  child: Chart(_recentTransaction)),
            if (!isLandscape) transactionListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appbar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7, //appbar preferedsize to take height from appbar
                      child: Chart(_recentTransaction))
                  : transactionListWidget
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
          )
        : Scaffold(
            appBar:
                appbar, //appbar moved in variable final appbar, so appbar can use as variable
            body: bodyPage,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton:
                Platform.isIOS //render empty container if build in ios
                    ? Container()
                    : FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () => _popUpAddTransaction(context),
                      ),
          );
  }
}
