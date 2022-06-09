library date_extension;

import 'package:date_extension/constant.dart';
import 'package:date_extension/utils.dart';

extension DateExtension on DateTime {
  String format([String? format]) {
    if (format == null) {
      return toIso8601String();
    }
    return format.replaceAllMapped(RegExp(dayDartRegexpFormat),
        (Match m) => Utils().processMatchFromFormat(m, this));
  }

  DateTime startOf(String unit, [isStartOf = true]) {
    final processedUnit = processUnit(unit);
    var now = this;
    switch (processedUnit) {
      case DateUnit.y:
        return isStartOf
            ? DateTime(now.year, 1, 1)
            : DateTime(now.year + 1, 1, 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.m:
        return isStartOf
            ? DateTime(now.year, now.month, 1)
            : DateTime(now.year, now.month + 1, 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.d:
        return isStartOf
            ? DateTime(now.year, now.month, now.day)
            : DateTime(now.year, now.month, now.day + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.w:
        var weekday = now.weekday;
        return isStartOf
            ? DateTime(now.year, now.month, now.day + (1 - weekday))
            : DateTime(now.year, now.month, now.day + (8 - weekday))
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.h:
        return isStartOf
            ? DateTime(now.year, now.month, now.day, now.hour)
            : DateTime(now.year, now.month, now.day, now.hour + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.min:
        return isStartOf
            ? DateTime(now.year, now.month, now.day, now.hour, now.minute)
            : DateTime(now.year, now.month, now.day, now.hour, now.minute + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.s:
        return isStartOf
            ? DateTime(
                now.year, now.month, now.day, now.hour, now.minute, now.second)
            : DateTime(now.year, now.month, now.day, now.hour, now.minute,
                    now.second + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.ms:
        return isStartOf
            ? DateTime(now.year, now.month, now.day, now.hour, now.minute,
                now.second, now.millisecond)
            : DateTime(now.year, now.month, now.day, now.hour, now.minute,
                    now.second, now.millisecond + 1)
                .subtract(const Duration(milliseconds: 1));
      default:
    }

    return now;
  }

  DateTime endOf(String unit) {
    return startOf(unit, false);
  }
}
