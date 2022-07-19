import 'package:hive_flutter/adapters.dart';
import 'package:pocx/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {

  @HiveField(0)
  final String notes;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final CategoryType type;

  @HiveField(4)
  final CategoryModel category;

  @HiveField(5)
  String? id;

  TransactionModel({
   required this.notes, 
   required this.amount, 
   required this.date, 
   required this.type, 
   required this.category,
   this.id
   });
}
