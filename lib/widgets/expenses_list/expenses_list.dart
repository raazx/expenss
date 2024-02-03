import 'package:expenss/expenses.dart';
import 'package:expenss/model/expense.dart';
import 'package:expenss/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, i) => ExpenseItem(
        expense: expenses[i],
      ),
    );
  }
}
