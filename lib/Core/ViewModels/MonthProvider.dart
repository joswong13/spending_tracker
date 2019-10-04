import 'package:first_flutter/Core/Models/MonthlyDataTable.dart';
import 'package:first_flutter/Core/Models/UserTransaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Models/Month.dart';
import '../Services/MonthlyDataTable.dart';
import '../Services/Sqflite/DatabaseHelper.dart';

class MonthProvider with ChangeNotifier {
  //MonthlyDataTable _monthlyDataTable = MonthlyDataTable();
  Month monthInstance = Month.getInstance;
  MonthlyDataTable dataTable = MonthlyDataTable.getInstance;
  bool _busy = false;
  DataBaseHelper databaseHelper = DataBaseHelper();
  String _categoryType = '';
  List<UserTransaction> _categoryUserTransactionList = [];

  ///Generate initial calendar and query from database.
  MonthProvider() {
    _setBusy(true);
    setDate(DateTime.now(), monthInstance);

    _getUserTransactionsBetween().then((listOfUserTx) async {
      Map<String, dynamic> temp = {
        "monthlyDateArray": monthInstance.monthlyDateArray,
        "tx": listOfUserTx,
        "month": monthInstance.date.month,
      };

      await compute(StaticMonthlyDataTable.calc, temp).then((resp) {
        dataTable = resp;
        _setBusy(false);
      });
    });
  }

  //----------------------------------------------Core Functions-----------------------------------------

  ///Sets busy status or not busy status. The only method used to notify listeners.
  void _setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  ///Check if given date is same month and year as current date. If not, then change date, build MonthlyDateArray and then build MonthlyDataTable.
  ///Used for Reset button and Changing months by swiping left and right.
  Future<void> _changeDateAndQuery(DateTime date) async {
    if (date.year != monthInstance.date.year || date.month != monthInstance.date.month) {
      print("[MonthProvider] - monthOrYearDiff called");
      _setBusy(true);
      setDate(date, monthInstance);

      //Query
      //Call build table fcn
      List<Map<String, dynamic>> listOfUserTx = await _getUserTransactionsBetween();
      Map<String, dynamic> temp = {
        "monthlyDateArray": monthInstance.monthlyDateArray,
        "tx": listOfUserTx,
        "month": monthInstance.date.month,
      };
      await compute(StaticMonthlyDataTable.calc, temp).then((resp) {
        dataTable = resp;
        _setBusy(false);
      });
    } else {
      print("[MonthProvider] - setCurrentWeekIndex called");
      //No need to call query if same month (if user is pressing reset when they are on the same month and year)
      _setBusy(true);
      setCurrentWeekIndex(date, monthInstance);
      _setBusy(false);
    }
  }

  //----------------------------------------------Setters-----------------------------------------
  set categoryType(String category) {
    _categoryType = category;
  }

  //----------------------------------------------Getters-----------------------------------------

  ///Get the date currently selected.
  DateTime get date {
    return monthInstance.date;
  }

  ///Returns the full month list object.
  List<List<Map<String, dynamic>>> get monthlyDataTable {
    return dataTable.monthlyDataTableObject;
  }

  ///Gets the current week's index and returns the current weeks full list object.
  List<Map<String, dynamic>> get currentWeek {
    return dataTable.monthlyDataTableObject[monthInstance.currentWeekIndex];
  }

  /// Returns the first day of the week and last day of the week as a DateTime object.
  List<DateTime> get beginningAndEndDates {
    List<Map<String, dynamic>> tempWeek = currentWeek;

    List<DateTime> returnDateList = [];
    returnDateList.add(tempWeek[0]["date"]);
    returnDateList.add(tempWeek[6]["date"]);

    return returnDateList;
  }

  double get sixWeekTotal {
    return dataTable.sixWeekTotal;
  }

  ///Used to set widget tree status. Returns the value of the busy status.
  bool get busy {
    return _busy;
  }

  ///Returns a list of maps for each category.
  List<Map<String, dynamic>> get monthlyCategoryTotals {
    return dataTable.monthlyCategoryTotalsAsList;
  }

  List<UserTransaction> get categoryUserTransactionList {
    return _categoryUserTransactionList;
  }

  //----------------------------------------------External Functions-----------------------------------------

  ///Changes the current date in Provider to the one selected.
  Future<void> changeDate(DateTime date) async {
    await _changeDateAndQuery(date);
  }

  ///Resets the current date in Provider to today.
  Future<void> reset() async {
    DateTime resetToCurrentDate = DateTime.now();
    await _changeDateAndQuery(DateTime.utc(resetToCurrentDate.year, resetToCurrentDate.month, resetToCurrentDate.day));
  }

  ///Refreshes the current queried transactions after inserting/updating/deleting a transaction.
  Future<void> refreshTransactions() async {
    _setBusy(true);
    setDate(date, monthInstance);

    //Query
    //Call build table fcn
    List<Map<String, dynamic>> listOfUserTx = await _getUserTransactionsBetween();

    Map<String, dynamic> temp = {
      "monthlyDateArray": monthInstance.monthlyDateArray,
      "tx": listOfUserTx,
      "month": monthInstance.date.month,
    };

    if (_categoryType != "") {
      getListOfCategoryTransactions();
    }

    await compute(StaticMonthlyDataTable.calc, temp).then((resp) {
      dataTable = resp;
      _setBusy(false);
    });
  }

  ///Changes the current week index in the monthly object when clicking from MonthlyView.
  Future<void> setCurrentWeekIndexFromMonthlyView(DateTime date) async {
    print("[MonthProvider] - setCurrentWeekFromMonthlyView called");
    _setBusy(true);
    setCurrentWeekIndex(date, monthInstance);
    _setBusy(false);
  }

  ///Using the categoryType in the MonthProvider object, does a SQL search. Then converts each transaction to a UserTransaction object.
  Future<void> getListOfCategoryTransactions() async {
    _setBusy(true);
    _categoryUserTransactionList.clear();

    await _getCategoryList(_categoryType).then((resp) {
      for (int i = 0; i < resp.length; i++) {
        _categoryUserTransactionList.add(UserTransaction.fromDb(resp[i]));
      }
    });

    _setBusy(false);
  }

  //----------------------------------------------SQFLite Core Functions-----------------------------------------

  ///Given the name, amount, desc, date, and category; insert into the database as an UserTransaction object.
  Future<void> insertUserTransaction(String name, double amount, String desc, DateTime date, String category) {
    UserTransaction tx = UserTransaction();
    tx.name = name;
    tx.amount = amount;
    tx.desc = desc;
    tx.date = date.millisecondsSinceEpoch;
    tx.category = category;

    return databaseHelper.insertUserTransaction(tx);
  }

  ///Given the id, name, amount, desc, date, and category; update the transaction.
  Future<int> updateUserTransaction(int id, String name, double amount, String desc, DateTime date, String category) {
    UserTransaction tx = UserTransaction();
    tx.id = id;
    tx.name = name;
    tx.amount = amount;
    tx.desc = desc;
    tx.date = date.millisecondsSinceEpoch;
    tx.category = category;

    return databaseHelper.updateUserTransaction(tx);
  }

  ///Given the id, delete the transaction from the database.
  Future<int> deleteUserTransaction(int id) {
    return databaseHelper.deleteUserTransaction(id);
  }

  ///Gets all the user transaction.
  ///Not used in any of the widgets.
  Future<List<Map<String, dynamic>>> getAllUserTransaction() async {
    return await databaseHelper.getAllUserTransactionList();
  }

  ///Private function that gets all the user transaction.
  Future<List<Map<String, dynamic>>> _getCategoryList(String category) async {
    int beginningOfQuery = monthInstance.beginningOfMonthlyDateArray.millisecondsSinceEpoch;
    int endOfQuery = monthInstance.endOfMonthlyDateArray.millisecondsSinceEpoch;

    return await databaseHelper.getCategoryList(beginningOfQuery, endOfQuery, category);
  }

  ///Private function that is called when the Month object is refreshed.
  Future<List<Map<String, dynamic>>> _getUserTransactionsBetween() async {
    int beginningOfQuery = monthInstance.beginningOfMonthlyDateArray.millisecondsSinceEpoch;
    int endOfQuery = monthInstance.endOfMonthlyDateArray.millisecondsSinceEpoch;

    return await databaseHelper.getUserTransactionsBetween(beginningOfQuery, endOfQuery);
  }
}
