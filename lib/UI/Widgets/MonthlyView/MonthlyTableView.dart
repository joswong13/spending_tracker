import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//Provider
import '../../../Core/ViewModels/MonthProvider.dart';
import 'package:first_flutter/Core/ViewModels/BottomNavBarScreenProvider.dart';

//Widgets
import './MonthlyChartBar.dart';
import '../../../Core/Constants/SizeConfig.dart';
import '../../../Core/Constants/ColorPalette.dart';

class MonthlyTableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MonthProvider monthData = Provider.of<MonthProvider>(context);
    final BottomNavBarScreenProvider indexProvider = Provider.of<BottomNavBarScreenProvider>(context);
    final SizeConfig sizeConfig = SizeConfig();

    //pass containerHeight to the MonthlyChartBar to scale the bars
    final double containerHeight = sizeConfig.blockSizeVertical * 12.5;
    final double topTextHeight = sizeConfig.blockSizeVertical * 4.1;
    final double cardTextHeight = sizeConfig.blockSizeVertical * 2.5;

    return Dismissible(
      resizeDuration: null,
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        print(direction);
        if (direction == DismissDirection.startToEnd) {
          DateTime _current = monthData.date;
          DateTime newMonth = DateTime.utc(_current.year, _current.month - 1, 1);
          monthData.changeDate(newMonth);
        } else {
          DateTime _current = monthData.date;
          DateTime newMonth = DateTime.utc(_current.year, _current.month + 1, 1);
          monthData.changeDate(newMonth);
        }
      },
      child: Column(
        children: <Widget>[
          Text(
            DateFormat.yMMM().format(monthData.date),
            style: TextStyle(fontSize: topTextHeight, color: greyCityLights, fontWeight: FontWeight.w600),
          ),
          Table(
            children: monthData.monthlyDataTable.map((week) {
              return TableRow(children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    onTap: () async {
                      await monthData.setCurrentWeekIndexFromMonthlyView(week[0]["date"]);
                      indexProvider.currentPageIndex = 1;
                    },
                    child: Container(
                      height: containerHeight,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${DateFormat.MMMd().format(week[0]["date"])} - ${DateFormat.MMMd().format(week[6]["date"])}",
                            style:
                                TextStyle(fontSize: cardTextHeight, color: greyCityLights, fontWeight: FontWeight.w600),
                          ),
                          MonthlyChartBar(week[0]["weeklyTotal"], monthData.sixWeekTotal, containerHeight),
                        ],
                      ),
                    ),
                  ),
                ),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
