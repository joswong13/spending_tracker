import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:first_flutter/Core/Constants/SizeConfig.dart';
import 'package:first_flutter/Core/Models/UserTransaction.dart';
import 'package:first_flutter/Core/ViewModels/MonthProvider.dart';
import 'package:first_flutter/UI/Widgets/MonthlyOverview/CategoryTxList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTransactionView extends StatelessWidget {
  final String _categoryType;
  final double _amount;
  final List<UserTransaction> _categoryList;
  final SizeConfig sizeConfig = SizeConfig();

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
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        iconSize: sizeConfig.topTextHeight28,
                        color: Theme.of(context).primaryColor,
                        tooltip: "Back",
                        onPressed: () {
                          monthData.categoryType = "";
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          _categoryType,
                          style: TextStyle(
                              fontSize: sizeConfig.topTextHeight28, color: greyCityLights, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "\$" + _amount.toString(),
                          style: TextStyle(
                              fontSize: sizeConfig.topTextHeight28,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: _categoryList.isEmpty
                      ? Text(
                          "No transactions for " + _categoryType,
                          style: TextStyle(fontSize: 22, color: greyCityLights, fontWeight: FontWeight.w500),
                        )
                      : ListView.builder(
                          itemCount: _categoryList.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return CategoryTransactionItem(_categoryList[index]);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
