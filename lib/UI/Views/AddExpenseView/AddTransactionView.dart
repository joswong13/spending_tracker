import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/MonthProvider.dart';
import '../../Widgets/AddExpenseView/DialogPickers.dart';
import '../../../Core/Constants/ColorPalette.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  //Variables
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final amountController = TextEditingController();
  String _errorMsg;
  DateTime _selectedDate;
  String _category = "Food";
  bool _transactionAdded = false;

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
      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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

  ///After submitting, clears and resets the form.
  void _afterSubmit() {
    setState(() {
      _errorMsg = null;
      _amountClear();
      _nameClear();
      _descClear();
      _category = "Food";
      _selectedDate = null;
      _transactionAdded = true;
    });
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
                  "Add Transaction",
                  style: TextStyle(fontSize: 28, color: greyCityLights(), fontWeight: FontWeight.w600),
                ),
                TextField(
                  style: TextStyle(color: Colors.green),
                  decoration: _textDecoration('Name', 'Enter transaction name', 0),
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                ),
                TextField(
                  style: TextStyle(color: Colors.green),
                  decoration: _textDecoration('Description', '(Optional) Enter description', 1),
                  controller: descController,
                  textCapitalization: TextCapitalization.words,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.green),
                  decoration: _textDecoration('Amount', 'Enter the amount (eg. 0.00)', 2),
                  controller: amountController,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Category:',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
                        ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          _category,
                          style: TextStyle(color: Colors.black),
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
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(color: Colors.black),
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
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Submit Transaction',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    bool checkValue = _checkValidFields();
                    if (checkValue) {
                      monthData
                          .insertUserTransaction(_trimText(nameController.text), double.parse(amountController.text),
                              _trimText(descController.text), _selectedDate, _category)
                          .then((resp) {
                        _afterSubmit();
                      });
                    }
                  },
                ),
                _transactionAdded
                    ? RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          await monthData.refreshTransactions();
                          Navigator.pop(context);
                        },
                      )
                    : RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                _errorMessage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
