final List<String> _weekdaysShort = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
final List<String> _weekdaysMid = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
final List<String> _weekdaysLong = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

///Gets the list of weekdays represented with two letters. Eg. Su, Mo, Tu, We, etc.
List<String> get weekdaysShort {
  return _weekdaysShort;
}

///Gets the list of weekdays represented with three letters. Eg. Sun, Mon, Tue, Wed, etc.
List<String> get weekdaysMid {
  return _weekdaysMid;
}

///Gets the list of weekdays represented with full name. Eg. Sunday, Monday, Tuesday, Wednesday, etc.
List<String> get weekdaysLong {
  return _weekdaysLong;
}
