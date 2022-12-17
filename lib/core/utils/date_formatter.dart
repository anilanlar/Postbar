import "package:intl/date_symbol_data_local.dart";
import "package:intl/intl.dart";
import "package:jiffy/jiffy.dart";

class DateFormatter {
  DateFormatter() {
    initializeDateFormatting();
    Intl.defaultLocale = "tr_TR";
  }

  final int dayLimit = 15;

  String getToday() {
    final String date = Jiffy(Jiffy().dateTime).format("dd-MM-yyyy");
    return date;
  }

  String formatDate(DateTime? dateTime) {
    String date = "";
    if (dateTime == null) {
      date = getToday();
    } else {
      date = Jiffy(dateTime).format("dd-MM-yyyy");
    }
    return date;
  }

  String formatDateForAPI(DateTime? dateTime) {
    String date = "";
    if (dateTime == null) {
      date = getToday();
    } else {
      date = Jiffy(dateTime).format("dd-MM-yyyy");
    }
    return date;
  }

  String endOfMonth() {
    final Jiffy jiffy = Jiffy().endOf(Units.MONTH);
    return Jiffy(jiffy).format("dd-MM-yyyy");
  }

  String startOfMonth() {
    final Jiffy jiffy = Jiffy().startOf(Units.MONTH);
    return Jiffy(jiffy).format("dd-MM-yyyy");
  }

  DateTime formatToDateTime(String date) {
    return Jiffy(date).dateTime;
  }

  String endDate() {
    final DateTime fifteenDaysAgo = DateTime.now().subtract(Duration(days: dayLimit));
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    return formatter.format(fifteenDaysAgo);
  }
}
