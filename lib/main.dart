// ignore_for_file: unused_local_variable, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pocx/db/category/category_db.dart';
import 'package:pocx/models/category/category_model.dart';
import 'package:pocx/models/transaction/transaction_model.dart';
import 'package:pocx/screens/home/splash_screen.dart';
import 'package:pocx/screens/home/widgets/add_transaction.dart';

Future <void> main() async{
  // ignore: unused_local_variable
  final obj1 = CategoryDb();
  final obj2 = CategoryDb();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

   if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp(),);
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'pocx',
      home: const SplashScreen(),
      routes: {
        AddTransactionScreen.routName: (ctx) => const AddTransactionScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}