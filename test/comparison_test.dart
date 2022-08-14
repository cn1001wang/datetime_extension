import 'package:datetime_extension/constant.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:datetime_extension/datetime_extension.dart';

void main() {
  test("isBeforeUnit,isAfterUnit", () {
    final date1 = DateTime.parse("2022-01-01 10:00:00");
    final date2 = DateTime.parse("2022-02-01 10:00:00");
    expect(date1.isBeforeUnit(date2), true);
    expect(date1.isAfterUnit(date2), false);
  });
  test("isBeforeUnit,isAfterUnit with Unit", () {
    final date1 = DateTime.parse("2022-02-01 10:00:00");
    final date2 = DateTime.parse("2022-02-03 10:00:00");
    expect(date1.isBeforeUnit(date2, DateUnit.M), false);
    expect(date1.isAfterUnit(date2), false);
  });

  test('is same without units', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);

    expect(m.isSame(DateTime(2012, 3, 2, 3, 5, 5, 10)), false,
        reason: 'year is later');
    expect(m.isSame(DateTime(2010, 3, 2, 3, 3, 5, 10)), false,
        reason: 'year is earlier');
    expect(m.isSame(DateTime(2011, 4, 2, 3, 4, 5, 10)), false,
        reason: 'month is later');
    expect(m.isSame(DateTime(2011, 2, 2, 3, 4, 5, 10)), false,
        reason: 'month is earlier');
    expect(m.isSame(DateTime(2011, 3, 3, 3, 4, 5, 10)), false,
        reason: 'day is later');
    expect(m.isSame(DateTime(2011, 3, 1, 3, 4, 5, 10)), false,
        reason: 'day is earlier');
    expect(m.isSame(DateTime(2011, 3, 2, 4, 4, 5, 10)), false,
        reason: 'hour is later');
    expect(m.isSame(DateTime(2011, 3, 2, 2, 4, 5, 10)), false,
        reason: 'hour is earlier');
    expect(m.isSame(DateTime(2011, 3, 2, 3, 5, 5, 10)), false,
        reason: 'minute is later');
    expect(m.isSame(DateTime(2011, 3, 2, 3, 3, 5, 10)), false,
        reason: 'minute is earlier');
    expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 6, 10)), false,
        reason: 'second is later');
    expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 4, 11)), false,
        reason: 'second is earlier');
    expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 5, 10)), true,
        reason: 'millisecond match');
    expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 5, 11)), false,
        reason: 'millisecond is later');
    expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 5, 9)), false,
        reason: 'millisecond is earlier');
    // expect(m.isSame(m,true, reason:'moments are the same as themselves');
  });

  test('is same year', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isSameUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'year'), true,
        reason: 'year match');
    expect(m.isSameUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'years'), true,
        reason: 'plural should work');
    expect(m.isSameUnit(DateTime(2012, 5, 6, 7, 8, 9, 10), 'year'), false,
        reason: 'year mismatch');
  });

  test('is same month', () {
    final m = DateTime(2011, 2, 3, 4, 5, 6, 7);
    expect(m.isSameUnit(DateTime(2011, 2, 6, 7, 8, 9, 10), 'month'), true,
        reason: 'month match');
    expect(m.isSameUnit(DateTime(2012, 2, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'year mismatch');
    expect(m.isSameUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'month mismatch');
    expect(m.isSameUnit(DateTime(2011, 2, 1, 0, 0, 0, 0), 'month'), true,
        reason: 'exact start of month');
    expect(m.isSameUnit(DateTime(2011, 2, 28, 23, 59, 59, 999), 'month'), true,
        reason: 'exact end of month');
    expect(m.isSameUnit(DateTime(2011, 3, 1, 0, 0, 0, 0), 'month'), false,
        reason: 'start of next month');
    expect(m.isSameUnit(DateTime(2011, 1, 31, 23, 59, 59, 999), 'month'), false,
        reason: 'end of previous month');
  });

  test('is same day', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isSameUnit(DateTime(2011, 1, 2, 7, 8, 9, 10), 'day'), true,
        reason: 'day match');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 7, 8, 9, 10), 'days'), true,
        reason: 'plural should work');
    expect(m.isSameUnit(DateTime(2012, 1, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'year mismatch');
    expect(m.isSameUnit(DateTime(2011, 2, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'month mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 3, 7, 8, 9, 10), 'day'), false,
        reason: 'day mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 0, 0, 0, 0), 'day'), true,
        reason: 'exact start of day');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 23, 59, 59, 999), 'day'), true,
        reason: 'exact end of day');
    expect(m.isSameUnit(DateTime(2011, 1, 3, 0, 0, 0, 0), 'day'), false,
        reason: 'start of next day');
    expect(m.isSameUnit(DateTime(2011, 1, 1, 23, 59, 59, 999), 'day'), false,
        reason: 'end of previous day');
  });

  test('is same hour', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 8, 9, 10), 'hour'), true,
        reason: 'hour match');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 8, 9, 10), 'hours'), true,
        reason: 'plural should work');
    expect(m.isSameUnit(DateTime(2012, 1, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'year mismatch');
    expect(m.isSameUnit(DateTime(2011, 2, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'month mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 3, 3, 8, 9, 10), 'hour'), false,
        reason: 'day mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 4, 8, 9, 10), 'hour'), false,
        reason: 'hour mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 0, 0, 0), 'hour'), true,
        reason: 'exact start of hour');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 59, 59, 999), 'hour'), true,
        reason: 'exact end of hour');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 4, 0, 0, 0), 'hour'), false,
        reason: 'start of next hour');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 2, 59, 59, 999), 'hour'), false,
        reason: 'end of previous hour');
    expect(m.isSameUnit(m, 'hour'), true,
        reason: 'same moments are in the same hour');
  });

  test('is same minute', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 9, 10), 'minute'), true,
        reason: 'minute match');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 9, 10), 'minutes'), true,
        reason: 'plural should work');
    expect(m.isSameUnit(DateTime(2012, 1, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'year mismatch');
    expect(m.isSameUnit(DateTime(2011, 2, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'month mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 3, 3, 4, 9, 10), 'minute'), false,
        reason: 'day mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 4, 4, 9, 10), 'minute'), false,
        reason: 'hour mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 5, 9, 10), 'minute'), false,
        reason: 'minute mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 0, 0), 'minute'), true,
        reason: 'exact start of minute');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 59, 999), 'minute'), true,
        reason: 'exact end of minute');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 5, 0, 0), 'minute'), false,
        reason: 'start of next minute');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 3, 59, 999), 'minute'), false,
        reason: 'end of previous minute');
    expect(m.isSameUnit(m, 'minute'), true,
        reason: 'same moments are in the same minute');
  });

  test('is same second', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 5, 10), 'second'), true,
        reason: 'second match');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 5, 10), 'seconds'), true,
        reason: 'plural should work');
    expect(m.isSameUnit(DateTime(2012, 1, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'year mismatch');
    expect(m.isSameUnit(DateTime(2011, 2, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'month mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 3, 3, 4, 5, 10), 'second'), false,
        reason: 'day mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 4, 4, 5, 10), 'second'), false,
        reason: 'hour mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 5, 5, 10), 'second'), false,
        reason: 'minute mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 6, 10), 'second'), false,
        reason: 'second mismatch');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 5, 0), 'second'), true,
        reason: 'exact start of second');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 5, 999), 'second'), true,
        reason: 'exact end of second');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 6, 0), 'second'), false,
        reason: 'start of next second');
    expect(m.isSameUnit(DateTime(2011, 1, 2, 3, 4, 4, 999), 'second'), false,
        reason: 'end of previous second');
    expect(m.isSameUnit(m, 'second'), true,
        reason: 'same moments are in the same second');
  });

  test('is same millisecond', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
    expect(m.isSameUnit(DateTime(2011, 3, 2, 3, 4, 5, 10), 'millisecond'), true,
        reason: 'millisecond match');
    expect(
        m.isSameUnit(DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds'), true,
        reason: 'plural should work');
    expect(
        m.isSameUnit(DateTime(2012, 3, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'year is later');
    expect(
        m.isSameUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'year is earlier');
    expect(
        m.isSameUnit(DateTime(2011, 4, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'month is later');
    expect(
        m.isSameUnit(DateTime(2011, 2, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'month is earlier');
    expect(
        m.isSameUnit(DateTime(2011, 3, 3, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'day is later');
    expect(
        m.isSameUnit(DateTime(2011, 3, 1, 1, 4, 5, 10), 'millisecond'), false,
        reason: 'day is earlier');
    expect(
        m.isSameUnit(DateTime(2011, 3, 2, 4, 4, 5, 10), 'millisecond'), false,
        reason: 'hour is later');
    expect(
        m.isSameUnit(DateTime(2011, 3, 1, 4, 1, 5, 10), 'millisecond'), false,
        reason: 'hour is earlier');
    expect(
        m.isSameUnit(DateTime(2011, 3, 2, 3, 5, 5, 10), 'millisecond'), false,
        reason: 'minute is later');
    expect(
        m.isSameUnit(DateTime(2011, 3, 2, 3, 3, 5, 10), 'millisecond'), false,
        reason: 'minute is earlier');
    expect(
        m.isSameUnit(DateTime(2011, 3, 2, 3, 4, 6, 10), 'millisecond'), false,
        reason: 'second is later');
    expect(m.isSameUnit(DateTime(2011, 3, 2, 3, 4, 4, 5), 'millisecond'), false,
        reason: 'second is earlier');
    expect(
        m.isSameUnit(DateTime(2011, 3, 2, 3, 4, 6, 11), 'millisecond'), false,
        reason: 'millisecond is later');
    expect(m.isSameUnit(DateTime(2011, 3, 2, 3, 4, 4, 9), 'millisecond'), false,
        reason: 'millisecond is earlier');
    expect(m.isSameUnit(m, 'millisecond'), true,
        reason: 'same moments are in the same millisecond');
  });

// isAfter()

  test('is after year', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isAfterUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'year'), false,
        reason: 'year match');
    expect(m.isAfterUnit(DateTime(2010, 5, 6, 7, 8, 9, 10), 'years'), true,
        reason: 'plural should work');
    expect(m.isAfterUnit(DateTime(2013, 5, 6, 7, 8, 9, 10), 'year'), false,
        reason: 'year is later');
    expect(m.isAfterUnit(DateTime(2010, 5, 6, 7, 8, 9, 10), 'year'), true,
        reason: 'year is earlier');
    expect(m.isAfterUnit(DateTime(2011, 1, 1, 0, 0, 0, 0), 'year'), false,
        reason: 'exact start of year');
    expect(
        m.isAfterUnit(DateTime(2011, 12, 31, 23, 59, 59, 999), 'year'), false,
        reason: 'exact end of year');
    expect(m.isAfterUnit(DateTime(2012, 1, 1, 0, 0, 0, 0), 'year'), false,
        reason: 'start of next year');
    expect(m.isAfterUnit(DateTime(2010, 12, 31, 23, 59, 59, 999), 'year'), true,
        reason: 'end of previous year');
    expect(m.isAfterUnit(DateTime(1980, 12, 31, 23, 59, 59, 999), 'year'), true,
        reason: 'end of year far before');
    expect(m.isAfterUnit(m, 'year'), false,
        reason: 'same moments are not after the same year');
  });

  test('is after month', () {
    final m = DateTime(2011, 3, 3, 4, 5, 6, 7);
    expect(m.isAfterUnit(DateTime(2011, 3, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'month match');
    expect(m.isAfterUnit(DateTime(2010, 3, 6, 7, 8, 9, 10), 'months'), true,
        reason: 'plural should work');
    expect(m.isAfterUnit(DateTime(2012, 3, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'year is later');
    expect(m.isAfterUnit(DateTime(2010, 3, 6, 7, 8, 9, 10), 'month'), true,
        reason: 'year is earlier');
    expect(m.isAfterUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'month is later');
    expect(m.isAfterUnit(DateTime(2011, 2, 6, 7, 8, 9, 10), 'month'), true,
        reason: 'month is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 0, 0, 0, 0), 'month'), false,
        reason: 'exact start of month');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 31, 23, 59, 59, 999), 'month'), false,
        reason: 'exact end of month');
    expect(m.isAfterUnit(DateTime(2011, 4, 1, 0, 0, 0, 0), 'month'), false,
        reason: 'start of next month');
    expect(m.isAfterUnit(DateTime(2011, 2, 27, 23, 59, 59, 999), 'month'), true,
        reason: 'end of previous month');
    expect(
        m.isAfterUnit(DateTime(2010, 13, 31, 23, 59, 59, 999), 'month'), true,
        reason: 'later month but earlier year');
    expect(m.isAfterUnit(m, 'month'), false,
        reason: 'same moments are not after the same month');
  });

  test('is after day', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 6);
    final mCopy = m.clone();
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'day match');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 7, 8, 9, 10), 'days'), true,
        reason: 'plural should work');
    expect(m.isAfterUnit(DateTime(2012, 3, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'year is later');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 7, 8, 9, 10), 'day'), true,
        reason: 'year is earlier');
    expect(m.isAfterUnit(DateTime(2011, 4, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'month is later');
    expect(m.isAfterUnit(DateTime(2011, 2, 2, 7, 8, 9, 10), 'day'), true,
        reason: 'month is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 3, 7, 8, 9, 10), 'day'), false,
        reason: 'day is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 7, 8, 9, 10), 'day'), true,
        reason: 'day is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 0, 0, 0, 0), 'day'), false,
        reason: 'exact start of day');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 23, 59, 59, 999), 'day'), false,
        reason: 'exact end of day');
    expect(m.isAfterUnit(DateTime(2011, 3, 3, 0, 0, 0, 0), 'day'), false,
        reason: 'start of next day');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 23, 59, 59, 999), 'day'), true,
        reason: 'end of previous day');
    expect(m.isAfterUnit(DateTime(2010, 3, 10, 0, 0, 0, 0), 'day'), true,
        reason: 'later day but earlier year');
    expect(m.isAfterUnit(m, 'day'), false,
        reason: 'same moments are not after the same day');

    expect(m.isSame(mCopy), true,
        reason: 'isAfterUnit day should not change moment');
  });

  test('is after hour', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 6);
    final mCopy = m.clone();
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'hour match');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 3, 8, 9, 10), 'hours'), true,
        reason: 'plural should work');
    expect(m.isAfterUnit(DateTime(2012, 3, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'year is later');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 3, 8, 9, 10), 'hour'), true,
        reason: 'year is earlier');
    expect(m.isAfterUnit(DateTime(2011, 4, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'month is later');
    expect(m.isAfterUnit(DateTime(2011, 1, 2, 3, 8, 9, 10), 'hour'), true,
        reason: 'month is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 3, 3, 8, 9, 10), 'hour'), false,
        reason: 'day is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 3, 8, 9, 10), 'hour'), true,
        reason: 'day is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 4, 8, 9, 10), 'hour'), false,
        reason: 'hour is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'hour is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 0, 0, 0), 'hour'), false,
        reason: 'exact start of hour');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 59, 59, 999), 'hour'), false,
        reason: 'exact end of hour');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 4, 0, 0, 0), 'hour'), false,
        reason: 'start of next hour');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 2, 59, 59, 999), 'hour'), true,
        reason: 'end of previous hour');
    expect(m.isAfterUnit(m, 'hour'), false,
        reason: 'same moments are not after the same hour');

    expect(m.isSame(mCopy), true,
        reason: 'isAfterUnit hour should not change moment');
  });

  test('is after minute', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 6);
    final mCopy = m.clone();
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'minute match');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 3, 4, 9, 10), 'minutes'), true,
        reason: 'plural should work');
    expect(m.isAfterUnit(DateTime(2012, 3, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'year is later');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 3, 4, 9, 10), 'minute'), true,
        reason: 'year is earlier');
    expect(m.isAfterUnit(DateTime(2011, 4, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'month is later');
    expect(m.isAfterUnit(DateTime(2011, 2, 2, 3, 4, 9, 10), 'minute'), true,
        reason: 'month is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 3, 3, 4, 9, 10), 'minute'), false,
        reason: 'day is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 3, 4, 9, 10), 'minute'), true,
        reason: 'day is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 4, 4, 9, 10), 'minute'), false,
        reason: 'hour is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 2, 4, 9, 10), 'minute'), true,
        reason: 'hour is earler');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 5, 9, 10), 'minute'), false,
        reason: 'minute is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 3, 9, 10), 'minute'), true,
        reason: 'minute is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 0, 0), 'minute'), false,
        reason: 'exact start of minute');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 59, 999), 'minute'), false,
        reason: 'exact end of minute');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 5, 0, 0), 'minute'), false,
        reason: 'start of next minute');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 3, 59, 999), 'minute'), true,
        reason: 'end of previous minute');
    expect(m.isAfterUnit(m, 'minute'), false,
        reason: 'same moments are not after the same minute');
    expect(m.isSame(mCopy), true,
        reason: 'isAfterUnit minute should not change moment');
  });

  test('is after second', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
    final mCopy = m.clone();
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'second match');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'seconds'), true,
        reason: 'plural should work');
    expect(m.isAfterUnit(DateTime(2012, 3, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'year is later');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'second'), true,
        reason: 'year is earlier');
    expect(m.isAfterUnit(DateTime(2011, 4, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'month is later');
    expect(m.isAfterUnit(DateTime(2011, 2, 2, 3, 4, 5, 10), 'second'), true,
        reason: 'month is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 3, 3, 4, 5, 10), 'second'), false,
        reason: 'day is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 1, 4, 5, 10), 'second'), true,
        reason: 'day is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 4, 4, 5, 10), 'second'), false,
        reason: 'hour is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 4, 1, 5, 10), 'second'), true,
        reason: 'hour is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 5, 5, 10), 'second'), false,
        reason: 'minute is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 3, 5, 10), 'second'), true,
        reason: 'minute is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 6, 10), 'second'), false,
        reason: 'second is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 4, 5), 'second'), true,
        reason: 'second is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 5, 0), 'second'), false,
        reason: 'exact start of second');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 5, 999), 'second'), false,
        reason: 'exact end of second');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 6, 0), 'second'), false,
        reason: 'start of next second');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 4, 999), 'second'), true,
        reason: 'end of previous second');
    expect(m.isAfterUnit(m, 'second'), false,
        reason: 'same moments are not after the same second');
    expect(m.isSame(mCopy), true,
        reason: 'isAfterUnit second should not change moment');
  });

  test('is after millisecond', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
    final mCopy = m.clone();
    expect(
        m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'millisecond match');
    expect(
        m.isAfterUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'milliseconds'), true,
        reason: 'plural should work');
    expect(
        m.isAfterUnit(DateTime(2012, 3, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'year is later');
    expect(
        m.isAfterUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'millisecond'), true,
        reason: 'year is earlier');
    expect(
        m.isAfterUnit(DateTime(2011, 4, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'month is later');
    expect(
        m.isAfterUnit(DateTime(2011, 2, 2, 3, 4, 5, 10), 'millisecond'), true,
        reason: 'month is earlier');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 3, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'day is later');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 1, 1, 4, 5, 10), 'millisecond'), true,
        reason: 'day is earlier');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 2, 4, 4, 5, 10), 'millisecond'), false,
        reason: 'hour is later');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 1, 4, 1, 5, 10), 'millisecond'), true,
        reason: 'hour is earlier');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 2, 3, 5, 5, 10), 'millisecond'), false,
        reason: 'minute is later');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 2, 3, 3, 5, 10), 'millisecond'), true,
        reason: 'minute is earlier');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 6, 10), 'millisecond'), false,
        reason: 'second is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 4, 5), 'millisecond'), true,
        reason: 'second is earlier');
    expect(
        m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 6, 11), 'millisecond'), false,
        reason: 'millisecond is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 4, 9), 'millisecond'), true,
        reason: 'millisecond is earlier');
    expect(m.isAfterUnit(m, 'millisecond'), false,
        reason: 'same moments are not after the same millisecond');
    expect(m.isSame(mCopy), true,
        reason: 'isAfterUnit millisecond should not change moment');
  });

  test('is after without units', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
    final mCopy = m.clone();
    expect(m.isAfterUnit(DateTime(2012, 3, 2, 3, 5, 5, 10)), false,
        reason: 'year is later');
    expect(m.isAfterUnit(DateTime(2010, 3, 2, 3, 3, 5, 10)), true,
        reason: 'year is earlier');
    expect(m.isAfterUnit(DateTime(2011, 4, 2, 3, 4, 5, 10)), false,
        reason: 'month is later');
    expect(m.isAfterUnit(DateTime(2011, 2, 2, 3, 4, 5, 10)), true,
        reason: 'month is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 3, 3, 4, 5, 10)), false,
        reason: 'day is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 1, 3, 4, 5, 10)), true,
        reason: 'day is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 4, 4, 5, 10)), false,
        reason: 'hour is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 2, 4, 5, 10)), true,
        reason: 'hour is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 5, 5, 10)), false,
        reason: 'minute is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 3, 5, 10)), true,
        reason: 'minute is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 6, 10)), false,
        reason: 'second is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 4, 11)), true,
        reason: 'second is earlier');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 5, 10)), false,
        reason: 'millisecond match');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 5, 11)), false,
        reason: 'millisecond is later');
    expect(m.isAfterUnit(DateTime(2011, 3, 2, 3, 4, 5, 9)), true,
        reason: 'millisecond is earlier');
    expect(m.isAfterUnit(m), false, reason: 'moments are not after themselves');
    expect(m.isSame(mCopy), true,
        reason: 'isAfterUnit millisecond should not change moment');
  });

// isBeforeUnit()

  test('is after without units', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
    final mCopy = m.clone();
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 3, 5, 5, 10)), true,
        reason: 'year is later');
    expect(m.isBeforeUnit(DateTime(2010, 3, 2, 3, 3, 5, 10)), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 4, 2, 3, 4, 5, 10)), true,
        reason: 'month is later');
    expect(m.isBeforeUnit(DateTime(2011, 2, 2, 3, 4, 5, 10)), false,
        reason: 'month is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 3, 3, 4, 5, 10)), true,
        reason: 'day is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 3, 4, 5, 10)), false,
        reason: 'day is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 4, 4, 5, 10)), true,
        reason: 'hour is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 2, 4, 5, 10)), false,
        reason: 'hour is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 5, 5, 10)), true,
        reason: 'minute is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 3, 5, 10)), false,
        reason: 'minute is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 6, 10)), true,
        reason: 'second is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 4, 11)), false,
        reason: 'second is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 5, 10)), false,
        reason: 'millisecond match');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 5, 11)), true,
        reason: 'millisecond is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 5, 9)), false,
        reason: 'millisecond is earlier');
    expect(m.isBeforeUnit(m), false,
        reason: 'moments are not before themselves');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit without unit should not change moment');
  });

  test('is before year', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    final mCopy = m.clone();
    expect(m.isBeforeUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'year'), false,
        reason: 'year match');
    expect(m.isBeforeUnit(DateTime(2012, 5, 6, 7, 8, 9, 10), 'years'), true,
        reason: 'plural should work');
    expect(m.isBeforeUnit(DateTime(2013, 5, 6, 7, 8, 9, 10), 'year'), true,
        reason: 'year is later');
    expect(m.isBeforeUnit(DateTime(2010, 5, 6, 7, 8, 9, 10), 'year'), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 1, 1, 0, 0, 0, 0), 'year'), false,
        reason: 'exact start of year');
    expect(
        m.isBeforeUnit(DateTime(2011, 12, 31, 23, 59, 59, 999), 'year'), false,
        reason: 'exact end of year');
    expect(m.isBeforeUnit(DateTime(2012, 1, 1, 0, 0, 0, 0), 'year'), true,
        reason: 'start of next year');
    expect(
        m.isBeforeUnit(DateTime(2010, 12, 31, 23, 59, 59, 999), 'year'), false,
        reason: 'end of previous year');
    expect(
        m.isBeforeUnit(DateTime(1980, 12, 31, 23, 59, 59, 999), 'year'), false,
        reason: 'end of year far before');
    expect(m.isBeforeUnit(m, 'year'), false,
        reason: 'same moments are not before the same year');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit year should not change moment');
  });

  test('is before month', () {
    final m = DateTime(2011, 3, 3, 4, 5, 6, 7);
    final mCopy = m.clone();
    expect(m.isBeforeUnit(DateTime(2011, 3, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'month match');
    expect(m.isBeforeUnit(DateTime(2012, 3, 6, 7, 8, 9, 10), 'months'), true,
        reason: 'plural should work');
    expect(m.isBeforeUnit(DateTime(2012, 3, 6, 7, 8, 9, 10), 'month'), true,
        reason: 'year is later');
    expect(m.isBeforeUnit(DateTime(2010, 3, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 6, 6, 7, 8, 9, 10), 'month'), true,
        reason: 'month is later');
    expect(m.isBeforeUnit(DateTime(2011, 2, 6, 7, 8, 9, 10), 'month'), false,
        reason: 'month is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 0, 0, 0, 0), 'month'), false,
        reason: 'exact start of month');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 31, 23, 59, 59, 999), 'month'), false,
        reason: 'exact end of month');
    expect(m.isBeforeUnit(DateTime(2011, 4, 1, 0, 0, 0, 0), 'month'), true,
        reason: 'start of next month');
    expect(
        m.isBeforeUnit(DateTime(2011, 2, 27, 23, 59, 59, 999), 'month'), false,
        reason: 'end of previous month');
    expect(
        m.isBeforeUnit(DateTime(2010, 13, 31, 23, 59, 59, 999), 'month'), false,
        reason: 'later month but earlier year');
    expect(m.isBeforeUnit(m, 'month'), false,
        reason: 'same moments are not before the same month');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit month should not change moment');
  });

  test('is before day', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 6);
    final mCopy = m.clone();
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'day match');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 7, 8, 9, 10), 'days'), true,
        reason: 'plural should work');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 7, 8, 9, 10), 'day'), true,
        reason: 'year is later');
    expect(m.isBeforeUnit(DateTime(2010, 3, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 4, 2, 7, 8, 9, 10), 'day'), true,
        reason: 'month is later');
    expect(m.isBeforeUnit(DateTime(2011, 2, 2, 7, 8, 9, 10), 'day'), false,
        reason: 'month is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 3, 7, 8, 9, 10), 'day'), true,
        reason: 'day is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 7, 8, 9, 10), 'day'), false,
        reason: 'day is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 0, 0, 0, 0), 'day'), false,
        reason: 'exact start of day');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 23, 59, 59, 999), 'day'), false,
        reason: 'exact end of day');
    expect(m.isBeforeUnit(DateTime(2011, 3, 3, 0, 0, 0, 0), 'day'), true,
        reason: 'start of next day');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 23, 59, 59, 999), 'day'), false,
        reason: 'end of previous day');
    expect(m.isBeforeUnit(DateTime(2010, 3, 10, 0, 0, 0, 0), 'day'), false,
        reason: 'later day but earlier year');
    expect(m.isBeforeUnit(m, 'day'), false,
        reason: 'same moments are not before the same day');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit day should not change moment');
  });

  test('is before hour', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 6);
    final mCopy = m.clone();
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'hour match');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 3, 8, 9, 10), 'hours'), true,
        reason: 'plural should work');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 3, 8, 9, 10), 'hour'), true,
        reason: 'year is later');
    expect(m.isBeforeUnit(DateTime(2010, 3, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 4, 2, 3, 8, 9, 10), 'hour'), true,
        reason: 'month is later');
    expect(m.isBeforeUnit(DateTime(2011, 1, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'month is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 3, 3, 8, 9, 10), 'hour'), true,
        reason: 'day is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 3, 8, 9, 10), 'hour'), false,
        reason: 'day is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 4, 8, 9, 10), 'hour'), true,
        reason: 'hour is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 8, 9, 10), 'hour'), false,
        reason: 'hour is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 0, 0, 0), 'hour'), false,
        reason: 'exact start of hour');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 59, 59, 999), 'hour'), false,
        reason: 'exact end of hour');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 4, 0, 0, 0), 'hour'), true,
        reason: 'start of next hour');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 2, 59, 59, 999), 'hour'), false,
        reason: 'end of previous hour');
    expect(m.isBeforeUnit(m, 'hour'), false,
        reason: 'same moments are not before the same hour');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit hour should not change moment');
  });

  test('is before minute', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 6);
    final mCopy = m.clone();
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'minute match');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 3, 4, 9, 10), 'minutes'), true,
        reason: 'plural should work');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 3, 4, 9, 10), 'minute'), true,
        reason: 'year is later');
    expect(m.isBeforeUnit(DateTime(2010, 3, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 4, 2, 3, 4, 9, 10), 'minute'), true,
        reason: 'month is later');
    expect(m.isBeforeUnit(DateTime(2011, 2, 2, 3, 4, 9, 10), 'minute'), false,
        reason: 'month is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 3, 3, 4, 9, 10), 'minute'), true,
        reason: 'day is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 3, 4, 9, 10), 'minute'), false,
        reason: 'day is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 4, 4, 9, 10), 'minute'), true,
        reason: 'hour is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 2, 4, 9, 10), 'minute'), false,
        reason: 'hour is earler');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 5, 9, 10), 'minute'), true,
        reason: 'minute is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 3, 9, 10), 'minute'), false,
        reason: 'minute is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 0, 0), 'minute'), false,
        reason: 'exact start of minute');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 59, 999), 'minute'), false,
        reason: 'exact end of minute');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 5, 0, 0), 'minute'), true,
        reason: 'start of next minute');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 3, 59, 999), 'minute'), false,
        reason: 'end of previous minute');
    expect(m.isBeforeUnit(m, 'minute'), false,
        reason: 'same moments are not before the same minute');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit minute should not change moment');
  });

  test('is before second', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
    final mCopy = m.clone();
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'second match');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 3, 4, 5, 10), 'seconds'), true,
        reason: 'plural should work');
    expect(m.isBeforeUnit(DateTime(2012, 3, 2, 3, 4, 5, 10), 'second'), true,
        reason: 'year is later');
    expect(m.isBeforeUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 4, 2, 3, 4, 5, 10), 'second'), true,
        reason: 'month is later');
    expect(m.isBeforeUnit(DateTime(2011, 2, 2, 3, 4, 5, 10), 'second'), false,
        reason: 'month is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 3, 3, 4, 5, 10), 'second'), true,
        reason: 'day is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 1, 4, 5, 10), 'second'), false,
        reason: 'day is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 4, 4, 5, 10), 'second'), true,
        reason: 'hour is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 1, 4, 1, 5, 10), 'second'), false,
        reason: 'hour is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 5, 5, 10), 'second'), true,
        reason: 'minute is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 3, 5, 10), 'second'), false,
        reason: 'minute is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 6, 10), 'second'), true,
        reason: 'second is later');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 4, 5), 'second'), false,
        reason: 'second is earlier');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 5, 0), 'second'), false,
        reason: 'exact start of second');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 5, 999), 'second'), false,
        reason: 'exact end of second');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 6, 0), 'second'), true,
        reason: 'start of next second');
    expect(m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 4, 999), 'second'), false,
        reason: 'end of previous second');
    expect(m.isBeforeUnit(m, 'second'), false,
        reason: 'same moments are not before the same second');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit second should not change moment');
  });

  test('is before millisecond', () {
    final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
    final mCopy = m.clone();
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'millisecond match');
    expect(m.isBeforeUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'milliseconds'),
        false,
        reason: 'plural should work');
    expect(
        m.isBeforeUnit(DateTime(2012, 3, 2, 3, 4, 5, 10), 'millisecond'), true,
        reason: 'year is later');
    expect(
        m.isBeforeUnit(DateTime(2010, 3, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'year is earlier');
    expect(
        m.isBeforeUnit(DateTime(2011, 4, 2, 3, 4, 5, 10), 'millisecond'), true,
        reason: 'month is later');
    expect(
        m.isBeforeUnit(DateTime(2011, 2, 2, 3, 4, 5, 10), 'millisecond'), false,
        reason: 'month is earlier');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 3, 3, 4, 5, 10), 'millisecond'), true,
        reason: 'day is later');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 1, 1, 4, 5, 10), 'millisecond'), false,
        reason: 'day is earlier');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 4, 4, 5, 10), 'millisecond'), true,
        reason: 'hour is later');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 1, 4, 1, 5, 10), 'millisecond'), false,
        reason: 'hour is earlier');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 3, 5, 5, 10), 'millisecond'), true,
        reason: 'minute is later');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 3, 3, 5, 10), 'millisecond'), false,
        reason: 'minute is earlier');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 6, 10), 'millisecond'), true,
        reason: 'second is later');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 4, 5), 'millisecond'), false,
        reason: 'second is earlier');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 6, 11), 'millisecond'), true,
        reason: 'millisecond is later');
    expect(
        m.isBeforeUnit(DateTime(2011, 3, 2, 3, 4, 4, 9), 'millisecond'), false,
        reason: 'millisecond is earlier');
    expect(m.isBeforeUnit(m, 'millisecond'), false,
        reason: 'same moments are not before the same millisecond');
    expect(m.isSame(mCopy), true,
        reason: 'isBeforeUnit millisecond should not change moment');
  });

  // isBetween
}
