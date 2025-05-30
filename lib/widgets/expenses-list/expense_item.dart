import 'package:expense_tracker/enums/category_enum.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 8),
                Text(expense.title),
              ],
            ),
            Row(
              children: [
                Text('R\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Icon(Icons.date_range),
                const SizedBox(width: 8),
                Text(expense.formatedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
