class DateUnit {
  static const y = 'year';
  static const M = 'month';
  static const d = 'day';
  static const D = 'date';
  static const w = 'weekday';
  static const h = 'hour';
  static const m = 'minute';
  static const s = 'second';
  static const ms = 'millisecond';
}

const unitMap = {
  'y': DateUnit.y,
  'M': DateUnit.M,
  'd': DateUnit.d,
  'D': DateUnit.D,
  'w': DateUnit.w,
  'h': DateUnit.h,
  'm': DateUnit.m,
  's': DateUnit.s,
  'ms': DateUnit.ms
};

String? processUnit([String? unit]) {
  if (unit == null) return null;
  if (unitMap.containsKey(unit)) {
    return unitMap[unit];
  }

  return unit.trim().toLowerCase().replaceFirst(RegExp(r's$'), "");
}

const dayDartRegexpFormat =
    r'\[.*\]|Y{1,4}|M{1,4}|D{1,2}|W{1,4}|H{1,2}|h{1,2}|m{1,2}|s{1,2}|SSS|A|a';
