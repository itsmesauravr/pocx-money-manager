import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pocx/db/category/category_db.dart';
import 'package:pocx/db/transaction/transaction_db.dart';
import 'package:pocx/models/category/category_model.dart';
import 'package:pocx/models/transaction/transaction_model.dart';
import 'package:pocx/screens/transactions/transaction_update.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUi();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        if( TransactionDb.instance.transactionListNotifier.value.isEmpty){
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assest/images/add.png',width: 225,),
                  const Text('No Transaction Details Added .\nUse + icon for add Transaction',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.red),),
                ],
              ),
          );
        }else{
           return ListView.separated(
            itemBuilder: (ctx, index) {
              final value = newList[index];
              return  Slidable(
                key: Key(value.id!),
                startActionPane: ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(onPressed: (ctx){
                    TransactionDb.instance.deleteTransaction(value.id!);
                  },
                  icon: Icons.delete,
                  label: 'Delete',backgroundColor: Colors.red,
                  )
                ]),
                child: Card(
                      elevation: 0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 50,
                          backgroundColor: value.type ==CategoryType.income? Colors.green : Colors.red,
                          child: Text(
                            parseDate(value.date),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        title: Text(value.category.name),
                        subtitle: Text('Rs ${value.amount}'),
                        trailing: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  TransactionUpdateScreen(data: value,)));
                        }, icon: const Icon(Icons.edit)),
                      )),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length);
        }
       
      },
    );
  }
  String parseDate(DateTime date){
    final date1 = DateFormat.MMMd().format(date);
    final splitDate = date1.split(' ');
    return '${splitDate.last} \n ${splitDate.first}';
  }
}
