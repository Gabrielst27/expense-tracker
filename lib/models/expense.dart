import 'package:expense_tracker/enums/category_enum.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = Uuid().v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ECategory category;

  String get formatedDate {
    return DateFormat.yMMMd().format(date);
  }
}
