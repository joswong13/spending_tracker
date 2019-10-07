import 'package:flutter/material.dart';

enum Confirmation { YES, NO }

Future<bool> deleteDialog(BuildContext context) async {
  Confirmation confirmation = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: const Text('Delete this transaction?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, Confirmation.YES);
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, Confirmation.NO);
              },
            ),
          ],
        );
      });

  //return category.toString();
  switch (confirmation) {
    case Confirmation.YES:
      return true;
      break;
    case Confirmation.NO:
      return false;
      break;
    default:
      return false;
  }
}
