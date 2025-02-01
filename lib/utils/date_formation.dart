import 'package:intl/intl.dart';

class DateFormation {
  listTileDate(inputDate) {
    DateTime date = DateTime.parse(inputDate);
    // Format the date to "19, Feb"
    String formatedDate =
        DateFormat("d, MMM").format(date.subtract(Duration(days: 1)));

    return formatedDate;
  }
}
