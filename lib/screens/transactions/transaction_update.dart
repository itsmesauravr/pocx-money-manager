import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocx/db/category/category_db.dart';
import 'package:pocx/db/transaction/transaction_db.dart';
import 'package:pocx/models/category/category_model.dart';
import 'package:pocx/models/transaction/transaction_model.dart';

class TransactionUpdateScreen extends StatefulWidget {
  static const routName = 'add-transaction';
  final TransactionModel data;
  const TransactionUpdateScreen({Key? key,required this.data}) : super(key: key);

  @override
  State<TransactionUpdateScreen> createState() => _TransactionUpdateScreenState();
}

class _TransactionUpdateScreenState extends State<TransactionUpdateScreen> {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;

  String? categoryId;
  dynamic newDateAfterPars;
  final notesTextEditingController = TextEditingController();
  final amountTextEditingController = TextEditingController();

  @override
  void initState() {
    selectedCategoryType = widget.data.type;
    amountTextEditingController.text=widget.data.amount.toString();
    selectedDate = widget.data.date;
    notesTextEditingController.text = widget.data.notes.toString();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
            )),
        title: RichText(
          text: const TextSpan(
            text: 'U',
            style: TextStyle(
              fontSize: 23,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: 'pdate',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 45,
              ),
              TextFormField(
                controller: notesTextEditingController,
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  labelText: 'Notes',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: const BorderSide(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide:
                        BorderSide(color: Colors.red.shade400, width: 2),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: amountTextEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    labelText: 'Amount',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide:
                          BorderSide(color: Colors.red.shade400, width: 2),
                    )),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide:
                          BorderSide(color: Colors.red.shade400, width: 2),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(50),
                  hint: const Text('Select Category'),
                  value: categoryId,
                  items: (selectedCategoryType == CategoryType.income
                          ? CategoryDb().incomeCategoryListListener
                          : CategoryDb().expenseCategoryListListener)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: (){
                        selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      categoryId = selectedValue;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              //Calendar
              TextField(
                onTap: () async {
                  final selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDateTemp == null) {
                    return;
                  } else {
                     newDateAfterPars = parseDate(selectedDateTemp);
                    // ignore: avoid_print
                    print(selectedDateTemp.toString());
                    setState(() {
                      selectedDate = selectedDateTemp;
                    });
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: newDateAfterPars== null
                      ? 'Select Date'
                      : newDateAfterPars.toString(),
                  suffixIcon: const Icon(Icons.today_outlined),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: Colors.black54,
                        width: 2.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide:
                        BorderSide(color: Colors.red.shade400, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryType = CategoryType.income;
                            categoryId = null;
                          });
                        },
                      ),
                      const Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryType = CategoryType.expense;
                            categoryId = null;
                          });
                        },
                      ),
                      const Text('Expense'),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton(
                  onPressed: () {
                    snackBar(context);
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future <void> updateTransaction(String id) async{
    final notesText = notesTextEditingController.text;
    final amountText = amountTextEditingController.text;

    if(notesText.isEmpty){
      return;
    }
    if(amountText.isEmpty){
      return;
    }
    if(categoryId == null){
      return;
    }
    if(selectedDate == null){
      return;
    }

    final parseamount = double.tryParse(amountText);
    if(parseamount == null){
      return;
    }
    if(selectedCategoryModel == null){
      return;
    }

    final model = TransactionModel(

      id: widget.data.id,
      notes: notesText, 
      amount: parseamount, 
      date: selectedDate!, 
      type: selectedCategoryType!, 
      category: selectedCategoryModel!,
      );
     TransactionDb.instance.updateTransaction(model,id);
    
  }
  String parseDate(DateTime date){
    final date1 = DateFormat.yMMMMd('en_US') .format(date);
    // ignore: unused_local_variable
    final splitDate = date1.split(' ');
    return date1;
  }
   void snackBar(BuildContext ctx) {
    final notes = notesTextEditingController.text;
    final amount = amountTextEditingController.text;
    if (notes.isNotEmpty && amount.isNotEmpty && selectedDate != null && categoryId != null) {
      updateTransaction(widget.data.id!);
                     Navigator.of(context).pop();
                     TransactionDb.instance.refresh();
      
      
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10),),
          ),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Please fill the form'),
        ),
      );
    }
  }

}
