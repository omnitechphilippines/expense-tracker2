import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'chart/chart.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = <Expense>[
    Expense(title: 'Flutter Course', amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: 'Cinema', amount: 15.69, date: DateTime.now(), category: Category.leisure),
  ];

  void _openAddExpenseOverlay() => showModalBottomSheet(context: context, builder: (_) => NewExpense(onAddExpense: _addExpense), isScrollControlled: true, useSafeArea: true);

  void _addExpense(Expense expense) => setState(() => _registeredExpenses.add(expense));

  void _removeExpense(Expense expense) {
    final int expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() => _registeredExpenses.remove(expense));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(label: 'Undo', onPressed: () => setState(() => _registeredExpenses.insert(expenseIndex, expense))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    Widget mainContent = const Center(child: Text('No expenses found. Start adding some!'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker 2'), actions: <Widget>[IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))]),
      body: size.width < size.height ? Column(children: <Widget>[Chart(expenses: _registeredExpenses), Expanded(child: mainContent)]) : Row(children: <Widget>[Expanded(child: Chart(expenses: _registeredExpenses)), Expanded(child: mainContent)]),
    );
  }
}
