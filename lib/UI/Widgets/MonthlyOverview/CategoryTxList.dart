import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:first_flutter/Core/Models/UserTransaction.dart';
import 'package:first_flutter/UI/Views/EditDeleteView/EditDeleteTransactionView.dart';
import 'package:flutter/material.dart';

class CategoryTransactionList extends StatelessWidget {
  final UserTransaction _txData;

  /// Initialize constructor with UserTransaction object
  CategoryTransactionList(this._txData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: greyDraculaOrchid(),
        border: Border.all(color: greenLightGreenishBlue(), width: 3),
      ),
      child: InkWell(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return EditScreen(_txData.id, _txData.name, _txData.desc, _txData.amount, _txData.date, _txData.category);
            }),
          );
        },
        child: Row(
          children: <Widget>[
            _txData.desc == ""
                ? Text(
                    _txData.name,
                    style: TextStyle(color: greenLightGreenishBlue(), fontWeight: FontWeight.bold, fontSize: 22),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _txData.name,
                        style: TextStyle(color: greenLightGreenishBlue(), fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        _txData.desc,
                        style: TextStyle(color: greenLightGreenishBlue(), fontSize: 16),
                      ),
                    ],
                  ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  _txData.category,
                  style: TextStyle(color: greenLightGreenishBlue(), fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Container(
              child: Text(
                _txData.amount.toString(),
                style: TextStyle(color: greenLightGreenishBlue(), fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
