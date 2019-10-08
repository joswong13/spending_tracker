import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:first_flutter/Core/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//Provider
import '../../../Core/ViewModels/MonthProvider.dart';

//Widgets
import '../../Widgets/MonthlyView/MonthlyTableView.dart';

class MonthlyView extends StatelessWidget {
  final SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);

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
            onDismissed: (DismissDirection direction) {
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
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Column(
                children: <Widget>[
                  Text(
                    DateFormat.yMMM().format(monthData.date),
                    style:
                        TextStyle(fontSize: sizeConfig.topHeight28, color: greyCityLights, fontWeight: FontWeight.w600),
                  ),
                  MonthlyTableView(),
                ],
              ),
            ),
          );
  }
}
//final List<Widget> _pages = [MonthlyTableView(), MonthlyOverviewCard()];
// Container(
//             padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
//             child: PageView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: 2,
//               itemBuilder: (context, position) {
//                 return _pages[position];
//               },
//             ),
//           );
