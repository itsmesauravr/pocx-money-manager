// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:pocx/db/category/category_db.dart';
import 'package:pocx/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final nameEditController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 10,
        backgroundColor: Colors.white,
        title: Center(
          child: RichText(
            text: const TextSpan(
              text: 'C',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'ATEGORY',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        children: [
            Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: nameEditController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ElevatedButton(
              onPressed: () {
                final name = nameEditController.text;
                if(name.isEmpty){
                  return;
                }
                final type = selectedCategoryNotifier.value;
                final category = CategoryModel(id: DateTime.now().microsecondsSinceEpoch.toString(),
                 name: name, 
                 type: type
                 );
                 CategoryDb().insertCategory(category);
                 Navigator.of(ctx).pop();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder:
                (BuildContext context, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.red),
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    // ignore: invalid_use_of_visible_for_testing_member
                    selectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
