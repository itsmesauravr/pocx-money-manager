import 'package:flutter/material.dart';
import 'package:pocx/db/category/category_db.dart';
import 'package:pocx/models/category/category_model.dart';

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          if (CategoryDb().expenseCategoryListListener.value.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assest/images/add.png',
                  width: 225,
                ),
                const Text(
                  'No Expense category added  so\nUse + for add Expense category',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
                ),
              ],
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 1,
                mainAxisExtent: 50,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: newList.length,
              itemBuilder: (context, index) {
                final catgory = newList[index];
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: FittedBox(
                      child: Text(
                        catgory.name,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: RichText(
                                text: const TextSpan(
                                  text: 'D',
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'elete',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              content: const Text(
                                  'Are you sure you want to delete?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('CANCEL')),
                                TextButton(
                                    onPressed: () {
                                      CategoryDb.instance
                                          .deleteCategory(catgory.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'))
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ),
                );
              });
        });
  }
}
