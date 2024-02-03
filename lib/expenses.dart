import 'package:expenss/widgets/expenses_list/expenses_list.dart';
import 'package:expenss/model/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Categoory.work,
    ),
    Expense(
      title: 'Cinema ',
      amount: 15.69,
      date: DateTime.now(),
      category: Categoory.leisure,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpense)),
        ],
      ),
    );
  }
}