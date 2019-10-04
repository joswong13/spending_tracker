import 'package:flutter/material.dart';
import '../../../Core/Models/UserTransaction.dart';
import '../../../Core/Constants/ColorPalette.dart';
import '../../Views/EditDeleteView/EditDeleteTransactionView.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final UserTransaction _txData;

  /// Initialize constructor with UserTransaction object
  TransactionCard(this._txData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return EditScreen(_txData.id, _txData.name, _txData.desc, _txData.amount, _txData.date, _txData.category);
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 3),
        padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: greyDraculaOrchid,
        ),
        child: Column(
          children: <Widget>[
            _txData.desc == ""
                ? Text(
                    _txData.name,
                    style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 22),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _txData.name,
                        style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        _txData.desc,
                        style: TextStyle(color: greyCityLights, fontSize: 16),
                      ),
                    ],
                  ),
            Divider(
              color: greyCityLights,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat.Md().format(DateTime.fromMillisecondsSinceEpoch(_txData.date, isUtc: true)),
                  style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  _txData.category,
                  style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  _txData.amount.toString(),
                  style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
