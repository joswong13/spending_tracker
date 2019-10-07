import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:first_flutter/Core/Models/UserTransaction.dart';
import 'package:first_flutter/UI/Views/EditDeleteView/EditDeleteTransactionView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryTransactionList extends StatelessWidget {
  final UserTransaction _txData;

  /// Initialize constructor with UserTransaction object
  CategoryTransactionList(this._txData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return EditScreen(_txData.id, _txData.name, _txData.desc, _txData.amount, _txData.date, _txData.category,
                _txData.uploaded);
          }),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        margin: EdgeInsets.all(5),
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 3, 8, 3),
          child: Column(
            children: <Widget>[
              _txData.desc == ""
                  ? Text(
                      _txData.name,
                      style: TextStyle(color: greyCityLights, fontWeight: FontWeight.bold, fontSize: 22),
                    )
                  : Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
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
      ),
    );
  }
}

// return Container(
//       margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
//       padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: greyDraculaOrchid(),
//         border: Border.all(color: greenLightGreenishBlue(), width: 3),
//       ),
//       child: InkWell(
//         onTap: () async {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) {
//               return EditScreen(_txData.id, _txData.name, _txData.desc, _txData.amount, _txData.date, _txData.category);
//             }),
//           );
//         },
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 DateFormat.Md().format(DateTime.fromMillisecondsSinceEpoch(_txData.date, isUtc: true)),
//                 style: TextStyle(color: greyCityLights(), fontWeight: FontWeight.bold, fontSize: 22),
//               ),
//             ),
//             Expanded(
//               child: _txData.desc == ""
//                   ? Text(
//                       _txData.name,
//                       style: TextStyle(color: greyCityLights(), fontWeight: FontWeight.bold, fontSize: 22),
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           _txData.name,
//                           style: TextStyle(color: greyCityLights(), fontWeight: FontWeight.bold, fontSize: 22),
//                         ),
//                         Text(
//                           _txData.desc,
//                           style: TextStyle(color: greyCityLights(), fontSize: 16),
//                         ),
//                       ],
//                     ),
//             ),
//             Expanded(
//               child: Container(
//                 alignment: Alignment.center,
//                 child: Text(
//                   _txData.category,
//                   style: TextStyle(color: greyCityLights(), fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ),
//             ),
//             Container(
//               child: Text(
//                 _txData.amount.toString(),
//                 style: TextStyle(color: greyCityLights(), fontWeight: FontWeight.bold, fontSize: 25),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
