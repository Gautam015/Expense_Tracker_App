import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart/chart.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        title: 'Sneakers',
        amount: 80.28,
        date: DateTime.now(),
        category: Category.leisure),
    Transaction(
        title: 'Formals',
        amount: 35.77,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddTransactionOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return NewTransaction(
            onAddTransaction: _addNewTransaction,
          );
        });
  }

  void _addNewTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _removeTransaction(Transaction transaction) {
    final transactionIndex = _userTransactions.indexOf(transaction);
    setState(() {
      _userTransactions.remove(transaction);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _userTransactions.insert(transactionIndex, transaction);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Expenses found. Start adding Some!'),
    );

    if (_userTransactions.isNotEmpty) {
      mainContent = TransactionList(_userTransactions, _removeTransaction);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterExpenseTracker'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _openAddTransactionOverlay,
            )
          ],
        ),
        body: width < 600 ? Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(transactions: _userTransactions,),
            Expanded(child: mainContent),
          ],
        ) : Row(
          children: <Widget>[
            Expanded(child: Chart(transactions: _userTransactions,)),
            Expanded(child: mainContent),
          ],
        ));
  }
}

// class MyHomePage extends StatefulWidget {
//   // String titleInput;

//   String amountInput;
//   final titleController = TextEditingController();
//   final amountController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {

//   }
// }
