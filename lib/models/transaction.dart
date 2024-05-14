// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter =  DateFormat.yMd();

const uuid = Uuid();

enum Category { work, food, leisure, travel }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.movie,
};

class Transaction {
  Transaction({
    required this.title,
     required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class TransactionBucket {
  const TransactionBucket({
    required this.category,
    required this.transactions,
  });

  TransactionBucket.forCategory(List<Transaction> allTransactions, this.category)
      : transactions = allTransactions
            .where((transaction) => transaction.category == category)
            .toList();

  final Category category;
  final List<Transaction> transactions;

  double get totalTransactions {
    double sum = 0;

    for (final transaction in transactions) {
      sum += transaction.amount;
    }
    return sum;
  }
}
