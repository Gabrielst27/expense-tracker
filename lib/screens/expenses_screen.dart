import 'package:expense_tracker/data/mockups/expenses_mockup.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses-list/expenses_list.dart';
import 'package:expense_tracker/widgets/totalizers.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Despesa deletada'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Widget mainContent = Center(
      child: Text('Sem despesas encontradas. Adicione despesas!'),
    );
    Widget totalizers = Center(child: Text(''));
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
      totalizers = Totalizer(
        allExpenses: registeredExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de despesas'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: screenWidth < 600
          ? Column(
              children: [
                Chart(expenses: registeredExpenses),
                const SizedBox(height: 16),
                totalizers,
                const SizedBox(height: 16),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: registeredExpenses),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      totalizers,
                      const SizedBox(height: 16),
                      Expanded(
                        child: mainContent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
