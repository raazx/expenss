import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

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
