import 'package:first_flutter/Core/Models/MonthlyDataTable.dart';

import '../Constants/WeekdayConstants.dart';
import '../Models/UserTransaction.dart';

class StaticMonthlyDataTable {
  static MonthlyDataTable temp = MonthlyDataTable.getInstance;

  static Future<MonthlyDataTable> calc(Map<String, dynamic> computeMap) async {
    _buildMonthlyTable(computeMap["monthlyDateArray"], computeMap["tx"], computeMap["month"], temp);
    return temp;
  }
}
//-------------------------Private functions---------------------------------------------------------------------------

///Given the monthly date array and the tx list, builds the monthly view array.
MonthlyDataTable _buildMonthlyTable(List<List<DateTime>> monthlyDateArray, List<Map<String, dynamic>> tx, int month,
    MonthlyDataTable monthlyDataTable) {
  //init category map
  monthlyDataTable.monthlyCategoryTotals = _initMonthlyCategoryTotalsMap();

  //txMap contains the transactions list from the database converted to a map
  Map<DateTime, dynamic> txMap = _createTransactionsMapFromList(tx, monthlyDataTable);

  //New return table to build the calendar.
  //Big O = (O(i * j)) but i = 6 and j = 7.
  List<List<Map<String, dynamic>>> newMonthlyDataArray = [];

  for (int i = 0; i < monthlyDateArray.length; i++) {
    List<DateTime> currentWeek = monthlyDateArray[i];
    List<Map<String, dynamic>> weeklyArray = new List(7);
    double weeklyTotal = 0.0;
    for (int j = 0; j < currentWeek.length; j++) {
      List<UserTransaction> dailyTransactionsList;
      double dailyTotal;

      if (txMap[currentWeek[j]] != null) {
        dailyTransactionsList = txMap[currentWeek[j]]["transactions"];
        dailyTotal = txMap[currentWeek[j]]["dailyTotal"];
      } else {
        dailyTransactionsList = [];
        dailyTotal = 0.0;
      }

      bool sameMonth = false;
      if (currentWeek[j].month == month) {
        sameMonth = true;
      }
      weeklyTotal = weeklyTotal + dailyTotal;

      Map<String, dynamic> currentDay = {
        "weekdayShort": weekdaysShort[j],
        "weekdayMid": weekdaysMid[j],
        "weekdayLong": weekdaysLong[j],
        "date": currentWeek[j],
        "dailyTotal": dailyTotal,
        "weeklyTotal": 0.0,
        "percWeeklySpending": 0.0,
        "transactions": dailyTransactionsList,
        "sameMonth": sameMonth
      };
      weeklyArray[j] = (currentDay);
    }

    //after creating the weekly array, iterate through each day of the week to update the daily total with the weekly total, and the % of weekly spending
    for (int m = 0; m < weeklyArray.length; m++) {
      if (weeklyTotal != 0.0) {
        double percWeeklySpending = weeklyArray[m]["dailyTotal"] / weeklyTotal;
        double weeklyTotalAmount = double.parse(weeklyTotal.toStringAsFixed(2));
        weeklyArray[m]["weeklyTotal"] = weeklyTotalAmount;
        weeklyArray[m]["percWeeklySpending"] = double.parse(percWeeklySpending.toStringAsFixed(4));
      }
    }

    newMonthlyDataArray.add(weeklyArray);
  }
  monthlyDataTable.dataTable = newMonthlyDataArray;

  return monthlyDataTable;
}

///Clear and init monthly category map
Map<String, double> _initMonthlyCategoryTotalsMap() {
  Map<String, double> categoryMap = {};
  categoryMap['Gas'] = 0.0;
  categoryMap['Food'] = 0.0;
  categoryMap['Grocceries'] = 0.0;
  categoryMap['Recurring'] = 0.0;
  categoryMap['Clothes'] = 0.0;
  categoryMap['Entertainment'] = 0.0;
  categoryMap['Transportation'] = 0.0;
  categoryMap['Misc'] = 0.0;
  return categoryMap;
}

///Using a given transactions list from SQFLite, converts the List<Map<String,dynamic>> to a Map<String,dynamic>.
///The purpose is to reorganize each transactions by the date it occured.
///@Algo
///First sets the first date in the transactions list, if the date is the same, add the transactions to the list of daily transactions.
///Else, add the daily transactions to the map with the date and then change the currentTxDate, and then create a new list.
Map<DateTime, dynamic> _createTransactionsMapFromList(
    List<Map<String, dynamic>> tx, MonthlyDataTable monthlyDataTable) {
  double sixWeekTotal = 0.0;
  double dailyTotal = 0.0;
  Map<DateTime, dynamic> txMap = {};
  Map<String, double> currentCategoryMap = monthlyDataTable.monthlyCategoryTotals;
  if (tx.length == 0) {
    monthlyDataTable.sixWeekTotal = sixWeekTotal;
    return txMap;
  }

  //initial values
  DateTime currentTxDate = DateTime.fromMillisecondsSinceEpoch(tx[0]["date"], isUtc: true);
  //List<Map<String, dynamic>> listOfDailyTx = [];
  List<UserTransaction> listOfDailyTx = [];
  //iterate through transactions list to create a map.
  //Big O = (O(n))
  for (int n = 0; n < tx.length; n++) {
    DateTime tempTxDate = DateTime.fromMillisecondsSinceEpoch(tx[n]["date"], isUtc: true);

    sixWeekTotal = sixWeekTotal + tx[n]["amount"];
    _addMonthlyCategoryTotals(tx[n]["category"], tx[n]["amount"], currentCategoryMap);

    if (tempTxDate.isAtSameMomentAs(currentTxDate)) {
      listOfDailyTx.add(UserTransaction.fromDb(tx[n]));
      dailyTotal = dailyTotal + tx[n]["amount"];
    } else {
      //ensure the double is 2 decimal places
      double dailyTotalAmount = double.parse(dailyTotal.toStringAsFixed(2));
      Map<String, dynamic> dailyMap = {"transactions": listOfDailyTx, "dailyTotal": dailyTotalAmount};
      txMap[currentTxDate] = dailyMap;

      currentTxDate = tempTxDate;

      listOfDailyTx = new List();

      listOfDailyTx.add(UserTransaction.fromDb(tx[n]));
      dailyTotal = 0.0;
      dailyTotal = dailyTotal + tx[n]["amount"];
    }
  }

  //Add one last time after iterating through the list
  double dailyTotalAmount = double.parse(dailyTotal.toStringAsFixed(2));
  Map<String, dynamic> dailyMap = {"transactions": listOfDailyTx, "dailyTotal": dailyTotalAmount};
  txMap[currentTxDate] = dailyMap;

  monthlyDataTable.sixWeekTotal = sixWeekTotal;
  return txMap;
}

///Given the category map, this function will add the current transaction amount to the amount accumulated in the category map.
void _addMonthlyCategoryTotals(String category, double amount, Map<String, double> currentCategoryMap) {
  //ensure the double is 2 decimal places
  double total = currentCategoryMap[category] + amount;

  currentCategoryMap[category] = double.parse(total.toStringAsFixed(2));
}
