import 'package:first_flutter/Core/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//Provider
import 'package:first_flutter/Core/ViewModels/MonthProvider.dart';

//Widgets
import '../../Widgets/WeeklyView/Chart.dart';
import '../../Widgets/WeeklyView/WeeklyTransactionList.dart';

class WeeklyView extends StatelessWidget {
  final SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);
    List<DateTime> displayWeekRange = monthData.beginningAndEndDates;

    return monthData.busy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Dismissible(
            background: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.chevron_left,
                size: 55,
                color: Theme.of(context).primaryColor,
              ),
            ),
            secondaryBackground: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.chevron_right,
                size: 55,
                color: Theme.of(context).primaryColor,
              ),
            ),
            resizeDuration: null,
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) async {
              if (direction == DismissDirection.startToEnd) {
                DateTime _current = displayWeekRange[0];
                DateTime newMonth = DateTime.utc(_current.year, _current.month, _current.day - 7);
                await monthData.changeDate(newMonth);
              } else {
                DateTime _current = displayWeekRange[0];
                DateTime newMonth = DateTime.utc(_current.year, _current.month, _current.day + 7);
                await monthData.changeDate(newMonth);
              }
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                children: <Widget>[
                  Text(
                      "${DateFormat.MMMd().format(displayWeekRange[0])} - ${DateFormat.MMMd().format(displayWeekRange[1])}",
                      style: TextStyle(fontSize: sizeConfig.topHeight28)),
                  Chart(),
                  WeeklyTransactionList(),
                ],
              ),
            ),
          );
  }
}
