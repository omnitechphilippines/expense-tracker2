import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext ctx, int idx) => Dismissible(
        key: ValueKey<Expense>(expenses[idx]),
        onDismissed: (DismissDirection direction) => onRemoveExpense(expenses[idx]),
        background: Container(color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75), margin: Theme.of(context).cardTheme.margin),
        child: ExpenseItem(expenses[idx]),
      ),
    );
  }
}
