import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return <ExpenseBucket>[
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final ExpenseBucket bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    // final height = MediaQuery.of(context).size.height;
    final bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: width < height ? 180 : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(colors: <Color>[Theme.of(context).colorScheme.primary.withValues(alpha: 0.3), Theme.of(context).colorScheme.primary.withValues(alpha: 0)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[...buckets.map((ExpenseBucket bucket) => ChartBar(fill: bucket.totalExpenses == 0 ? 0 : bucket.totalExpenses / maxTotalExpense))],
              // children: [for (final bucket in buckets) ChartBar(fill: bucket.totalExpenses == 0 ? 0 : bucket.totalExpenses / maxTotalExpense)],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              for (final ExpenseBucket bucket in buckets)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(categoryIcons[bucket.category], color: isDarkMode ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)),
                  ),
                )
            ],
            // children: buckets
            //     .map(
            //       (bucket) => Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 4),
            //           child: Icon(categoryIcons[bucket.category], color: isDarkMode ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary.withOpacity(0.7)),
            //         ),
            //       ),
            //     )
            //     .toList(),
          )
        ],
      ),
    );
  }
}
