import 'package:date_extension/constant.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:date_extension/date_extension.dart';

void main() {
  test("get startOf Year", () {
    var date = DateTime(2022, 6, 9, 10, 50, 20);
    expect(date.startOf("y"), DateTime(2022, 1, 1, 0, 0, 0));
    expect(date.endOf("y"), DateTime(2022, 12, 31, 23, 59, 59, 999));

    expect(date.startOf("M"), DateTime(2022, 6, 1, 0, 0, 0));
    expect(date.endOf("M"), DateTime(2022, 6, 30, 23, 59, 59, 999));
  });

  test("endOf", () {
    var date = DateTime(2022, 6, 9, 10, 50, 20);
    expect(date.endOf("y"), DateTime(2022, 12, 31, 23, 59, 59, 999));
  });

  test("format", () {
    var date = DateTime(2022, 6, 9, 10, 50, 20);
    expect(date.format("YYYY-MM-DD HH:mm:ss"), "2022-06-09 10:50:20");
  });

  test("add", () {
    var date = DateTime(2022, 6, 9, 10, 50, 20);

    expect(date.addTime(2, "M"), DateTime(2022, 8, 9, 10, 50, 20));
  });

  test("diff", () {
    final date1 = DateTime.parse('2019-01-25');
    final date2 = DateTime.parse('2018-06-05');

    expect(date1.diff2(date2), 20217600000); //  默认单位是毫秒
    expect(date1.diff("2020-02-25", "year"), -1);
    expect(date1.diff("2018-12-01", "year", true), 0.15300546448087426);
    expect(DateTime.parse("2018-12-01").diff("2019-01-25", "year", true),
        -0.15300546448087426);
    expect(date1.diff('2018-06-05', 'month'), 7);
    expect(date1.diff('2018-06-05', 'month', true), 7.645161290322581);
    expect(date2.diff('2019-01-25', 'month'), -7);
    expect(date2.diff('2019-01-25', 'month', true), -7.645161290322581);
    expect(date1.diff("2018-12-01", DateUnit.d, true), 55);
    expect(date1.diff("2019-01-25 00:20:00", DateUnit.m), -20);
  });

  test("isSame", () {
    final date1 = DateTime.parse("2022-06-01 10:00:00");
    expect(
        date1.isSame(DateTime.parse("2022-06-01 10:00:00,123456789z")), false);
    expect(date1.isSame(DateTime.parse("2022-06-01 10:00:00")), true);
  });

  test("setDate", () {
    final date1 = DateTime.parse("2022-01-01 10:00:00");
    expect(date1.setDate(32), DateTime.parse("2022-02-01 10:00:00"));
  });

  test("isBeforeUnit,isAfterUnit", () {
    final date1 = DateTime.parse("2022-01-01 10:00:00");
    final date2 = DateTime.parse("2022-02-01 10:00:00");
    expect(date1.isBeforeUnit(date2), true);
    expect(date1.isAfterUnit(date2), false);
  });
  test("isBeforeUnit,isAfterUnit with Unit", () {
    final date1 = DateTime.parse("2022-02-01 10:00:00");
    final date2 = DateTime.parse("2022-02-03 10:00:00");
    expect(date1.isBeforeUnit(date2, "M"), false);
    expect(date1.isAfterUnit(date2), false);
  });

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
