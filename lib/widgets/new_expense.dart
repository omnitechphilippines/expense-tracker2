import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    final DateTime lastDate = DateTime(now.year + 1, now.month, now.day);
    final DateTime? pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);
    setState(() => _selectedDate = pickedDate);
  }

  void _submitExpenseData() {
    final double? enteredAmount = double.tryParse(_amountController.text); // tryParse('Hello') = null; tryParse('1.12') = 1.12
    if (_titleController.text.trim().isEmpty || enteredAmount == null || enteredAmount <= 0 || _selectedDate == null) {
      // use showCupertinoDialog() for IOS and showDialog() for android
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext ctx) => CupertinoAlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please make sure a valid title, amount, date and category was entered.'),
            actions: <Widget>[TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Okay'))],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext ctx) => AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please make sure a valid title, amount, date and category was entered.'),
            actions: <Widget>[TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Okay'))],
          ),
        );
      }

      return;
    }
    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: <Widget>[
              if (width > height)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: TextField(controller: _titleController, maxLength: 50, decoration: const InputDecoration(label: Text('Title')))),
                    const SizedBox(width: 24),
                    Expanded(child: TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(prefixText: '₱ ', label: Text('Amount')))),
                  ],
                )
              else
                TextField(controller: _titleController, maxLength: 50, decoration: const InputDecoration(label: Text('Title')), style: Theme.of(context).textTheme.titleMedium),
              if (width > height)
                Row(
                  children: <Widget>[
                    DropdownButton<Category>(
                      value: _selectedCategory,
                      items: Category.values.map((Category category) => DropdownMenuItem<Category>(value: category, child: Text(category.name.toUpperCase()))).toList(),
                      onChanged: (Category? value) {
                        if (value == null) return;
                        setState(() => _selectedCategory = value);
                      },
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[Text(_selectedDate == null ? 'No selected date' : dateFormatter.format(_selectedDate!)), IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month))],
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: <Widget>[
                    Expanded(child: TextField(controller: _amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(prefixText: '₱ ', label: Text('Amount')), style: Theme.of(context).textTheme.titleMedium)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[Text(_selectedDate == null ? 'No selected date' : dateFormatter.format(_selectedDate!), style: Theme.of(context).textTheme.titleMedium), IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month))],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              if (width > height)
                Row(
                  children: <Widget>[
                    const Spacer(),
                    ElevatedButton(onPressed: _submitExpenseData, child: const Text('Save Expense')),
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  ],
                )
              else
                Row(
                  children: <Widget>[
                    DropdownButton<Category>(
                      value: _selectedCategory,
                      items: Category.values.map((Category category) => DropdownMenuItem<Category>(value: category, child: Text(category.name.toUpperCase()))).toList(),
                      onChanged: (Category? value) {
                        if (value == null) return;
                        setState(() => _selectedCategory = value);
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(onPressed: _submitExpenseData, child: const Text('Save Expense')),
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
