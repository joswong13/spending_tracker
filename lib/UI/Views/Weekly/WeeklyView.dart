import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import 'package:first_flutter/Core/ViewModels/MonthProvider.dart';

//Widgets
import '../../Widgets/WeeklyView/ChangeWeekBar.dart';
import '../../Widgets/WeeklyView/Chart.dart';
import '../../Widgets/WeeklyView/WeeklyTransactionList.dart';

class WeeklyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);

    return monthData.busy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              ChangeWeekBar(),
              Chart(),
              WeeklyTransactionList(),
            ],
          );
  }
}
