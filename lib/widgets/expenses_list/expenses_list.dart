import 'package:expenss/model/expense.dart';
import 'package:expenss/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, i) => Dismissible(
        key: ValueKey(expenses[i].id),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[i]);
        },
        child: ExpenseItem(
          expense: expenses[i],
        ),
      ),
    );
  }
}
