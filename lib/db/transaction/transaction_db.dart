// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pocx/db/category/category_db.dart';
import 'package:pocx/models/category/category_model.dart';
import 'package:pocx/models/transaction/transaction_model.dart';
import 'package:pocx/screens/home/splash_screen.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';


abstract class TransactionDbFunctions {
  Future <void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction(); 
  Future<void>deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions{

  TransactionDb.internal();

  static TransactionDb instance = TransactionDb.internal();

  factory TransactionDb(){
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(obj.id, obj);
  }

  Future <void> refresh() async{
    final list = await getAllTransaction();
    list.sort((first,second)=> second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    // ignore: invalid_use_of_protected_member
    transactionListNotifier.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getAllTransaction() async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }
  
  @override
  Future <void> deleteTransaction(String id) async{
   final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await db.delete(id);
   refresh();
  }
  Future <void> updateTransaction(data,id) async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(id,data);
    refresh();
  }
  Future <void> appReset(ctx)async{
    final transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await transactionDb.clear();

     final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
     await categoryDb.clear();
     Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const SplashScreen()), (route) => false);
  }
}