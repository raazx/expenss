import 'package:flutter/material.dart';
import 'package:expenss/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Categoory _selectedCategory = Categoory.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpensData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    final amountIsValid = amount == null || amount <= 0;
    if (title.isEmpty || amountIsValid || _selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Okay'))
                ],
                content: const Text(
                    'Please make sure a valid , titla & amount and category was entered!'),
              ));
      return;
    }
    // ...  send data to database or whatever you want with it
    widget.onAddExpense(Expense(
        title: title,
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month, now.day + 7);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: _amountController,
                        decoration: const InputDecoration(
                            prefixText: '\$',
                            labelText: "Amount",
                            labelStyle: TextStyle(fontSize: 18)),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Categoory.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpensData();
                      },
                      child: const Text('Save Expense'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
