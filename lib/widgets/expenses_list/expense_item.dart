import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                Text('₱${expense.amount.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                Row(children: <Widget>[Icon(categoryIcons[expense.category]), const SizedBox(width: 8), Text(expense.formattedDate, style: Theme.of(context).textTheme.titleMedium)]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
