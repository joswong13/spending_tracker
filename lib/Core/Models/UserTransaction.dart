class UserTransaction {
  int _id;
  String _name;
  double _amount;
  int _date;
  String _category;
  String _desc;

  UserTransaction();

  UserTransaction.fromDb(Map<String, dynamic> data) {
    this._id = data["id"];
    this._name = data["name"];
    this._amount = data["amount"];
    this._date = data["date"];
    this._category = data["category"];
    this._desc = data["desc"];
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "amount": amount, "date": date, "category": category, "desc": desc};
  }

  set id(id) {
    _id = id;
  }

  set name(name) {
    _name = name;
  }

  set amount(amount) {
    _amount = amount;
  }

  set date(date) {
    _date = date;
  }

  set category(category) {
    _category = category;
  }

  set desc(desc) {
    _desc = desc;
  }

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  double get amount {
    return _amount;
  }

  int get date {
    return _date;
  }

  String get category {
    return _category;
  }

  String get desc {
    return _desc;
  }

  @override
  String toString() {
    return "{'id': $_id, 'name':$_name, 'amount':$_amount, '_date':$_date, 'category': $_category, 'desc':$_desc}";
  }
}
