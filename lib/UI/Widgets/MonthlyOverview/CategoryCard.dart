import 'package:first_flutter/Core/ViewModels/MonthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Views/CategoryTransactionView/CategoryTransactionView.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CategoryCard extends StatelessWidget {
  final String _category;
  final double _amount;
  final Color _color1;
  final Color _color2;

  ///The widget that displays the category, amount and also is rendered with a gradient given 2 colors.
  ///Clicking on this widget will use Navigator.push to go to the CategoryTransactionView.dart.
  CategoryCard(this._category, this._amount, this._color1, this._color2);

  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);
    //preload getListOfCategoryTransactions
    return Expanded(
      child: InkWell(
        onTap: () {
          monthData.categoryType = _category;
          monthData.getListOfCategoryTransactions().then((resp) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return CategoryTransactionView(monthData.categoryUserTransactionList, _category, _amount);
              }),
            );
          });
        },
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [_color1, _color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _category,
                style: TextStyle(fontSize: 24),
              ),
              AutoSizeText(
                "\$" + _amount.toString(),
                style: TextStyle(fontSize: 24),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
