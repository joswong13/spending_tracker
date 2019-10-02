import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:first_flutter/Core/Models/UserTransaction.dart';
import 'package:first_flutter/Core/ViewModels/MonthProvider.dart';
import 'package:first_flutter/UI/Widgets/MonthlyOverview/CategoryTxList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTransactionView extends StatelessWidget {
  final String _categoryType;
  final double _amount;
  final List<UserTransaction> _categoryList;

  ///The view of listing out all the category transactions given the category type, amount, and list of transactions.
  CategoryTransactionView(this._categoryList, this._categoryType, this._amount);

  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                _categoryType,
                style: TextStyle(fontSize: 28, color: ColorPalette.greyCityLights, fontWeight: FontWeight.w600),
              ),
              Text(
                "\$" + _amount.toString(),
                style: TextStyle(fontSize: 28, color: ColorPalette.greenLightGreenishBlue, fontWeight: FontWeight.w600),
              ),
              if (_categoryList.isEmpty)
                Text(
                  "No transactions for " + _categoryType,
                  style: TextStyle(fontSize: 22, color: ColorPalette.greyCityLights, fontWeight: FontWeight.w500),
                ),
              if (_categoryList.isNotEmpty)
                ..._categoryList.map((eachItem) {
                  return CategoryTransactionList(eachItem);
                }).toList(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton.extended(
            icon: Icon(Icons.arrow_back),
            label: Text("Back"),
            onPressed: () {
              monthData.categoryType = "";
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
