import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:first_flutter/Core/Models/UserTransaction.dart';
import 'package:first_flutter/UI/Widgets/MonthlyOverview/CategoryTxList.dart';
import 'package:flutter/material.dart';

class CategoryTransactionView extends StatelessWidget {
  final String _categoryType;
  final double _amount;
  final List<UserTransaction> _categoryList;

  CategoryTransactionView(this._categoryList, this._categoryType, this._amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                _categoryType,
                style: TextStyle(fontSize: 28, color: greyCityLights(), fontWeight: FontWeight.w600),
              ),
              Text(
                "\$" + _amount.toString(),
                style: TextStyle(fontSize: 28, color: redPinkGlamor(), fontWeight: FontWeight.w600),
              ),
              if (_categoryList.isEmpty)
                Text(
                  "No transactions for " + _categoryType,
                  style: TextStyle(fontSize: 22, color: greyCityLights(), fontWeight: FontWeight.w500),
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
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
