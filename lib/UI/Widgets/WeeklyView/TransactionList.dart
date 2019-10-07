import 'package:flutter/material.dart';
import '../../../Core/Models/UserTransaction.dart';
import './TransactionCard.dart';
import '../../../Core/Constants/ColorPalette.dart';

class TransactionList extends StatelessWidget {
  final Map<String, Object> _data;
  final List<UserTransaction> _tx;

  TransactionList(this._data, this._tx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "${_data["weekdayLong"]}",
                    style: TextStyle(fontSize: 28, color: greyCityLights, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "\$ ${_data["dailyTotal"]}",
                  style: TextStyle(fontSize: 18, color: greenLightGreenishBlue, fontWeight: FontWeight.bold),
                ),
                Text(
                  " (${_data["percWeeklySpending"]}%)",
                  style: TextStyle(fontSize: 18, color: purpleShyMoment, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ..._tx.map((txData) {
            return TransactionCard(txData);
          })
        ],
      ),
    );
  }
}
