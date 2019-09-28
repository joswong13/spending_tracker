import 'package:flutter/material.dart';

enum Category { GAS, FOOD, GROCCERIES, RECURRING, CLOTHES, ENTERTAINMENT, TRANSPORTATION, MISC }

Future<DateTime> presentDatePicker(BuildContext context, DateTime selectedDate) async {
  DateTime datePicked = await showDatePicker(
    context: context,
    initialDate: selectedDate == null ? DateTime.now() : selectedDate,
    firstDate: DateTime(2019),
    lastDate: DateTime.now(),
  );
  if (datePicked == null) {
    return selectedDate;
  } else {
    return DateTime.utc(datePicked.year, datePicked.month, datePicked.day);
  }
}

Future<String> categoryDialog(BuildContext context) async {
  Category category = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text('Select Category'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Clothes'),
              onPressed: () {
                Navigator.pop(context, Category.CLOTHES);
              },
            ),
            SimpleDialogOption(
              child: Text('Entertainment'),
              onPressed: () {
                Navigator.pop(context, Category.ENTERTAINMENT);
              },
            ),
            SimpleDialogOption(
              child: Text('Food'),
              onPressed: () {
                Navigator.pop(context, Category.FOOD);
              },
            ),
            SimpleDialogOption(
              child: Text('Gas'),
              onPressed: () {
                Navigator.pop(context, Category.GAS);
              },
            ),
            SimpleDialogOption(
              child: Text('Grocceries'),
              onPressed: () {
                Navigator.pop(context, Category.GROCCERIES);
              },
            ),
            SimpleDialogOption(
              child: Text('Misc.'),
              onPressed: () {
                Navigator.pop(context, Category.MISC);
              },
            ),
            SimpleDialogOption(
              child: Text('Recurring'),
              onPressed: () {
                Navigator.pop(context, Category.RECURRING);
              },
            ),
            SimpleDialogOption(
              child: Text('Transportation'),
              onPressed: () {
                Navigator.pop(context, Category.TRANSPORTATION);
              },
            ),
          ],
        );
      });

  //return category.toString();
  switch (category) {
    case Category.CLOTHES:
      return "Clothes";
      break;
    case Category.ENTERTAINMENT:
      return "Entertainment";
      break;
    case Category.FOOD:
      return "Food";
      break;
    case Category.GAS:
      return "Gas";
      break;
    case Category.GROCCERIES:
      return "Grocceries";
      break;
    case Category.MISC:
      return "Misc.";
      break;
    case Category.RECURRING:
      return "Recurring";
      break;
    case Category.TRANSPORTATION:
      return "Transportation";
      break;
    default:
      return "Food";
  }
}
