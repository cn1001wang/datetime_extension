import 'date_extension.dart';

class Utils {
  String processMatchFromFormat(Match m, DateTime day) {
    final mm = m[0]; // First match

    if (mm != null && mm.startsWith('[') && mm.endsWith(']')) {
      return mm.substring(1, mm.length - 1);
    }

    final locale = day.getLocale();

    switch (mm) {
      case 'Y':
      case 'YY':
        final year = day.year.toString();
        return year.substring(year.length - 2, year.length);
      case 'YYY':
      case 'YYYY':
        return day.year.toString();
      case 'M':
        return day.month.toString();
      case 'MM':
        return day.month.toString().padLeft(2, '0');
      case 'MMM':
        return locale['Name'] == 'en'
            ? locale['Months'][day.month].substring(0, 3)
            : locale['MonthsShort'][day.month];
      case 'MMMM':
        return locale['Months'][day.month];
      case 'D':
        return day.day.toString();
      case 'DD':
        return day.day.toString().padLeft(2, '0');
      case 'W':
        return day.weekday.toString();
      case 'WW':
        return locale['Name'] == 'en'
            ? locale['Weekdays'][day.weekday].substring(0, 2)
            : locale['WeekdaysMin'][day.weekday];
      case 'WWW':
        return locale['Name'] == 'en'
            ? locale['Weekdays'][day.weekday].substring(0, 3)
            : locale['WeekdaysShort'][day.weekday];
      case 'WWWW':
        return locale['Weekdays'][day.weekday];
      case 'H':
        return day.hour.toString();
      case 'HH':
        return day.hour.toString().padLeft(2, '0');
      case 'h':
        return _getHourAs12(day.hour).toString();
      case 'hh':
        return _getHourAs12(day.hour).toString().padLeft(2, '0');
      case 'm':
        return day.minute.toString();
      case 'mm':
        return day.minute.toString().padLeft(2, '0');
      case 's':
        return day.second.toString();
      case 'ss':
        return day.second.toString().padLeft(2, '0');
      case 'SSS':
        return day.millisecond.toString().padLeft(3, '0');
      case 'A':
        return _toAMOrPM(day.hour, locale);
      case 'a':
        return _toAMOrPM(day.hour, locale, true);
      default:
        return day.toIso8601String();
    }
  }

  int _getHourAs12(int hour) {
    return hour <= 12 ? hour : hour - 12;
  }

  String _toAMOrPM(int hour, dynamic locale, [bool toLowercase = false]) {
    final result = hour < 12 ? 'AM' : 'PM';

    return toLowercase ? result.toLowerCase() : result;
  }

  int absFloor(n) => (n < 0 ? n.ceil() : n.floor());
}
