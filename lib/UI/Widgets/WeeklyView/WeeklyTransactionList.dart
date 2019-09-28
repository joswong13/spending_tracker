import 'package:flutter/material.dart';
import './TransactionList.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/MonthProvider.dart';

class WeeklyTransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MonthProvider monthData = Provider.of<MonthProvider>(context);
    final List<Map<String, dynamic>> _data = monthData.currentWeek;

    return Container(
      child: Expanded(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return TransactionList(_data[index], _data[index]["transactions"]);
          },
          itemCount: 7,
        ),
      ),
    );
  }
}
