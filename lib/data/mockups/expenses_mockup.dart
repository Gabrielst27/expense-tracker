import 'package:expense_tracker/enums/category_enum.dart';
import 'package:expense_tracker/models/expense.dart';

final List<Expense> registeredExpenses = [
  Expense(
    title: 'Strap',
    amount: 40.50,
    date: DateTime(2024, 6, 10),
    category: ECategory.workout,
  ),
  Expense(
    title: 'Curso de Flutter',
    amount: 25.90,
    date: DateTime(2025, 5, 20),
    category: ECategory.learning,
  ),
  Expense(
    title: 'Barbeiro',
    amount: 30,
    date: DateTime(2025, 5, 5),
    category: ECategory.workout,
  ),
];
