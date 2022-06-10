library date_extension;

import 'package:date_extension/constant.dart';
import 'package:date_extension/utils.dart';

extension DateExtension on DateTime {
  DateTime clone() {
    return DateTime(
        year, month, day, hour, minute, second, millisecond, microsecond);
  }

  /// 返回指定单位下两个日期时间之间的差异。
  num diff(String date, [String unit = DateUnit.ms, bool float = false]) {
    var input = DateTime.parse(date);
    return diff2(input, unit, float);
  }

  num diff2(DateTime input, [String unit = DateUnit.ms, bool float = false]) {
    Duration duration = difference(input);
    final processedUnit = processUnit(unit);
    double result;

    switch (processedUnit) {
      case DateUnit.y:
        int yearDiff = (year - input.year);
        // TODO 计算出当前差别年共多少天
        int daysPerYear = 365;
        Duration yearDuration = difference(
            input.clone().add(Duration(days: yearDiff * daysPerYear)));
        result = yearDiff +
            yearDuration.inMicroseconds /
                daysPerYear *
                Duration.microsecondsPerDay;
        break;
      case DateUnit.m:
        int monthDiff = (year - input.year) * 12 + (month - input.month);
        // TODO 计算出当前差别月共多少天
        int daysPerMonth = 31;
        Duration monthDuration = difference(
            input.clone().add(Duration(days: monthDiff * daysPerMonth)));
        result = monthDiff +
            monthDuration.inMicroseconds /
                daysPerMonth *
                Duration.microsecondsPerDay;
        break;
      case DateUnit.d:
        result = duration.inMicroseconds / Duration.microsecondsPerDay;
        break;
      case DateUnit.h:
        result = duration.inMicroseconds / Duration.microsecondsPerHour;
        break;
      case DateUnit.min:
        result = duration.inMicroseconds / Duration.microsecondsPerMinute;
        break;
      case DateUnit.s:
        result = duration.inMicroseconds / Duration.microsecondsPerSecond;
        break;
      case DateUnit.ms:
        result = duration.inMicroseconds / Duration.microsecondsPerMillisecond;
        break;
      default:
        result = duration.inMicroseconds / Duration.microsecondsPerMillisecond;
    }
    return float ? result : result.round();
  }

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
