class Month {
  int _currentWeekIndex;
  DateTime _date;
  DateTime _beginningOfMonthlyDateArray;
  DateTime _endOfMonthlyDateArray;
  List<List<DateTime>> _monthlyDateArray = [];

  //Constructor
  Month(DateTime selectedDate) {
    _date = selectedDate;
    List<int> firstAndLastDayIntsCurrentMonth = _calculateMonthObject(_date);
    _createDateArray(firstAndLastDayIntsCurrentMonth[0], firstAndLastDayIntsCurrentMonth[1], _monthlyDateArray);
    _setCurrentWeek();
  }

  //Core Functions

  ///Gets the first day of the month (Mo = 1, Tu = 2, We = 3, Th = 4, Fr = 5, Sa = 6, or Su = 7 as an int).
  ///Gets the last day of the month as an int.
  List<int> _calculateMonthObject(DateTime date) {
    List<int> firstAndLastDay = new List(2);
    DateTime beginningOfMonth = DateTime.utc(date.year, date.month, 1);
    DateTime endOfMonth = DateTime.utc(date.year, date.month + 1, 0);
    firstAndLastDay[0] = beginningOfMonth.weekday;
    firstAndLastDay[1] = endOfMonth.day;
    return firstAndLastDay;
  }

  ///Builds an list of DateTime objects for each week and then adds it to _monthlyDateArray.

  void _createDateArray(int firstDay, int numDaysInMonth, List<List<DateTime>> monthlyDateArray) {
    monthlyDateArray.clear();
    int dayCounter = (firstDay * -1) + 1;

    _beginningOfMonthlyDateArray = DateTime.utc(_date.year, _date.month, dayCounter);

    //Builds 6 weeks of the calendar month
    for (int m = 0; m < 6; m++) {
      List<DateTime> weeklyArray = new List(7);
      for (int k = 0; k < 7; k++) {
        weeklyArray[k] = DateTime.utc(_date.year, _date.month, dayCounter);
        dayCounter++;
      }
      monthlyDateArray.add(weeklyArray);
    }

    _endOfMonthlyDateArray = DateTime.utc(_date.year, _date.month, dayCounter);
  }

  ///Sets the current week for displaying in WeeklyView.
  void _setCurrentWeek() {
    for (int i = 0; i < 6; i++) {
      if (_monthlyDateArray[i].contains(_date)) {
        _currentWeekIndex = i;
      }
    }
  }

  ///Sets the a new date.
  set date(DateTime date) {
    this._date = date;
    List<int> firstAndLastDayIntsCurrentMonth = _calculateMonthObject(_date);
    _createDateArray(firstAndLastDayIntsCurrentMonth[0], firstAndLastDayIntsCurrentMonth[1], _monthlyDateArray);
    _setCurrentWeek();
  }

  ///Changes the date but will not rebuild the monthly calendar.
  void setCurrentWeekIndex(DateTime date) {
    this._date = date;
    _setCurrentWeek();
  }

  ///Changes the date but will rebuild the monthly calendar.
  void monthOrYearDiff(DateTime date) {
    this._date = date;
    List<int> firstAndLastDayIntsCurrentMonth = _calculateMonthObject(_date);
    _createDateArray(firstAndLastDayIntsCurrentMonth[0], firstAndLastDayIntsCurrentMonth[1], _monthlyDateArray);
    _setCurrentWeek();
  }

  int get currentWeekIndex {
    return _currentWeekIndex;
  }

  DateTime get date {
    return this._date;
  }

  DateTime get beginningOfMonthlyDateArray {
    return this._beginningOfMonthlyDateArray;
  }

  DateTime get endOfMonthlyDateArray {
    return this._endOfMonthlyDateArray;
  }

  ///Returns the monthly array of DateTime objects.
  List<List<DateTime>> get monthlyDateArray {
    return _monthlyDateArray;
  }
}

/**
 * @Deprecated V1
 */
// set firstWeekDayOfMonth(int firstWeekDayOfMonth) {
//   this._firstWeekDayOfMonth = firstWeekDayOfMonth;
// }

// set lastWeekDayOfMonth(int lastWeekDayOfMonth) {
//   this._lastWeekDayOfMonth = lastWeekDayOfMonth;
// }
// @override
//   String toString() {
//     // String todayString = 'Today is ' + today.toString();
//     // String startMonthString = 'Start of Month is ' + startOfMonth.toString();
//     // String endOfMonthString = 'Start of Month is ' + endOfMonth.toString();
//     // String startDayOfMonthString =
//     //     'Start of Month is ' + startDayofMonth.toString();
//     // String daysInAMonthString =
//     //     'There are ' + daysInAMonth.toString() + ' days in a month';
//     // return todayString +
//     //     '--' +
//     //     startMonthString +
//     //     '--' +
//     //     endOfMonthString +
//     //     '--' +
//     //     startDayOfMonthString +
//     //     '--' +
//     //     daysInAMonthString;
//     return "Month Model class";
//   }
// void _createArray(int firstDay, int numDaysInMonth) {
//     _monthlyArray.clear();
//     List<int> weeklyArray = new List(7);
//     int dayCounter = 1;
//     bool noBreak = true;

//     if (firstDay == 7) {
//       for (int i = 0; i < 7; i++) {
//         weeklyArray[i] = dayCounter;
//         dayCounter++;
//       }
//     } else {
//       for (int i = 0; i < firstDay; i++) {
//         weeklyArray[i] = 0;
//       }
//       for (int j = firstDay; j < 7; j++) {
//         weeklyArray[j] = dayCounter;
//         dayCounter++;
//       }
//     }

//     _monthlyArray.add(weeklyArray);

//     while (noBreak) {
//       List<int> weeklyArray = new List(7);

//       for (int k = 0; k < 7; k++) {
//         if (dayCounter > numDaysInMonth) {
//           noBreak = false;
//           weeklyArray[k] = 0;
//         } else {
//           weeklyArray[k] = dayCounter;
//           dayCounter++;
//         }
//       }
//       _monthlyArray.add(weeklyArray);
//     }
//   }
// DateTime prevMonth = DateTime.utc(_date.year, _date.month - 1, 1);
// List<int> firstAndLastDayIntsPrevMonth = _calculateMonthObject(prevMonth);
// _createDateArray(
//     firstAndLastDayIntsPrevMonth[0], firstAndLastDayIntsPrevMonth[1], _monthlyDatePage0Array, prevMonth, false);

// DateTime nextMonth = DateTime.utc(_date.year, _date.month + 1, 1);
// List<int> firstAndLastDayIntsNextMonth = _calculateMonthObject(nextMonth);
// _createDateArray(
//     firstAndLastDayIntsNextMonth[0], firstAndLastDayIntsNextMonth[1], _monthlyDatePage2Array, nextMonth, false);

// List<List<DateTime>> get monthlyDatePage0Array {
//   return _monthlyDatePage0Array;
// }

// List<List<DateTime>> get monthlyDatePage2Array {
//   return _monthlyDatePage2Array;
// }
