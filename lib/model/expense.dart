import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Categoory { food, travel, leisure, work, health, other }

final formatter = DateFormat.yMd();

final categoryIcons = {
  Categoory.food: Icons.restaurant_menu,
  Categoory.travel: Icons.flight_takeoff,
  Categoory.leisure: Icons.local_play,
  Categoory.work: Icons.business,
  Categoory.health: Icons.local_hospital,
  Categoory.other: Icons.devices_other,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categoory category;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.categoory,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.categoory)
      : expenses = allExpenses
            .where((expense) => expense.category == categoory)
            .toList();

  final Categoory categoory;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final element in expenses) {
      sum += element.amount;
    }
    return sum;
  }
}
