import 'package:expense_tracker/enums/category_enum.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, {required this.category})
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();

  final ECategory category;
  final List<Expense> expenses;

  double get totalAmount {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
