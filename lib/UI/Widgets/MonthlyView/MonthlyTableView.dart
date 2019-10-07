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
  final SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    final MonthProvider monthData = Provider.of<MonthProvider>(context);
    final BottomNavBarScreenProvider indexProvider = Provider.of<BottomNavBarScreenProvider>(context);

    //pass containerHeight to the MonthlyChartBar to scale the bars
    final double containerHeight = sizeConfig.blockSizeVertical * 12.5;
    //Fontsize 17 eqv.
    final double cardTextHeight = sizeConfig.blockSizeVertical * 2.5;

    return Table(
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
                      style: TextStyle(fontSize: cardTextHeight, color: greyCityLights, fontWeight: FontWeight.w600),
                    ),
                    MonthlyChartBar(week[0]["weeklyTotal"], monthData.sixWeekTotal, containerHeight),
                  ],
                ),
              ),
            ),
          ),
        ]);
      }).toList(),
    );
  }
}
