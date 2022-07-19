import 'package:flutter/material.dart';
import 'package:pocx/db/category/category_db.dart';
import 'package:pocx/screens/category/widgets/expense_category_gridlist.dart';
import 'package:pocx/screens/category/widgets/income_category_gridlist.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicator:  BoxDecoration(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50),top: Radius.circular(50)),
              color: Colors.red.shade400,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.red,
            tabs: const [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const[
              IncomeCategory(),
              ExpenseCategory(),
            ]),
          )
        ],
      ),
    );
  }
}
