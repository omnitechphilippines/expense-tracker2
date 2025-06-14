import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

enum Category { food, travel, leisure, work }

final DateFormat dateFormatter = DateFormat.yMd();

const Map<Category, IconData> categoryIcons = <Category, IconData>{Category.food: Icons.lunch_dining, Category.travel: Icons.flight_takeoff, Category.leisure: Icons.movie, Category.work: Icons.work};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();

  String get formattedDate => dateFormatter.format(date);
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) : expenses = allExpenses.where((Expense expense) => expense.category == category).toList();

  double get totalExpenses {
    double sum = 0;
    for (final Expense expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
