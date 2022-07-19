import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocx/db/transaction/transaction_db.dart';
import 'package:pocx/models/transaction/transaction_model.dart';

ValueNotifier<List<TransactionModel>> searchNotifier = ValueNotifier([]);
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.red),
        centerTitle: true,
        elevation: 0,
        //toolbarHeight: 0,
        backgroundColor: Colors.white,
        title: RichText(
          text: const TextSpan(
            text: 'S',
            style: TextStyle(
              fontSize: 23,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'earch',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const  SizedBox(height: 10,),
            TextField(
              onChanged: (String? value) {
                if (value == null || value.isEmpty) {
                  searchNotifier.value.addAll(
                      TransactionDb.instance.transactionListNotifier.value);
                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                  searchNotifier.notifyListeners();
                } else {
                  searchNotifier.value.clear();
                  for (TransactionModel item
                      in TransactionDb.instance.transactionListNotifier.value) {
                    if (item.category
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      searchNotifier.value.add(item);
                    }
                    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                    searchNotifier.notifyListeners();
                  }
                }
              },
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: const Icon(Icons.search),border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: searchNotifier,
                builder: (BuildContext context,
                    List<TransactionModel> transactionModel, Widget? _) {
                  return ListView.builder(
                    itemCount: searchNotifier.value.length,
                    itemBuilder: (context, index) {
                      final data = transactionModel[index];
                      return Card(
                        color: Colors.red,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          trailing: Text(data.amount.toString(),style: const TextStyle(color: Colors.white),),
                          leading: Text(DateFormat.MMMMd().format(data.date),style: const TextStyle(color: Colors.white),),
                          title: Center(
                            child: Text(
                              data.category.name,style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      
                      );
                      
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
