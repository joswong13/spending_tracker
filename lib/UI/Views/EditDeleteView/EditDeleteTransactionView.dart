import 'package:first_flutter/Core/Constants/ColorPalette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/MonthProvider.dart';
import '../../Widgets/Dialog/AddTxDialogPickers.dart';
import '../../Widgets/Dialog/DeleteDialog.dart';

class EditScreen extends StatefulWidget {
  final String name;
  final String desc;
  final double amount;
  final int date;
  final String category;
  final int id;
  final int uploaded;

  EditScreen(this.id, this.name, this.desc, this.amount, this.date, this.category, this.uploaded);

  @override
  _TransactionScreenState createState() => _TransactionScreenState(name, desc, amount, date, category);
}

class _TransactionScreenState extends State<EditScreen> {
  //Variables
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String _errorMsg;
  DateTime _selectedDate;
  String _category = "Food";

  _TransactionScreenState(String name, String desc, double amount, int date, String category) {
    nameController = TextEditingController(text: name);
    descController = TextEditingController(text: desc);
    amountController = TextEditingController(text: amount.toString());
    _selectedDate = DateTime.fromMillisecondsSinceEpoch(date, isUtc: true);
    _category = category;
  }

//----------------------------------------------Functions-----------------------------------------
  void _setCategoryState(String category) {
    setState(() {
      _category = category;
    });
  }

//----------------------------------------------Widgets-----------------------------------------
  ///Returns an InputDecoration widget that styles the text input fields with their respective clear functions.
  InputDecoration _textDecoration(String label, String hintValue, int fieldClears) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: greyCityLights),
      hintText: hintValue,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      suffixIcon: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (fieldClears == 0) {
            _nameClear();
          } else if (fieldClears == 1) {
            _descClear();
          } else {
            _amountClear();
          }
        },
      ),
    );
  }

  Text _errorMessage() {
    if (_errorMsg == null) {
      return Text("");
    } else {
      return Text(
        _errorMsg,
        style: TextStyle(
          color: Colors.red[300],
          fontSize: 22,
        ),
      );
    }
  }

//----------------------------------------------Clear Functions-----------------------------------------
  void _amountClear() {
    amountController.clear();
  }

  void _nameClear() {
    nameController.clear();
  }

  void _descClear() {
    descController.clear();
  }

//----------------------------------------------On Submit Functions-----------------------------------------

  ///Checks if the required fields are filled out.
  bool _checkValidFields() {
    double _tempAmount;
    try {
      _tempAmount = double.parse(amountController.text);
    } catch (e) {
      setState(() {
        _errorMsg = "Amount is empty!";
      });
      return false;
    }

    if (nameController.text == "") {
      setState(() {
        _errorMsg = "Name is not filled in!";
      });
      return false;
    } else if (_tempAmount <= 0.00) {
      setState(() {
        _errorMsg = "Amount is not correct!";
      });
      return false;
    } else if (_selectedDate == null) {
      setState(() {
        _errorMsg = "Date has not been picked!";
      });
      return false;
    }
    return true;
  }

  /// Trims the text from the text controllers.
  String _trimText(String s) {
    String cleanedString = s.trim();
    return cleanedString;
  }

  @override
  Widget build(BuildContext context) {
    final monthData = Provider.of<MonthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Edit Transaction",
                  style: const TextStyle(fontSize: 28, color: greyCityLights, fontWeight: FontWeight.w600),
                ),
                TextField(
                  style: TextStyle(color: greyCityLights),
                  decoration: _textDecoration('Name', 'Enter transaction name', 0),
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                ),
                TextField(
                  style: TextStyle(color: greyCityLights),
                  decoration: _textDecoration('Description', '(Optional) Enter description', 1),
                  controller: descController,
                  textCapitalization: TextCapitalization.words,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: greyCityLights),
                  decoration: _textDecoration('Amount', 'Enter the amount (eg. 0.00)', 2),
                  controller: amountController,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: const Text(
                          'Category:',
                          style: TextStyle(color: greyCityLights, fontSize: 18),
                        ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          _category,
                          style: TextStyle(color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          categoryDialog(context).then((String resp) {
                            _setCategoryState(resp);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null ? 'No Date Chosen' : DateFormat.yMd().format(_selectedDate),
                          style: TextStyle(
                            color: greyCityLights,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          'Choose Date',
                          style: TextStyle(color: Colors.black),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          presentDatePicker(context, _selectedDate).then((DateTime resp) {
                            setState(() {
                              _selectedDate = resp;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                _errorMessage()
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: "backButton",
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back"),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            FloatingActionButton.extended(
              heroTag: "deleteButton",
              icon: const Icon(Icons.delete),
              label: const Text("Delete"),
              onPressed: () async {
                bool deleteConfirmation = await deleteDialog(context);
                if (deleteConfirmation) {
                  monthData.deleteUserTransaction(widget.id).then((resp) async {
                    if (resp == 1) {
                      await monthData.refreshTransactions();
                      Navigator.pop(context);
                    }
                  });
                }
              },
            ),
            FloatingActionButton.extended(
              heroTag: "editButton",
              icon: const Icon(Icons.edit),
              label: const Text("Edit"),
              onPressed: () {
                bool checkValue = _checkValidFields();
                if (checkValue) {
                  monthData
                      .updateUserTransaction(
                          widget.id,
                          _trimText(nameController.text),
                          double.parse(amountController.text),
                          _trimText(descController.text),
                          _selectedDate,
                          _category,
                          widget.uploaded)
                      .then((resp) async {
                    if (resp == 1) {
                      await monthData.refreshTransactions();
                      Navigator.pop(context);
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
