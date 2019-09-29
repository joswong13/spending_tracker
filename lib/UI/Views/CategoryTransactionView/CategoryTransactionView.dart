import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:first_flutter/Core/Models/UserTransaction.dart';
import 'package:first_flutter/UI/Widgets/MonthlyOverview/CategoryTxList.dart';
import 'package:flutter/material.dart';

class CategoryTransactionView extends StatelessWidget {
  final String _categoryType;

  final List<UserTransaction> _categoryList;

  CategoryTransactionView(this._categoryList, this._categoryType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              _categoryType,
              style: TextStyle(fontSize: 28, color: greyCityLights(), fontWeight: FontWeight.w600),
            ),
            ..._categoryList.map((eachItem) {
              return CategoryTransactionList(eachItem);
            }).toList(),
            RaisedButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
