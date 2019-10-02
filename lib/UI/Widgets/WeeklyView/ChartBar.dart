import 'package:flutter/material.dart';
import '../../../Core/Constants/ColorPalette.dart';

class ChartBar extends StatelessWidget {
  final String _weekday;
  final String _date;
  final double _percWeeklyTotal;

  ///This class displays the individual chart bars inside the Chart Widget. The parent of this widget is the Chart Widget.
  ChartBar(this._weekday, this._date, this._percWeeklyTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(_weekday),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          padding: EdgeInsets.fromLTRB(12.8, 0, 12.8, 0),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: ColorPalette.greenLightGreenishBlue, width: 3),
                  //color: barBgColor(),
                  // gradient: LinearGradient(
                  //     begin: Alignment.bottomRight,
                  //     end: Alignment.topLeft,
                  //     stops: [0.3, 0.9],
                  //     colors: [Colors.purple[900], Colors.deepPurple[600]]),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              FractionallySizedBox(
                //alignment: Alignment.bottomCenter,
                heightFactor: _percWeeklyTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.greenLightGreenishBlue,
                    // gradient: LinearGradient(
                    //     begin: Alignment.bottomRight,
                    //     end: Alignment.topLeft,
                    //     stops: [0.3, 0.9],
                    //     colors: [Colors.blue[600], Colors.blue[300]]),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(_date),
      ],
    );
  }
}
