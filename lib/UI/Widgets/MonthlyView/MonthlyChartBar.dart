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
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: ColorPalette.greenLightGreenishBlue, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            FractionallySizedBox(
              widthFactor: _monthlyTotal > 0.0 ? _weeklyTotal / _monthlyTotal : 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette.greenLightGreenishBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Center(
              child: Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    "\$$_weeklyTotal",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4
                        ..color = ColorPalette.greyAmericanRiver,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    "\$$_weeklyTotal",
                    style: TextStyle(
                      color: ColorPalette.greyCityLights,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
