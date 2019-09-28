import 'package:flutter/material.dart';

class CategoryTransactionView extends StatelessWidget {
  final String _categoryType;

  CategoryTransactionView(this._categoryType);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(_categoryType),
            RaisedButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
