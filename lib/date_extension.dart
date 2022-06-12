library date_extension;

import 'package:date_extension/constant.dart';
import 'package:date_extension/utils.dart';

extension DateExtension on DateTime {
  DateTime clone() {
    return DateTime(
        year, month, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime set(int input, String unit) {
    final processedUnit = processUnit(unit);
    switch (processedUnit) {
      case DateUnit.y:
        return DateTime(
            input, month, day, hour, minute, second, millisecond, microsecond);
      case DateUnit.m:
        return DateTime(
            year, input, day, hour, minute, second, millisecond, microsecond);
      case DateUnit.d:
        return DateTime(
            year, month, input, hour, minute, second, millisecond, microsecond);
      case DateUnit.h:
        return DateTime(
            year, month, day, input, minute, second, millisecond, microsecond);
      case DateUnit.min:
        return DateTime(
            year, month, day, hour, input, second, millisecond, microsecond);
      case DateUnit.s:
        return DateTime(
            year, month, day, hour, minute, input, millisecond, microsecond);
      case DateUnit.ms:
        return DateTime(
            year, month, day, hour, minute, second, input, microsecond);
      default:
        return clone();
    }
  }

  DateTime add(int input, String unit) {
    final processedUnit = processUnit(unit);
    switch (processedUnit) {
      case DateUnit.y:
        return set(input + year, unit);
      case DateUnit.m:
        return set(input + month, unit);
      case DateUnit.d:
        return set(input + day, unit);
      case DateUnit.h:
        return set(input + hour, unit);
      case DateUnit.min:
        return set(input + minute, unit);
      case DateUnit.s:
        return set(input + second, unit);
      case DateUnit.ms:
        return set(input + millisecond, unit);
      default:
        return clone();
    }
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
        int wholeMonthDiff = (year - input.year) * 12 + (month - input.month);
        // 2022-01-05.diff(2022-03-10) === -2个月5天
        // 2022-03-10.diff(2022-01-05) === 2个月5天
        // 2022-03-05.diff(2022-01-06) === 1个月5+（28-6）天=== 2022-3-5比2022-2-6多27天+2022-2-6比2022-1-6多一个月

        bool positive = isAfter(input);

        DateTime smallDate = (positive ? input : this).clone();
        DateTime largeDate = (positive ? this : input).clone();

        DateTime anchor =
            DateExtension(smallDate).add(wholeMonthDiff.abs(), DateUnit.m);
        int daysPerMonth =
            DateExtension(anchor).add(1, DateUnit.m).difference(anchor).inDays;
        var a = largeDate.difference(anchor);
        double tail = largeDate.difference(anchor).inMicroseconds /
            (Duration.microsecondsPerDay * daysPerMonth);
        result = wholeMonthDiff + (positive ? 1 : -1) * tail;

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
    return float ? result : Utils().absFloor(result);
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
