// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pocx/models/category/category_model.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category-db';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String catgoryId);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.put(value.id, value);
    refreshUi();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDb.values.toList();
  }

  Future<void> refreshUi() async {
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    final allCatagories = await getCategories();
    await Future.forEach(
      allCatagories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else {
          expenseCategoryListListener.value.add(category);
        }
      },
    );

    // ignore: invalid_use_of_visible_for_testing_member
    incomeCategoryListListener.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String catgoryId) async {
    // ignore: non_constant_identifier_names
    final CategoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await CategoryDb.delete(catgoryId);
    refreshUi();
  }
}
