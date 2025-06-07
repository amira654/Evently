import 'package:intl/intl.dart';

extension DateFormate on DateTime {
  String get getMonthFromDateTime {
    DateFormat formatter = DateFormat("MMMM");
    return formatter.format(this);
  }

  String get toFormattedDate {
    DateFormat formatter = DateFormat("dd-MM-yyyy");
    return formatter.format(this);
  }
  String get getTime{
    DateFormat formatter = DateFormat("hh:mm a");
    return formatter.format(this);
  }
}
