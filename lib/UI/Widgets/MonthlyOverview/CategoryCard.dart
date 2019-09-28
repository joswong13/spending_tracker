import 'package:flutter/material.dart';
import '../../Views/CategoryTransactionView/CategoryTransactionView.dart';

class CategoryCard extends StatelessWidget {
  final String _category;
  final double _amount;
  final Color _color1;
  final Color _color2;

  CategoryCard(this._category, this._amount, this._color1, this._color2);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          print("TAPPED");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return CategoryTransactionView(_category);
            }),
          );
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
