import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveTitleInput(String inputvalue) {}

  void selectDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);

    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Title"),
            controller: _titleController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _amountController,
                decoration: const InputDecoration(
                    prefixText: '\$',
                    labelText: "Amount",
                    labelStyle: TextStyle(fontSize: 18)),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                const Text('Select Date'),
                IconButton(
                    onPressed: selectDatePicker,
                    icon: const Icon(Icons.calendar_today)),
              ],
            ),
          ]),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
