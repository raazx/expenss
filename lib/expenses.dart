import 'package:expenss/new_expense.dart';
import 'package:expenss/widgets/chart/chart.dart';
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
      title: 'غداء من البيك',
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
      title: 'تسوق ',
      amount: 1000.0,
      date: DateTime.now(),
      category: Categoory.food,
    ),
    Expense(
      title: 'فاتورة كهرباء ',
      amount: 25.49,
      date: DateTime.now(),
      category: Categoory.travel,
    ),
    Expense(
      title: ' تصليح سيارة ',
      amount: 195.59,
      date: DateTime.now(),
      category: Categoory.other,
    ),
    Expense(
      title: ' فاتورة كهرباء ',
      amount: 195.59,
      date: DateTime.now(),
      category: Categoory.other,
    ),
    Expense(
      title: ' الذهاب الي السنيما  ',
      amount: 250,
      date: DateTime.now(),
      category: Categoory.leisure,
    ),
    Expense(
      title: 'فواتير بوفية العمل ',
      amount: 250,
      date: DateTime.now(),
      category: Categoory.work,
    ),
    Expense(
      title: 'شرائ مكتب جديد ',
      amount: 1500,
      date: DateTime.now(),
      category: Categoory.work,
    ),
    Expense(
      title: ' السفر الي الرياض  ',
      amount: 1500,
      date: DateTime.now(),
      category: Categoory.travel,
    ),
    Expense(
      title: 'جلسه علاجية',
      amount: 1500,
      date: DateTime.now(),
      category: Categoory.health,
    ),
    Expense(
      title: ' تحاليل طبية',
      amount: 1500,
      date: DateTime.now(),
      category: Categoory.health,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      elevation: 5,
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
    final width = MediaQuery.of(context).size.width;
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
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpense),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpense)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
