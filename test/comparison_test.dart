import 'package:date_extension/constant.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:date_extension/date_extension.dart';

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
    // expect(m.isSame(DateTime(2011, 5, 6, 7, 8, 9, 10)), 'years',true, reason:'plural should work');// 不支持years
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
    expect(m.isSameUnit(DateTime(2011, 2, 31, 23, 59, 59, 999), 'month'), true,
        reason: 'exact end of month');
    expect(m.isSameUnit(DateTime(2011, 3, 1, 0, 0, 0, 0), 'month'), false,
        reason: 'start of next month');
    expect(m.isSameUnit(DateTime(2011, 1, 27, 23, 59, 59, 999), 'month'), false,
        reason: 'end of previous month');
  });

  test('is same day', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isSameUnit(DateTime(2011, 1, 2, 7, 8, 9, 10), 'day'), true,
        reason: 'day match');
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

// test('is same minute', (){
//   const m = DateTime(2011, 1, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 9, 10)), 'minute',true, reason:'minute match')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 9, 10)), 'minutes',true, reason:'plural should work')
//   expect(m.isSame(DateTime(2012, 1, 2, 3, 4, 9, 10)), 'minute',false, reason:'year mismatch')
//   expect(m.isSame(DateTime(2011, 2, 2, 3, 4, 9, 10)), 'minute',false, reason:'month mismatch')
//   expect(m.isSame(DateTime(2011, 1, 3, 3, 4, 9, 10)), 'minute',false, reason:'day mismatch')
//   expect(m.isSame(DateTime(2011, 1, 2, 4, 4, 9, 10)), 'minute',false, reason:'hour mismatch')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 5, 9, 10)), 'minute',false, reason:'minute mismatch')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 0, 0)), 'minute',true, reason:'exact start of minute')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 59, 999)), 'minute',true, reason:'exact end of minute')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 5, 0, 0)), 'minute',false, reason:'start of next minute')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 3, 59, 999)), 'minute',false, reason:'end of previous minute')
//   expect(m.isSame(m, 'minute',true, reason:'same moments are in the same minute')
//   expect(+m).toEqual(+mCopy, 'isSame minute should not change moment')
// })

// test('is same second', (){
//   const m = DateTime(2011, 1, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 5, 10)), 'second',true, reason:'second match')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 5, 10)), 'seconds',true, reason:'plural should work')
//   expect(m.isSame(DateTime(2012, 1, 2, 3, 4, 5, 10)), 'second',false, reason:'year mismatch')
//   expect(m.isSame(DateTime(2011, 2, 2, 3, 4, 5, 10)), 'second',false, reason:'month mismatch')
//   expect(m.isSame(DateTime(2011, 1, 3, 3, 4, 5, 10)), 'second',false, reason:'day mismatch')
//   expect(m.isSame(DateTime(2011, 1, 2, 4, 4, 5, 10)), 'second',false, reason:'hour mismatch')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 5, 5, 10)), 'second',false, reason:'minute mismatch')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 6, 10)), 'second',false, reason:'second mismatch')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 5, 0)), 'second',true, reason:'exact start of second')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 5, 999)), 'second',true, reason:'exact end of second')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 6, 0)), 'second',false, reason:'start of next second')
//   expect(m.isSame(DateTime(2011, 1, 2, 3, 4, 4, 999)), 'second',false, reason:'end of previous second')
//   expect(m.isSame(m, 'second',true, reason:'same moments are in the same second')
//   expect(+m).toEqual(+mCopy, 'isSame second should not change moment')
// })

// test('is same millisecond', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 10))
//   const mCopy = dayjs(m)
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 5, 10)), 'millisecond',true, reason:'millisecond match')
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 5, 10)), 'milliseconds',true, reason:'plural should work')
//   expect(m.isSame(DateTime(2012, 3, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'year is later')
//   expect(m.isSame(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'year is earlier')
//   expect(m.isSame(DateTime(2011, 4, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'month is later')
//   expect(m.isSame(DateTime(2011, 2, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'month is earlier')
//   expect(m.isSame(DateTime(2011, 3, 3, 3, 4, 5, 10)), 'millisecond',false, reason:'day is later')
//   expect(m.isSame(DateTime(2011, 3, 1, 1, 4, 5, 10)), 'millisecond',false, reason:'day is earlier')
//   expect(m.isSame(DateTime(2011, 3, 2, 4, 4, 5, 10)), 'millisecond',false, reason:'hour is later')
//   expect(m.isSame(DateTime(2011, 3, 1, 4, 1, 5, 10)), 'millisecond',false, reason:'hour is earlier')
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 5, 5, 10)), 'millisecond',false, reason:'minute is later')
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 3, 5, 10)), 'millisecond',false, reason:'minute is earlier')
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 6, 10)), 'millisecond',false, reason:'second is later')
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 4, 5)), 'millisecond',false, reason:'second is earlier')
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 6, 11)), 'millisecond',false, reason:'millisecond is later')
//   expect(m.isSame(DateTime(2011, 3, 2, 3, 4, 4, 9)), 'millisecond',false, reason:'millisecond is earlier')
//   expect(m.isSame(m, 'millisecond',true, reason:'same moments are in the same millisecond')
//   expect(+m).toEqual(+mCopy, 'isSame millisecond should not change moment')
// })

// test('is same with invalid moments', (){
//   expect(dayjs(null).isSame(dayjs('2018-01-01'),false, reason:'invalid moments are not considered equal')
//   expect(dayjs('2018-01-01').isSame(dayjs(null),false, reason:'invalid moments are not considered equal')
// })

// // isAfter()

// test('is after year', (){
//   const m = DateTime(2011, 1, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2011, 5, 6, 7, 8, 9, 10)), 'year',false, reason:'year match')
//   expect(m.isAfter(DateTime(2010, 5, 6, 7, 8, 9, 10)), 'years',true, reason:'plural should work')
//   expect(m.isAfter(DateTime(2013, 5, 6, 7, 8, 9, 10)), 'year',false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 5, 6, 7, 8, 9, 10)), 'year',true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 0, 1, 0, 0, 0, 0)), 'year',false, reason:'exact start of year')
//   expect(m.isAfter(DateTime(2011, 11, 31, 23, 59, 59, 999)), 'year',false, reason:'exact end of year')
//   expect(m.isAfter(DateTime(2012, 0, 1, 0, 0, 0, 0)), 'year',false, reason:'start of next year')
//   expect(m.isAfter(DateTime(2010, 11, 31, 23, 59, 59, 999)), 'year',true, reason:'end of previous year')
//   expect(m.isAfter(DateTime(1980, 11, 31, 23, 59, 59, 999)), 'year',true, reason:'end of year far before')
//   expect(m.isAfter(m, 'year',false, reason:'same moments are not after the same year')
//   expect(+m).toEqual(+mCopy, 'isAfter year should not change moment')
// })

// test('is after month', (){
//   const m = DateTime(2011, 2, 3, 4, 5, 6, 7))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2011, 2, 6, 7, 8, 9, 10)), 'month',false, reason:'month match')
//   expect(m.isAfter(DateTime(2010, 2, 6, 7, 8, 9, 10)), 'months',true, reason:'plural should work')
//   expect(m.isAfter(DateTime(2012, 2, 6, 7, 8, 9, 10)), 'month',false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 2, 6, 7, 8, 9, 10)), 'month',true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 5, 6, 7, 8, 9, 10)), 'month',false, reason:'month is later')
//   expect(m.isAfter(DateTime(2011, 1, 6, 7, 8, 9, 10)), 'month',true, reason:'month is earlier')
//   expect(m.isAfter(DateTime(2011, 2, 1, 0, 0, 0, 0)), 'month',false, reason:'exact start of month')
//   expect(m.isAfter(DateTime(2011, 2, 31, 23, 59, 59, 999)), 'month',false, reason:'exact end of month')
//   expect(m.isAfter(DateTime(2011, 3, 1, 0, 0, 0, 0)), 'month',false, reason:'start of next month')
//   expect(m.isAfter(DateTime(2011, 1, 27, 23, 59, 59, 999)), 'month',true, reason:'end of previous month')
//   expect(m.isAfter(DateTime(2010, 12, 31, 23, 59, 59, 999)), 'month',true, reason:'later month but earlier year')
//   expect(m.isAfter(m, 'month',false, reason:'same moments are not after the same month')
//   expect(+m).toEqual(+mCopy, 'isAfter month should not change moment')
// })

// test('is after day', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2011, 3, 2, 7, 8, 9, 10)), 'day',false, reason:'day match')
//   expect(m.isAfter(DateTime(2010, 3, 2, 7, 8, 9, 10)), 'days',true, reason:'plural should work')
//   expect(m.isAfter(DateTime(2012, 3, 2, 7, 8, 9, 10)), 'day',false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 3, 2, 7, 8, 9, 10)), 'day',true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 4, 2, 7, 8, 9, 10)), 'day',false, reason:'month is later')
//   expect(m.isAfter(DateTime(2011, 2, 2, 7, 8, 9, 10)), 'day',true, reason:'month is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 3, 7, 8, 9, 10)), 'day',false, reason:'day is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 7, 8, 9, 10)), 'day',true, reason:'day is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 0, 0, 0, 0)), 'day',false, reason:'exact start of day')
//   expect(m.isAfter(DateTime(2011, 3, 2, 23, 59, 59, 999)), 'day',false, reason:'exact end of day')
//   expect(m.isAfter(DateTime(2011, 3, 3, 0, 0, 0, 0)), 'day',false, reason:'start of next day')
//   expect(m.isAfter(DateTime(2011, 3, 1, 23, 59, 59, 999)), 'day',true, reason:'end of previous day')
//   expect(m.isAfter(DateTime(2010, 3, 10, 0, 0, 0, 0)), 'day',true, reason:'later day but earlier year')
//   expect(m.isAfter(m, 'day',false, reason:'same moments are not after the same day')
//   expect(+m).toEqual(+mCopy, 'isAfter day should not change moment')
// })

// test('is after hour', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 8, 9, 10)), 'hour',false, reason:'hour match')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 8, 9, 10)), 'hours',true, reason:'plural should work')
//   expect(m.isAfter(DateTime(2012, 3, 2, 3, 8, 9, 10)), 'hour',false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 8, 9, 10)), 'hour',true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 4, 2, 3, 8, 9, 10)), 'hour',false, reason:'month is later')
//   expect(m.isAfter(DateTime(2011, 1, 2, 3, 8, 9, 10)), 'hour',true, reason:'month is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 3, 3, 8, 9, 10)), 'hour',false, reason:'day is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 3, 8, 9, 10)), 'hour',true, reason:'day is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 4, 8, 9, 10)), 'hour',false, reason:'hour is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 8, 9, 10)), 'hour',false, reason:'hour is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 0, 0, 0)), 'hour',false, reason:'exact start of hour')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 59, 59, 999)), 'hour',false, reason:'exact end of hour')
//   expect(m.isAfter(DateTime(2011, 3, 2, 4, 0, 0, 0)), 'hour',false, reason:'start of next hour')
//   expect(m.isAfter(DateTime(2011, 3, 2, 2, 59, 59, 999)), 'hour',true, reason:'end of previous hour')
//   expect(m.isAfter(m, 'hour',false, reason:'same moments are not after the same hour')
//   expect(+m).toEqual(+mCopy, 'isAfter hour should not change moment')
// })

// test('is after minute', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 9, 10)), 'minute',false, reason:'minute match')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 4, 9, 10)), 'minutes',true, reason:'plural should work')
//   expect(m.isAfter(DateTime(2012, 3, 2, 3, 4, 9, 10)), 'minute',false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 4, 9, 10)), 'minute',true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 4, 2, 3, 4, 9, 10)), 'minute',false, reason:'month is later')
//   expect(m.isAfter(DateTime(2011, 2, 2, 3, 4, 9, 10)), 'minute',true, reason:'month is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 3, 3, 4, 9, 10)), 'minute',false, reason:'day is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 3, 4, 9, 10)), 'minute',true, reason:'day is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 4, 4, 9, 10)), 'minute',false, reason:'hour is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 2, 4, 9, 10)), 'minute',true, reason:'hour is earler')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 5, 9, 10)), 'minute',false, reason:'minute is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 3, 9, 10)), 'minute',true, reason:'minute is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 0, 0)), 'minute',false, reason:'exact start of minute')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 59, 999)), 'minute',false, reason:'exact end of minute')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 5, 0, 0)), 'minute',false, reason:'start of next minute')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 3, 59, 999)), 'minute',true, reason:'end of previous minute')
//   expect(m.isAfter(m, 'minute',false, reason:'same moments are not after the same minute')
//   expect(+m).toEqual(+mCopy, 'isAfter minute should not change moment')
// })

// test('is after second', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 10))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 5, 10)), 'second',false, reason:'second match')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'seconds',true, reason:'plural should work')
//   expect(m.isAfter(DateTime(2012, 3, 2, 3, 4, 5, 10)), 'second',false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'second',true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 4, 2, 3, 4, 5, 10)), 'second',false, reason:'month is later')
//   expect(m.isAfter(DateTime(2011, 2, 2, 3, 4, 5, 10)), 'second',true, reason:'month is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 3, 3, 4, 5, 10)), 'second',false, reason:'day is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 1, 4, 5, 10)), 'second',true, reason:'day is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 4, 4, 5, 10)), 'second',false, reason:'hour is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 4, 1, 5, 10)), 'second',true, reason:'hour is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 5, 5, 10)), 'second',false, reason:'minute is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 3, 5, 10)), 'second',true, reason:'minute is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 6, 10)), 'second',false, reason:'second is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 4, 5)), 'second',true, reason:'second is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 5, 0)), 'second',false, reason:'exact start of second')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 5, 999)), 'second',false, reason:'exact end of second')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 6, 0)), 'second',false, reason:'start of next second')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 4, 999)), 'second',true, reason:'end of previous second')
//   expect(m.isAfter(m, 'second',false, reason:'same moments are not after the same second')
//   expect(+m).toEqual(+mCopy, 'isAfter second should not change moment')
// })

// test('is after millisecond', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 10))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'millisecond match')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'milliseconds',true, reason:'plural should work')
//   expect(m.isAfter(DateTime(2012, 3, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'millisecond',true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 4, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'month is later')
//   expect(m.isAfter(DateTime(2011, 2, 2, 3, 4, 5, 10)), 'millisecond',true, reason:'month is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 3, 3, 4, 5, 10)), 'millisecond',false, reason:'day is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 1, 4, 5, 10)), 'millisecond',true, reason:'day is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 4, 4, 5, 10)), 'millisecond',false, reason:'hour is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 4, 1, 5, 10)), 'millisecond',true, reason:'hour is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 5, 5, 10)), 'millisecond',false, reason:'minute is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 3, 5, 10)), 'millisecond',true, reason:'minute is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 6, 10)), 'millisecond',false, reason:'second is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 4, 5)), 'millisecond',true, reason:'second is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 6, 11)), 'millisecond',false, reason:'millisecond is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 4, 9)), 'millisecond',true, reason:'millisecond is earlier')
//   expect(m.isAfter(m, 'millisecond',false, reason:'same moments are not after the same millisecond')
//   expect(+m).toEqual(+mCopy, 'isAfter millisecond should not change moment')
// })

// test('is after without units', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 10))
//   const mCopy = dayjs(m)
//   expect(m.isAfter(DateTime(2012, 3, 2, 3, 5, 5, 10)),false, reason:'year is later')
//   expect(m.isAfter(DateTime(2010, 3, 2, 3, 3, 5, 10)),true, reason:'year is earlier')
//   expect(m.isAfter(DateTime(2011, 4, 2, 3, 4, 5, 10)),false, reason:'month is later')
//   expect(m.isAfter(DateTime(2011, 2, 2, 3, 4, 5, 10)),true, reason:'month is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 3, 3, 4, 5, 10)),false, reason:'day is later')
//   expect(m.isAfter(DateTime(2011, 3, 1, 3, 4, 5, 10)),true, reason:'day is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 4, 4, 5, 10)),false, reason:'hour is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 2, 4, 5, 10)),true, reason:'hour is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 5, 5, 10)),false, reason:'minute is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 3, 5, 10)),true, reason:'minute is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 6, 10)),false, reason:'second is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 4, 11)),true, reason:'second is earlier')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 5, 10)),false, reason:'millisecond match')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 5, 11)),false, reason:'millisecond is later')
//   expect(m.isAfter(DateTime(2011, 3, 2, 3, 4, 5, 9)),true, reason:'millisecond is earlier')
//   expect(m.isAfter(m,false, reason:'moments are not after themselves')
//   expect(+m).toEqual(+mCopy, 'isAfter second should not change moment')
// })

// test('is after invalid', (){
//   const m = dayjs()
//   const invalid = dayjs(null)
//   expect(m.isAfter(invalid,false, reason:'valid moment is not after invalid moment')
//   expect(invalid.isAfter(m,false, reason:'invalid moment is not after valid moment')
//   expect(m.isAfter(invalid, 'year',false, reason:'invalid moment year')
//   expect(m.isAfter(invalid, 'month',false, reason:'invalid moment month')
//   expect(m.isAfter(invalid, 'day',false, reason:'invalid moment day')
//   expect(m.isAfter(invalid, 'hour',false, reason:'invalid moment hour')
//   expect(m.isAfter(invalid, 'minute',false, reason:'invalid moment minute')
//   expect(m.isAfter(invalid, 'second',false, reason:'invalid moment second')
//   expect(m.isAfter(invalid, 'milliseconds',false, reason:'invalid moment milliseconds')
// })

// // isBefore()

// test('is after without units', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 10))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 5, 5, 10)),true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 3, 2, 3, 3, 5, 10)),false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 4, 2, 3, 4, 5, 10)),true, reason:'month is later')
//   expect(m.isBefore(DateTime(2011, 2, 2, 3, 4, 5, 10)),false, reason:'month is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 3, 3, 4, 5, 10)),true, reason:'day is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 3, 4, 5, 10)),false, reason:'day is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 4, 4, 5, 10)),true, reason:'hour is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 2, 4, 5, 10)),false, reason:'hour is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 5, 5, 10)),true, reason:'minute is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 3, 5, 10)),false, reason:'minute is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 6, 10)),true, reason:'second is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 4, 11)),false, reason:'second is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 5, 10)),false, reason:'millisecond match')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 5, 11)),true, reason:'millisecond is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 5, 9)),false, reason:'millisecond is earlier')
//   expect(m.isBefore(m,false, reason:'moments are not before themselves')
//   expect(+m).toEqual(+mCopy, 'isBefore second should not change moment')
// })

// test('is before year', (){
//   const m = DateTime(2011, 1, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2011, 5, 6, 7, 8, 9, 10)), 'year',false, reason:'year match')
//   expect(m.isBefore(DateTime(2012, 5, 6, 7, 8, 9, 10)), 'years',true, reason:'plural should work')
//   expect(m.isBefore(DateTime(2013, 5, 6, 7, 8, 9, 10)), 'year',true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 5, 6, 7, 8, 9, 10)), 'year',false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 0, 1, 0, 0, 0, 0)), 'year',false, reason:'exact start of year')
//   expect(m.isBefore(DateTime(2011, 11, 31, 23, 59, 59, 999)), 'year',false, reason:'exact end of year')
//   expect(m.isBefore(DateTime(2012, 0, 1, 0, 0, 0, 0)), 'year',true, reason:'start of next year')
//   expect(m.isBefore(DateTime(2010, 11, 31, 23, 59, 59, 999)), 'year',false, reason:'end of previous year')
//   expect(m.isBefore(DateTime(1980, 11, 31, 23, 59, 59, 999)), 'year',false, reason:'end of year far before')
//   expect(m.isBefore(m, 'year',false, reason:'same moments are not before the same year')
//   expect(+m).toEqual(+mCopy, 'isBefore year should not change moment')
// })

// test('is before month', (){
//   const m = DateTime(2011, 2, 3, 4, 5, 6, 7))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2011, 2, 6, 7, 8, 9, 10)), 'month',false, reason:'month match')
//   expect(m.isBefore(DateTime(2012, 2, 6, 7, 8, 9, 10)), 'months',true, reason:'plural should work')
//   expect(m.isBefore(DateTime(2012, 2, 6, 7, 8, 9, 10)), 'month',true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 2, 6, 7, 8, 9, 10)), 'month',false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 5, 6, 7, 8, 9, 10)), 'month',true, reason:'month is later')
//   expect(m.isBefore(DateTime(2011, 1, 6, 7, 8, 9, 10)), 'month',false, reason:'month is earlier')
//   expect(m.isBefore(DateTime(2011, 2, 1, 0, 0, 0, 0)), 'month',false, reason:'exact start of month')
//   expect(m.isBefore(DateTime(2011, 2, 31, 23, 59, 59, 999)), 'month',false, reason:'exact end of month')
//   expect(m.isBefore(DateTime(2011, 3, 1, 0, 0, 0, 0)), 'month',true, reason:'start of next month')
//   expect(m.isBefore(DateTime(2011, 1, 27, 23, 59, 59, 999)), 'month',false, reason:'end of previous month')
//   expect(m.isBefore(DateTime(2010, 12, 31, 23, 59, 59, 999)), 'month',false, reason:'later month but earlier year')
//   expect(m.isBefore(m, 'month',false, reason:'same moments are not before the same month')
//   expect(+m).toEqual(+mCopy, 'isBefore month should not change moment')
// })

// test('is before day', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2011, 3, 2, 7, 8, 9, 10)), 'day',false, reason:'day match')
//   expect(m.isBefore(DateTime(2012, 3, 2, 7, 8, 9, 10)), 'days',true, reason:'plural should work')
//   expect(m.isBefore(DateTime(2012, 3, 2, 7, 8, 9, 10)), 'day',true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 3, 2, 7, 8, 9, 10)), 'day',false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 4, 2, 7, 8, 9, 10)), 'day',true, reason:'month is later')
//   expect(m.isBefore(DateTime(2011, 2, 2, 7, 8, 9, 10)), 'day',false, reason:'month is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 3, 7, 8, 9, 10)), 'day',true, reason:'day is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 7, 8, 9, 10)), 'day',false, reason:'day is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 0, 0, 0, 0)), 'day',false, reason:'exact start of day')
//   expect(m.isBefore(DateTime(2011, 3, 2, 23, 59, 59, 999)), 'day',false, reason:'exact end of day')
//   expect(m.isBefore(DateTime(2011, 3, 3, 0, 0, 0, 0)), 'day',true, reason:'start of next day')
//   expect(m.isBefore(DateTime(2011, 3, 1, 23, 59, 59, 999)), 'day',false, reason:'end of previous day')
//   expect(m.isBefore(DateTime(2010, 3, 10, 0, 0, 0, 0)), 'day',false, reason:'later day but earlier year')
//   expect(m.isBefore(m, 'day',false, reason:'same moments are not before the same day')
//   expect(+m).toEqual(+mCopy, 'isBefore day should not change moment')
// })

// test('is before hour', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 8, 9, 10)), 'hour',false, reason:'hour match')
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 8, 9, 10)), 'hours',true, reason:'plural should work')
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 8, 9, 10)), 'hour',true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 3, 2, 3, 8, 9, 10)), 'hour',false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 4, 2, 3, 8, 9, 10)), 'hour',true, reason:'month is later')
//   expect(m.isBefore(DateTime(2011, 1, 2, 3, 8, 9, 10)), 'hour',false, reason:'month is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 3, 3, 8, 9, 10)), 'hour',true, reason:'day is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 3, 8, 9, 10)), 'hour',false, reason:'day is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 4, 8, 9, 10)), 'hour',true, reason:'hour is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 8, 9, 10)), 'hour',false, reason:'hour is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 0, 0, 0)), 'hour',false, reason:'exact start of hour')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 59, 59, 999)), 'hour',false, reason:'exact end of hour')
//   expect(m.isBefore(DateTime(2011, 3, 2, 4, 0, 0, 0)), 'hour',true, reason:'start of next hour')
//   expect(m.isBefore(DateTime(2011, 3, 2, 2, 59, 59, 999)), 'hour',false, reason:'end of previous hour')
//   expect(m.isBefore(m, 'hour',false, reason:'same moments are not before the same hour')
//   expect(+m).toEqual(+mCopy, 'isBefore hour should not change moment')
// })

// test('is before minute', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 6))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 9, 10)), 'minute',false, reason:'minute match')
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 4, 9, 10)), 'minutes',true, reason:'plural should work')
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 4, 9, 10)), 'minute',true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 3, 2, 3, 4, 9, 10)), 'minute',false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 4, 2, 3, 4, 9, 10)), 'minute',true, reason:'month is later')
//   expect(m.isBefore(DateTime(2011, 2, 2, 3, 4, 9, 10)), 'minute',false, reason:'month is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 3, 3, 4, 9, 10)), 'minute',true, reason:'day is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 3, 4, 9, 10)), 'minute',false, reason:'day is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 4, 4, 9, 10)), 'minute',true, reason:'hour is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 2, 4, 9, 10)), 'minute',false, reason:'hour is earler')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 5, 9, 10)), 'minute',true, reason:'minute is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 3, 9, 10)), 'minute',false, reason:'minute is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 0, 0)), 'minute',false, reason:'exact start of minute')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 59, 999)), 'minute',false, reason:'exact end of minute')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 5, 0, 0)), 'minute',true, reason:'start of next minute')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 3, 59, 999)), 'minute',false, reason:'end of previous minute')
//   expect(m.isBefore(m, 'minute',false, reason:'same moments are not before the same minute')
//   expect(+m).toEqual(+mCopy, 'isBefore minute should not change moment')
// })

// test('is before second', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 10))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 5, 10)), 'second',false, reason:'second match')
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 4, 5, 10)), 'seconds',true, reason:'plural should work')
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 4, 5, 10)), 'second',true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'second',false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 4, 2, 3, 4, 5, 10)), 'second',true, reason:'month is later')
//   expect(m.isBefore(DateTime(2011, 2, 2, 3, 4, 5, 10)), 'second',false, reason:'month is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 3, 3, 4, 5, 10)), 'second',true, reason:'day is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 1, 4, 5, 10)), 'second',false, reason:'day is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 4, 4, 5, 10)), 'second',true, reason:'hour is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 4, 1, 5, 10)), 'second',false, reason:'hour is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 5, 5, 10)), 'second',true, reason:'minute is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 3, 5, 10)), 'second',false, reason:'minute is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 6, 10)), 'second',true, reason:'second is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 4, 5)), 'second',false, reason:'second is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 5, 0)), 'second',false, reason:'exact start of second')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 5, 999)), 'second',false, reason:'exact end of second')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 6, 0)), 'second',true, reason:'start of next second')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 4, 999)), 'second',false, reason:'end of previous second')
//   expect(m.isBefore(m, 'second',false, reason:'same moments are not before the same second')
//   expect(+m).toEqual(+mCopy, 'isBefore second should not change moment')
// })

// test('is before millisecond', (){
//   const m = DateTime(2011, 3, 2, 3, 4, 5, 10))
//   const mCopy = dayjs(m)
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'millisecond match')
//   expect(m.isBefore(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'milliseconds',false, reason:'plural should work')
//   expect(m.isBefore(DateTime(2012, 3, 2, 3, 4, 5, 10)), 'millisecond',true, reason:'year is later')
//   expect(m.isBefore(DateTime(2010, 3, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'year is earlier')
//   expect(m.isBefore(DateTime(2011, 4, 2, 3, 4, 5, 10)), 'millisecond',true, reason:'month is later')
//   expect(m.isBefore(DateTime(2011, 2, 2, 3, 4, 5, 10)), 'millisecond',false, reason:'month is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 3, 3, 4, 5, 10)), 'millisecond',true, reason:'day is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 1, 4, 5, 10)), 'millisecond',false, reason:'day is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 4, 4, 5, 10)), 'millisecond',true, reason:'hour is later')
//   expect(m.isBefore(DateTime(2011, 3, 1, 4, 1, 5, 10)), 'millisecond',false, reason:'hour is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 5, 5, 10)), 'millisecond',true, reason:'minute is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 3, 5, 10)), 'millisecond',false, reason:'minute is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 6, 10)), 'millisecond',true, reason:'second is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 4, 5)), 'millisecond',false, reason:'second is earlier')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 6, 11)), 'millisecond',true, reason:'millisecond is later')
//   expect(m.isBefore(DateTime(2011, 3, 2, 3, 4, 4, 9)), 'millisecond',false, reason:'millisecond is earlier')
//   expect(m.isBefore(m, 'millisecond',false, reason:'same moments are not before the same millisecond')
//   expect(+m).toEqual(+mCopy, 'isBefore millisecond should not change moment')
// })

// test('is before invalid', (){
//   const m = dayjs()
//   const invalid = dayjs(null)
//   expect(m.isBefore(invalid,false, reason:'valid moment is not before invalid moment')
//   expect(invalid.isBefore(m,false, reason:'invalid moment is not before valid moment')
//   expect(m.isBefore(invalid, 'year',false, reason:'invalid moment year')
//   expect(m.isBefore(invalid, 'month',false, reason:'invalid moment month')
//   expect(m.isBefore(invalid, 'day',false, reason:'invalid moment day')
//   expect(m.isBefore(invalid, 'hour',false, reason:'invalid moment hour')
//   expect(m.isBefore(invalid, 'minute',false, reason:'invalid moment minute')
//   expect(m.isBefore(invalid, 'second',false, reason:'invalid moment second')
//   expect(m.isBefore(invalid, 'milliseconds',false, reason:'invalid moment milliseconds')
// })

  test('is before year', () {
    final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
    expect(m.isBeforeUnit((DateTime(2011, 6, 6, 7, 8, 9, 10)), 'year'), false,
        reason: 'year match');
    expect(m.isBeforeUnit((DateTime(2012, 6, 6, 7, 8, 9, 10)), 'years'), true,
        reason: 'plural should work');
    expect(m.isBeforeUnit((DateTime(2013, 6, 6, 7, 8, 9, 10)), 'year'), true,
        reason: 'year is later');
    expect(m.isBeforeUnit((DateTime(2010, 6, 6, 7, 8, 9, 10)), 'year'), false,
        reason: 'year is earlier');
    expect(m.isBeforeUnit((DateTime(2011, 1, 1, 0, 0, 0, 0)), 'year'), false,
        reason: 'exact start of year');
    expect(m.isBeforeUnit((DateTime(2011, 12, 31, 23, 59, 59, 999)), 'year'),
        false,
        reason: 'exact end of year');
    expect(m.isBeforeUnit((DateTime(2012, 1, 1, 0, 0, 0, 0)), 'year'), true,
        reason: 'start of next year');
    expect(m.isBeforeUnit((DateTime(2010, 12, 31, 23, 59, 59, 999)), 'year'),
        false,
        reason: 'end of previous year');
    expect(m.isBeforeUnit((DateTime(1980, 12, 31, 23, 59, 59, 999)), 'year'),
        false,
        reason: 'end of year far before');
    expect(m.isBeforeUnit(m, 'year'), false,
        reason: 'same moments are not before the same year');
  });
}
