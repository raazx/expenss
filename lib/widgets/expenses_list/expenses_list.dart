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
          padding: const EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          color: Theme.of(context).colorScheme.error,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: const Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 30,
            semanticLabel: 'Delete',
          ),
        ),
        direction: DismissDirection.endToStart,
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
