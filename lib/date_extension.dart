library date_extension;

import 'package:date_extension/constant.dart';
import 'package:date_extension/utils.dart';

extension DateExtension on DateTime {
  /// 判断[d]与this是否完全相同
  bool isSame(DateTime d) => isAtSameMomentAs(d);

  bool isSameUnit(DateTime d, [String? unit]) {
    return endOf(unit) == d.endOf(unit);
  }

  /// 判断this比[d]时间早
  bool isBeforeUnit(DateTime d, [String? unit]) {
    return endOf(unit) < d;
  }

  /// 判断this比[d]时间晚
  bool isAfterUnit(DateTime d, [String? unit]) {
    return startOf(unit) > d;
  }

  bool operator >(DateTime d) => isAfter(d);
  bool operator <(DateTime d) => isBefore(d);

  bool isSameOrAfter(DateTime d, [String? unit]) {
    return isSameUnit(d, unit) || isAfterUnit(d, unit);
  }

  bool isSameOrBefore(DateTime d, [String? unit]) =>
      isSameUnit(d, unit) || isBeforeUnit(d, unit);

  bool isBetween(DateTime a, DateTime b, [String? u, String? i]) {
    i = i ?? '()';
    final dAi = i[0] == '(';
    final dBi = i[1] == ')';
    return ((dAi ? isAfterUnit(a, u) : !isBeforeUnit(a, u)) &&
            (dBi ? isBeforeUnit(b, u) : !isAfterUnit(b, u))) ||
        ((dAi ? isBeforeUnit(a, u) : !isAfterUnit(b, u)) &&
            (dBi ? isAfterUnit(b, u) : !isBeforeUnit(b, u)));
  }

  /// 克隆一个新的DateTime
  DateTime clone() {
    return DateTime(
        year, month, day, hour, minute, second, millisecond, microsecond);
  }

  /// 设置[unit]为[input]
  DateTime set(int input, String unit) {
    final processedUnit = processUnit(unit);
    switch (processedUnit) {
      case DateUnit.y:
        return DateTime(
            input, month, day, hour, minute, second, millisecond, microsecond);
      case DateUnit.M:
        return DateTime(
            year, input, day, hour, minute, second, millisecond, microsecond);
      case DateUnit.d:
        return DateTime(
            year, month, input, hour, minute, second, millisecond, microsecond);
      case DateUnit.h:
        return DateTime(
            year, month, day, input, minute, second, millisecond, microsecond);
      case DateUnit.m:
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

  /// 增加[input]个[unit]
  DateTime add(int input, String unit) {
    final processedUnit = processUnit(unit);
    switch (processedUnit) {
      case DateUnit.y:
        return set(input + year, unit);
      case DateUnit.M:
        return set(input + month, unit);
      case DateUnit.d:
        return set(input + day, unit);
      case DateUnit.h:
        return set(input + hour, unit);
      case DateUnit.m:
        return set(input + minute, unit);
      case DateUnit.s:
        return set(input + second, unit);
      case DateUnit.ms:
        return set(input + millisecond, unit);
      default:
        return clone();
    }
  }

  /// 由于DateTime已经有了add方法 , 原有接收的是Duration类型，取了别名addTime
  DateTime addTime(int input, String unit) {
    return DateExtension(this).add(input, unit);
  }

  /// 减少[input]个[unit]
  DateTime subtract(int input, String unit) {
    return DateExtension(this).add(-input, unit);
  }

  /// 由于DateTime已经有了subtract方法 , 原有接收的是Duration类型，取了别名subtractTime
  DateTime subtractTime(int input, String unit) {
    return DateExtension(this).subtract(input, unit);
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
        bool positive = isAfter(input);
        DateTime smallDate = (positive ? input : this).clone();
        DateTime largeDate = (positive ? this : input).clone();
        DateTime anchor =
            DateExtension(smallDate).add(yearDiff.abs(), DateUnit.y);
        int daysPerYear =
            DateExtension(anchor).add(1, DateUnit.y).difference(anchor).inDays;
        double tail = largeDate.difference(anchor).inMicroseconds /
            (Duration.microsecondsPerDay * daysPerYear);

        result = yearDiff + (positive ? 1 : -1) * tail;
        break;
      case DateUnit.M:
        // 2022-01-05.diff(2022-03-10) === -2个月5天
        // 2022-03-10.diff(2022-01-05) === 2个月5天
        // 2022-03-05.diff(2022-01-06) === 1个月5+（28-6）天=== 2022-3-5比2022-2-6多27天+2022-2-6比2022-1-6多一个月

        int wholeMonthDiff = (year - input.year) * 12 + (month - input.month);
        bool positive = isAfter(input);

        DateTime smallDate = (positive ? input : this).clone();
        DateTime largeDate = (positive ? this : input).clone();

        DateTime anchor =
            DateExtension(smallDate).add(wholeMonthDiff.abs(), DateUnit.m);
        int daysPerMonth =
            DateExtension(anchor).add(1, DateUnit.m).difference(anchor).inDays;
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
      case DateUnit.m:
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

  DateTime startOf([String? unit, isStartOf = true]) {
    final processedUnit = processUnit(unit);
    var d = this;
    switch (processedUnit) {
      case DateUnit.y:
        return isStartOf
            ? DateTime(d.year, 1, 1)
            : DateTime(d.year + 1, 1, 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.M:
        return isStartOf
            ? DateTime(d.year, d.month, 1)
            : DateTime(d.year, d.month + 1, 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.d:
        return isStartOf
            ? DateTime(d.year, d.month, d.day)
            : DateTime(d.year, d.month, d.day + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.w:
        var weekday = d.weekday;
        return isStartOf
            ? DateTime(d.year, d.month, d.day + (1 - weekday))
            : DateTime(d.year, d.month, d.day + (8 - weekday))
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.h:
        return isStartOf
            ? DateTime(d.year, d.month, d.day, d.hour)
            : DateTime(d.year, d.month, d.day, d.hour + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.m:
        return isStartOf
            ? DateTime(d.year, d.month, d.day, d.hour, d.minute)
            : DateTime(d.year, d.month, d.day, d.hour, d.minute + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.s:
        return isStartOf
            ? DateTime(d.year, d.month, d.day, d.hour, d.minute, d.second)
            : DateTime(d.year, d.month, d.day, d.hour, d.minute, d.second + 1)
                .subtract(const Duration(milliseconds: 1));
      case DateUnit.ms:
        return isStartOf
            ? DateTime(d.year, d.month, d.day, d.hour, d.minute, d.second,
                d.millisecond)
            : DateTime(d.year, d.month, d.day, d.hour, d.minute, d.second,
                    d.millisecond + 1)
                .subtract(const Duration(milliseconds: 1));
      default:
    }

    return d.clone();
  }

  DateTime endOf([String? unit]) {
    return startOf(unit, false);
  }

  /// 获取当前月份包含的天数。
  /// DateTime.parse('2019-01-25').daysInMonth() // 31
  int daysInMonth() {
    return endOf(DateUnit.M).day;
  }

  /// 设置年份
  DateTime setYear(int input) {
    return set(input, DateUnit.y);
  }

  /// 设置月份
  DateTime setMonth(int input) {
    return set(input, DateUnit.M);
  }

  /// 设置日期  [input]接受1到31的数字。 如果超出这个范围，它会进位到月份。
  DateTime setDate(int input) {
    return set(input, DateUnit.d);
  }

  /// 设置小时
  DateTime setHour(int input) {
    return set(input, DateUnit.h);
  }

  /// 设置分钟
  DateTime setMinute(int input) {
    return set(input, DateUnit.m);
  }

  /// 设置秒
  DateTime setSecond(int input) {
    return set(input, DateUnit.s);
  }

  /// 设置毫秒
  DateTime setMillisecond(int input) {
    return set(input, DateUnit.ms);
  }
}
