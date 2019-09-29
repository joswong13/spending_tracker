import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/MonthProvider.dart';
import './ChartBar.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MonthProvider monthData = Provider.of<MonthProvider>(context);
    final List<Map<String, dynamic>> _test = monthData.currentWeek;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _test.map((data) {
            DateTime temp = data["date"];
            String dateString = temp.day.toString();
            return Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ChartBar(data["weekdayShort"], dateString, data["percWeeklySpending"]),
            );
          }).toList(),
        ),
      ),
    );
  }
}
