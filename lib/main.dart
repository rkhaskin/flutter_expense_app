import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Book',
      amount: 35.99,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Bread',
      amount: 16.99,
      date: DateTime.now(),
    )
  ];

  List<Transaction> get _recentTransactions {
    DateTime back7days = DateTime.now().subtract(const Duration(days: 7));
    return _userTransactions.where((tx) {
      return tx.date.isAfter(back7days);
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: const TextTheme(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).headline6,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Expenses App',
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(Icons.add),
              );
            })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
