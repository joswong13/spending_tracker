import 'package:first_flutter/Core/ViewModels/MonthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Views/CategoryTransactionView/CategoryTransactionView.dart';

class CategoryCard extends StatelessWidget {
  final String _category;
  final double _amount;
  final Color _color1;
  final Color _color2;

  CategoryCard(this._category, this._amount, this._color1, this._color2);

  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);

    return Expanded(
      child: InkWell(
        onTap: () {
          monthData.getListOfCategoryTransactions(_category).then((resp) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return CategoryTransactionView(resp, _category);
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
              Text(
                _amount.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
