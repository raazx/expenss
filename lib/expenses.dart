import 'package:expenss/new_expense.dart';
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
      title: 'مكرونة البيت',
      amount: 19.99,
      date: DateTime.now(),
      category: Categoory.food,
    ),
    Expense(
      title: 'كهرباء المنزل',
      amount: 250.0,
      date: DateTime.now(),
      category: Categoory.other,
    ),
    Expense(
      title: 'سوق الاثنين',
      amount: 1000.0,
      date: DateTime.now(),
      category: Categoory.food,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: NewExpense(onAddExpense: _addExpense),
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expensesIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Removed ${expense.title}',
          style: const TextStyle(color: Colors.red),
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpense.insert(expensesIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'No Expenses found. Start add some!',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
      ),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
