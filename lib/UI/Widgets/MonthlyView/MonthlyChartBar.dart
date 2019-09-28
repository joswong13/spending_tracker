import 'package:flutter/material.dart';
import '../../../Core/Constants/ColorPalette.dart';

class MonthlyChartBar extends StatelessWidget {
  final double _weeklyTotal;
  final double _monthlyTotal;
  final double _boxHeight;

  MonthlyChartBar(this._weeklyTotal, this._monthlyTotal, this._boxHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _boxHeight * 8.8,
      //margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: greenLightGreenishBlue(), width: 3),
                //color: barBgColor(),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            FractionallySizedBox(
              widthFactor: _monthlyTotal > 0.0 ? _weeklyTotal / _monthlyTotal : 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: greenLightGreenishBlue(),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Center(
              child: Text(
                "\$$_weeklyTotal",
                style: TextStyle(
                  color: greyCityLights(),
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
                // style: TextStyle(
                //   color: greyDraculaOrchid(),
                //   fontSize: 38,
                //   fontWeight: FontWeight.bold,
                //   shadows: <Shadow>[
                //     Shadow(
                //       offset: Offset(2, 2),
                //       blurRadius: 4.0,
                //       color: greyCityLights(),
                //     ),
                //   ],
                // ),
              ),
            )
          ],
          overflow: Overflow.clip,
        ),
      ),
    );
  }
}

// Column(
//       children: <Widget>[
//         SizedBox(
//           height: 4,
//         ),
//         //Text(this._boxHeight.toString()),
//         Container(
//           height: _boxHeight * 8,
//           //padding: EdgeInsets.fromLTRB(12.8, 0, 12.8, 0),
//           child: Stack(
//             alignment: AlignmentDirectional.bottomEnd,
//             children: <Widget>[
//               Container(
//                 decoration: BoxDecoration(
//                   color: barBgColor(),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               FractionallySizedBox(
//                 //alignment: Alignment.bottomCenter,
//                 heightFactor: _percWeeklyTotal,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: barColor(),
//                     // gradient:
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                 ),
//               )
//             ],
//             overflow: Overflow.clip,
//           ),
//         ),
//         SizedBox(
//           height: 4,
//         ),
//       ],
//     );
