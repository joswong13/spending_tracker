import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../Core/ViewModels/MonthProvider.dart';

class ChangeWeekBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);
    List<DateTime> displayWeekRange = monthData.beginningAndEndDates;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () async {
              DateTime _current = monthData.date;
              DateTime newMonth = DateTime.utc(_current.year, _current.month, _current.day - 7);
              print("[ChangeWeekBar] - Left Chevron - " + newMonth.toString());
              await monthData.changeDate(newMonth);
            },
          ),
          Text("${DateFormat.MMMd().format(displayWeekRange[0])} - ${DateFormat.MMMd().format(displayWeekRange[1])}",
              style: TextStyle(fontSize: 22)),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () async {
              DateTime _current = monthData.date;
              DateTime newMonth = DateTime.utc(_current.year, _current.month, _current.day + 7);
              print("[ChangeWeekBar] - Right Chevron - " + newMonth.toString());
              await monthData.changeDate(newMonth);
            },
          )
        ],
      ),
    );
  }
}
