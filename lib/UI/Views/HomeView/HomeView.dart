import 'package:first_flutter/Core/Constants/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import 'package:first_flutter/Core/ViewModels/BottomNavBarScreenProvider.dart';
import 'package:first_flutter/Core/ViewModels/MonthProvider.dart';

//Widgets
import 'package:first_flutter/UI/Views/AddExpenseView/AddTransactionView.dart';
import '../Monthly/MonthlyView.dart';
import '../CategoryTransactionView/CategoryOverviewCard.dart';
import '../Weekly/WeeklyView.dart';
import '../../Widgets/Dialog/MonthYearDialog.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MonthlyView(),
    WeeklyView(),
    CategoryOverviewCard(),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavBarScreenProvider indexProvider = Provider.of<BottomNavBarScreenProvider>(context);
    final monthData = Provider.of<MonthProvider>(context);
    final SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initValues(context);

    //BottomNavBar is always 8% of usable screen
    final bottomNavBarHieght = sizeConfig.blockSizeVertical * 8;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _widgetOptions.elementAt(indexProvider.getCurrentPageIndex),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    iconSize: sizeConfig.topHeight28,
                    color: Theme.of(context).primaryColor,
                    tooltip: "Reset",
                    onPressed: () {
                      monthData.changeDate(DateTime.now());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.date_range),
                    iconSize: sizeConfig.topHeight28,
                    color: Theme.of(context).primaryColor,
                    tooltip: "Pick date",
                    onPressed: () async {
                      DateTime pickedDate = await monthYearPicker(context, monthData.date);
                      monthData.changeDate(pickedDate);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: bottomNavBarHieght,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Monthly'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_week),
              title: Text('Weekly'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('Category'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              title: Text('Add'),
              backgroundColor: Colors.black,
            ),
          ],
          currentIndex: indexProvider.getCurrentPageIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: (int index) {
            if (index <= 2) {
              indexProvider.currentPageIndex = index;
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return TransactionScreen();
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
