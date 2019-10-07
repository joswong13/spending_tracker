class MonthlyDataTable {
  double _sixWeekTotal;
  List<List<Map<String, dynamic>>> _dataTable = [];
  Map<String, double> _monthlyCategoryTotals = {};

  MonthlyDataTable._privateConstructor();

  static final MonthlyDataTable getInstance = MonthlyDataTable._privateConstructor();

  set dataTable(List<List<Map<String, dynamic>>> dataTable) {
    _dataTable.clear();
    _dataTable = dataTable;
  }

  set monthlyCategoryTotals(Map<String, double> monthlyCategoryTotals) {
    _monthlyCategoryTotals.clear();
    _monthlyCategoryTotals = monthlyCategoryTotals;
  }

  set sixWeekTotal(double total) {
    _sixWeekTotal = total;
  }

  ///Get current six week total
  double get sixWeekTotal {
    return _sixWeekTotal;
  }

  ///Get the data object
  List<List<Map<String, dynamic>>> get monthlyDataTableObject {
    return _dataTable;
  }

  List<Map<String, dynamic>> get monthlyCategoryTotalsAsList {
    List<Map<String, dynamic>> categoryList = [];
    _monthlyCategoryTotals.forEach((String category, double amount) {
      Map<String, dynamic> temp = {"category": category, "amount": amount};
      categoryList.add(temp);
    });

    return categoryList;
  }

  Map<String, double> get monthlyCategoryTotals {
    return _monthlyCategoryTotals;
  }
}
