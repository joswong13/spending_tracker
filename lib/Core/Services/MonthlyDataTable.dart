import '../Constants/WeekdayConstants.dart';
import '../Models/UserTransaction.dart';

class MonthlyDataTable {
  double _sixWeekTotal;
  List<List<Map<String, dynamic>>> _weeklyDataTableObject;
  Map<String, double> _monthlyCategoryTotals = {};

//----------------------------------------------Core Functions-----------------------------------------

  ///Clear and init monthly category map
  void _initMonthlyCategoryTotalsMap() {
    //clear monthlyCategoryTotal map
    _monthlyCategoryTotals.clear();
    _monthlyCategoryTotals['Gas'] = 0.0;
    _monthlyCategoryTotals['Food'] = 0.0;
    _monthlyCategoryTotals['Grocceries'] = 0.0;
    _monthlyCategoryTotals['Recurring'] = 0.0;
    _monthlyCategoryTotals['Clothes'] = 0.0;
    _monthlyCategoryTotals['Entertainment'] = 0.0;
    _monthlyCategoryTotals['Transportation'] = 0.0;
    _monthlyCategoryTotals['Misc'] = 0.0;
  }

  ///Given the monthly date array and the tx list, builds the monthly view array.
  List<List<Map<String, dynamic>>> _buildMonthlyTable(
      List<List<DateTime>> monthlyDateArray, List<Map<String, dynamic>> tx, int month) {
    //init category map
    _initMonthlyCategoryTotalsMap();

    //txMap contains the transactions list from the database converted to a map
    Map<DateTime, dynamic> txMap = _createTransactionsMapFromList(tx);

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
          "weekdayShort": WeekdayConstants.weekdaysShort[j],
          "weekdayMid": WeekdayConstants.weekdaysMid[j],
          "weekdayLong": WeekdayConstants.weekdaysLong[j],
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
    return newMonthlyDataArray;
  }

  ///Using a given transactions list from SQFLite, converts the List<Map<String,dynamic>> to a Map<String,dynamic>.
  ///The purpose is to reorganize each transactions by the date it occured.
  ///@Algo
  ///First sets the first date in the transactions list, if the date is the same, add the transactions to the list of daily transactions.
  ///Else, add the daily transactions to the map with the date and then change the currentTxDate, and then create a new list.
  Map<DateTime, dynamic> _createTransactionsMapFromList(List<Map<String, dynamic>> tx) {
    double sixWeekTotal = 0.0;
    double dailyTotal = 0.0;
    Map<DateTime, dynamic> txMap = {};

    if (tx.length == 0) {
      _sixWeekTotal = sixWeekTotal;
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
      _addMonthlyCategoryTotals(tx[n]["category"], tx[n]["amount"]);

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

    _sixWeekTotal = sixWeekTotal;
    return txMap;
  }

  void _addMonthlyCategoryTotals(String category, double amount) {
    //ensure the double is 2 decimal places
    double total = _monthlyCategoryTotals[category] + amount;

    _monthlyCategoryTotals[category] = double.parse(total.toStringAsFixed(2));
  }

  //----------------------------------------------Getters-----------------------------------------

  ///Get current six week total
  double get sixWeekTotal {
    return _sixWeekTotal;
  }

  ///Get the data object
  List<List<Map<String, dynamic>>> get monthlyDataTableObject {
    return _weeklyDataTableObject;
  }

  List<Map<String, dynamic>> get monthlyCategoryTotals {
    List<Map<String, dynamic>> categoryList = [];
    _monthlyCategoryTotals.forEach((String category, double amount) {
      Map<String, dynamic> temp = {"category": category, "amount": amount};
      categoryList.add(temp);
    });

    return categoryList;
  }

  //----------------------------------------------External Functions-----------------------------------------

  void recalculateMonthlyDataTableObject(
      List<List<DateTime>> monthlyDateArray, List<Map<String, dynamic>> tx, int month) {
    _weeklyDataTableObject = _buildMonthlyTable(monthlyDateArray, tx, month);
  }
}

class StaticMonthlyDataTable {
  static MonthlyDataTable temp = MonthlyDataTable();
  static double _sixWeekTotal = 0;

  static Future<MonthlyDataTable> calc(Map<String, dynamic> computeMap) async {
    temp.recalculateMonthlyDataTableObject(computeMap["monthlyDateArray"], computeMap["tx"], computeMap["month"]);

    return temp;
  }
}
