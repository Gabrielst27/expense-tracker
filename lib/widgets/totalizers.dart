import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Totalizer extends StatelessWidget {
  const Totalizer({super.key, required this.allExpenses});

  final List<Expense> allExpenses;

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;
    double maxAmount = 0;
    for (final expense in allExpenses) {
      totalAmount += expense.amount;
      if (expense.amount > maxAmount) {
        maxAmount = expense.amount;
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            child: Container(
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('R\$ ${totalAmount.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Máximo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('R\$ ${maxAmount.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
