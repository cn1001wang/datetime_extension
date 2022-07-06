import 'package:date_extension/constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:date_extension/date_extension.dart';

void main() {
  group('Diff:', () {
    final d1 = DateTime.parse('2019-04-30T10:30:30.000Z');

    test('2 years', () {
      final d2 = DateTime.parse('2021-05-01T10:30:30.000Z');
      final d3 = DateTime.parse('2020-04-30T10:30:30.000Z');

      expect(d1.diff2(d2, 'y'), equals(-2));
      expect(d1.diff2(d2, 'y', true), equals(-2.0027397260273972603));
      expect(d2.diff2(d1, 'y'), equals(2));
      expect(d2.diff2(d1, 'y', true), equals(2.0027397260273972603));
      expect(d3.diff2(d1, 'y'), equals(1));
      expect(d3.diff2(d1, 'y', true), equals(1));
    });

    test('2 months', () {
      final d2 = DateTime.parse('2019-02-01T10:30:30.000Z');

      expect(d1.diff2(d2, DateUnit.M), equals(2));
      expect(d2.diff2(d1, 'M'), equals(-2));
      expect(d1.diff2(d2, DateUnit.M, true), equals(2 + 29 / 30));
    });

    test('33 days', () {
      final d2 = DateTime.parse('2019-06-02T11:30:30.000Z');

      expect(d1.diff2(d2, 'd'), equals(-33));
      expect(d2.diff2(d1, 'd'), equals(33));
      expect(d1.diff2(d2, 'd', true), equals(-33.041666666666664));
      expect(d2.diff2(d1, 'd', true), equals(33.041666666666664));
    });

    test('10 hours', () {
      final d2 = DateTime.parse('2019-04-30T20:40:30.000Z');

      expect(d1.diff2(d2, 'h'), equals(-10));
      expect(d2.diff2(d1, 'h'), equals(10));
      expect(d1.diff2(d2, 'h', true), equals(-10.166666666666666));
      expect(d2.diff2(d1, 'h', true), equals(10.166666666666666));
    });

    test('55 minutes', () {
      final d2 = DateTime.parse('2019-04-30T11:25:40.000Z');

      expect(d1.diff2(d2, 'm'), equals(-55));
      expect(d2.diff2(d1, 'm'), equals(55));
      expect(d1.diff2(d2, 'm', true), equals(-55.166666666666664));
      expect(d2.diff2(d1, 'm', true), equals(55.166666666666664));
    });

    test('3 seconds', () {
      final d2 = DateTime.parse('2019-04-30T10:30:33.110Z');

      expect(d1.diff2(d2, 's'), equals(-3));
      expect(d2.diff2(d1, 's'), equals(3));
      expect(d1.diff2(d2, 's', true), equals(-3.11));
      expect(d2.diff2(d1, 's', true), equals(3.11));
    });

    test('333 milliseconds', () {
      final d2 = DateTime.parse('2019-04-30T10:30:30.333Z');

      expect(d1.diff2(d2), equals(-333));
      expect(d1.diff2(d2, 'ms'), equals(-333));
      expect(d2.diff2(d1, 'ms'), equals(333));
      expect(d1.diff2(d2, 'ms', true), equals(-333));
      expect(d2.diff2(d1, 'ms', true), equals(333));
    });
  });

  group("format", () {
    final d = DateTime.parse('2019-04-30T10:30:30.000Z');

    test('default', () {
      expect(d.format(), equals('2019-04-30T10:30:30.000Z'));
    });

    test('[YYYYescape]', () {
      expect(d.format('[YYYYescape]'), 'YYYYescape');
    });

    test('Y', () {
      expect(d.format('Y'), equals('19'));
    });

    test('YY', () {
      expect(d.format('YY'), equals('19'));
    });

    test('YYY', () {
      expect(d.format('YYY'), equals('2019'));
    });

    test('YYYY', () {
      expect(d.format('YYYY'), equals('2019'));
    });

    test('M', () {
      expect(d.format('M'), equals('4'));
    });

    test('MM', () {
      expect(d.format('MM'), equals('04'));
    });

    test('MMM', () {
      expect(d.format('MMM'), equals('Apr'));
    });

    test('MMMM', () {
      expect(d.format('MMMM'), equals('April'));
    });

    test('D', () {
      expect(d.format('D'), equals('30'));
    });

    test('DD', () {
      expect(d.format('DD'), equals('30'));
    });

    test('W', () {
      expect(d.format('W'), equals('2'));
    });

    test('WW', () {
      expect(d.format('WW'), equals('Tu'));
    });

    test('WWW', () {
      expect(d.format('WWW'), equals('Tue'));
    });

    test('WWWW', () {
      expect(d.format('WWWW'), equals('Tuesday'));
    });

    test('H', () {
      expect(d.format('H'), equals('10'));
    });

    test('HH', () {
      expect(d.format('HH'), equals('10'));
    });

    test('h', () {
      expect(d.format('h'), equals('10'));
    });

    test('hh', () {
      expect(d.format('hh'), equals('10'));
    });

    test('m', () {
      expect(d.format('m'), equals('30'));
    });

    test('mm', () {
      expect(d.format('mm'), equals('30'));
    });

    test('s', () {
      expect(d.format('s'), equals('30'));
    });

    test('ss', () {
      expect(d.format('ss'), equals('30'));
    });

    test('SSS', () {
      expect(d.format('SSS'), equals('000'));
    });

    test('A', () {
      expect(d.format('A'), equals('AM'));
    });

    test('a', () {
      expect(d.format('a'), equals('am'));
    });

    test('put all together', () {
      expect(d.format('[Today is] YYYY MM DD HH mm ss A'),
          'Today is 2019 04 30 10 30 30 AM');
      expect(d.format('[Today is] YYYY-MM-DD-HH-mm-ss:A'),
          'Today is 2019-04-30-10-30-30:AM');
    });
  });
}
