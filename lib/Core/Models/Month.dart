class Month {
  Month._privateConstructor();

  static final Month getInstance = Month._privateConstructor();

  int _currentWeekIndex;
  DateTime _date;
  DateTime _beginningOfMonthlyDateArray;
  DateTime _endOfMonthlyDateArray;
  List<List<DateTime>> _monthlyDateArray = [];

  ///Sets the a new date.
  set date(DateTime date) {
    this._date = date;
  }

  set currentWeekIndex(int index) {
    this._currentWeekIndex = index;
  }

  set beginningOfMonthlyDateArray(DateTime date) {
    this._beginningOfMonthlyDateArray = date;
  }

  set endOfMonthlyDateArray(DateTime date) {
    this._endOfMonthlyDateArray = date;
  }

  set monthlyDateArray(List<List<DateTime>> list) {
    this._monthlyDateArray = list;
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

//Given a date and the month object, sets the month object
void setDate(DateTime date, Month month) {
  //sets the month date
  month.date = date;
  List<int> firstAndLastDayIntsCurrentMonth = _calculateMonthObject(date);
  int previousMonthWeekdayStart = _calculatePreviousMonthWeekStart(firstAndLastDayIntsCurrentMonth[0]);

  //sets beginningOfMonthlyDateArray, endOfMonthlyDateArray, monthlyDateArray
  _createDateArray(previousMonthWeekdayStart, firstAndLastDayIntsCurrentMonth[1], date, month);

  //set currentweekindex
  month.currentWeekIndex = _setCurrentWeek(month.monthlyDateArray, month.date);
}

//Core Functions----------------------------------------------------------------------------------------------

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

int _calculatePreviousMonthWeekStart(int firstWeekdayOfMonth) {
  return (firstWeekdayOfMonth * -1) + 1;
}

///Builds an list of DateTime objects for each week and then adds it to _monthlyDateArray.
void _createDateArray(int dayCounter, int numDaysInMonth, DateTime date, Month month) {
  List<List<DateTime>> monthlyDateArray = [];

  month.beginningOfMonthlyDateArray = DateTime.utc(date.year, date.month, dayCounter);

  //Builds 6 weeks of the calendar month
  for (int m = 0; m < 6; m++) {
    List<DateTime> weeklyArray = new List(7);
    for (int k = 0; k < 7; k++) {
      weeklyArray[k] = DateTime.utc(date.year, date.month, dayCounter);
      dayCounter++;
    }
    monthlyDateArray.add(weeklyArray);
  }

  month.endOfMonthlyDateArray = DateTime.utc(date.year, date.month, dayCounter);

  month.monthlyDateArray = monthlyDateArray;
}

///Sets the current week for displaying in WeeklyView.
int _setCurrentWeek(List<List<DateTime>> monthlyDateArray, DateTime date) {
  int currentWeekIndex = 0;
  for (int i = 0; i < 6; i++) {
    if (monthlyDateArray[i].contains(date)) {
      currentWeekIndex = i;
      break;
    }
  }
  return currentWeekIndex;
}

//EXTERNAL FCN----------------------------------------------------------------------------------------------

///Changes the date but will not rebuild the monthly calendar.
void setCurrentWeekIndex(DateTime date, Month month) {
  month.date = date;
  month._currentWeekIndex = _setCurrentWeek(month.monthlyDateArray, month.date);
}
