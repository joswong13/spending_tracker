import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../../../Core/ViewModels/MonthProvider.dart';

//Widgets
import '../../Widgets/MonthlyView/MonthlyTableView.dart';

class MonthlyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);
    return monthData.busy
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: MonthlyTableView(),
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
