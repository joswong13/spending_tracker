import 'package:first_flutter/UI/Views/AddExpenseView/AddTransactionView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import 'package:first_flutter/Core/ViewModels/BottomNavBarScreenProvider.dart';

//Widgets
import '../Monthly/MonthlyView.dart';
import '../Monthly/MonthlyOverviewCard.dart';
import '../Weekly/WeeklyView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MonthlyView(),
    WeeklyView(),
    MonthlyOverviewCard(),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavBarScreenProvider indexProvider = Provider.of<BottomNavBarScreenProvider>(context);

    return Scaffold(
      body: SafeArea(child: _widgetOptions.elementAt(indexProvider.getCurrentPageIndex)),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
