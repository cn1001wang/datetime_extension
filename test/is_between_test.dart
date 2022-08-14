import 'package:flutter_test/flutter_test.dart';
import 'package:datetime_extension/datetime_extension.dart';

void main() {
  group('isBetween easy', () {
    test('bounds can be swapped', () {
      expect(
          DateTime.parse('2018-01-01').isBetween(
              DateTime.parse('2017-12-31'), DateTime.parse('2018-01-02')),
          true);
      expect(
          DateTime.parse('2018-01-01').isBetween(
              DateTime.parse('2018-01-02'), DateTime.parse('2017-12-31')),
          true);
    });

    test('bounds can be swapped with inclusivity', () {
      expect(
          DateTime.parse('2018-01-01').isBetween(DateTime.parse('2017-12-31'),
              DateTime.parse('2018-01-01'), null, '[]'),
          true);
      expect(
          DateTime.parse('2018-01-01').isBetween(DateTime.parse('2018-01-01'),
              DateTime.parse('2017-12-31'), null, '[]'),
          true);
    });
  });

  group("isBetween", () {
    test('is between without units', () {
      final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
      final mCopy = m.clone();

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'year is later');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2013, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'year is earlier');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10)),
          true,
          reason: 'year is between');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'month is later');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 5, 2, 3, 4, 5, 10)),
          false,
          reason: 'month is earlier');

      expect(
          m.isBetween(DateTime(2011, 2, 2, 3, 4, 5, 10),
              DateTime(2011, 4, 2, 3, 4, 5, 10)),
          true,
          reason: 'month is between');

      expect(
          m.isBetween(DateTime(2011, 3, 1, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'day is later');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 4, 3, 4, 5, 10)),
          false,
          reason: 'day is earlier');

      expect(
          m.isBetween(DateTime(2011, 3, 1, 3, 4, 5, 10),
              DateTime(2011, 3, 3, 3, 4, 5, 10)),
          true,
          reason: 'day is between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 1, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'hour is later');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 5, 4, 5, 10)),
          false,
          reason: 'hour is earlier');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 2, 4, 5, 10),
              DateTime(2011, 3, 2, 4, 4, 5, 10)),
          true,
          reason: 'hour is between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 6, 5, 10)),
          false,
          reason: 'minute is later');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 2, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'minute is earlier');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 3, 5, 10),
              DateTime(2011, 3, 2, 3, 5, 5, 10)),
          true,
          reason: 'minute is between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 7, 10)),
          false,
          reason: 'second is later');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 3, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'second is earlier');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 4, 10),
              DateTime(2011, 3, 2, 3, 4, 6, 10)),
          true,
          reason: 'second is between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 12)),
          false,
          reason: 'millisecond is later');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 8),
              DateTime(2011, 3, 2, 3, 4, 5, 10)),
          false,
          reason: 'millisecond is earlier');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 9),
              DateTime(2011, 3, 2, 3, 4, 5, 11)),
          true,
          reason: 'millisecond is between');

      expect(m.isBetween(m, m), false,
          reason: 'moments are not between themselves');

      expect(m.isSame(mCopy), true,
          reason: 'isBetween second should not change moment');
    });

    test('is between year', () {
      final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
      final mCopy = m.clone();

      expect(
          m.isBetween(DateTime(2011, 5, 6, 7, 8, 9, 10),
              DateTime(2011, 5, 6, 7, 8, 9, 10), 'year'),
          false,
          reason: 'year match');

      expect(
          m.isBetween(DateTime(2010, 5, 6, 7, 8, 9, 10),
              DateTime(2012, 5, 6, 7, 8, 9, 10), 'years'),
          true,
          reason: 'plural should work');

      expect(
          m.isBetween(DateTime(2010, 5, 6, 7, 8, 9, 10),
              DateTime(2012, 5, 6, 7, 8, 9, 10), 'year'),
          true,
          reason: 'year is between');

      expect(
          m.isBetween(DateTime(2011, 5, 6, 7, 8, 9, 10),
              DateTime(2013, 5, 6, 7, 8, 9, 10), 'year'),
          false,
          reason: 'year is earlier');

      expect(
          m.isBetween(DateTime(2010, 5, 6, 7, 8, 9, 10),
              DateTime(2011, 5, 6, 7, 8, 9, 10), 'year'),
          false,
          reason: 'year is later');

      expect(m.isBetween(m, m, 'year'), false,
          reason: 'same moments are not between the same year');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween year should not change moment');
    });

    test('is between month', () {
      final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
      final mCopy = m.clone();

      expect(
          m.isBetween(DateTime(2011, 1, 6, 7, 8, 9, 10),
              DateTime(2011, 1, 6, 7, 8, 9, 10), 'month'),
          false,
          reason: 'month match');

      expect(
          m.isBetween(DateTime(2011, 0, 6, 7, 8, 9, 10),
              DateTime(2011, 2, 6, 7, 8, 9, 10), 'months'),
          true,
          reason: 'plural should work');

      expect(
          m.isBetween(DateTime(2011, 0, 31, 23, 59, 59, 999),
              DateTime(2011, 2, 1, 0, 0, 0, 0), 'month'),
          true,
          reason: 'month is between');

      expect(
          m.isBetween(DateTime(2011, 1, 6, 7, 8, 9, 10),
              DateTime(2011, 2, 6, 7, 8, 9, 10), 'month'),
          false,
          reason: 'month is earlier');

      expect(
          m.isBetween(DateTime(2011, 11, 6, 7, 8, 9, 10),
              DateTime(2011, 1, 6, 7, 8, 9, 10), 'month'),
          false,
          reason: 'month is later');

      expect(m.isBetween(m, m, 'month'), false,
          reason: 'same moments are not between the same month');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween month should not change moment');
    });

    test('is between day', () {
      final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
      final mCopy = m.clone();

      expect(
          m.isBetween(DateTime(2011, 1, 2, 7, 8, 9, 10),
              DateTime(2011, 1, 2, 7, 8, 9, 10), 'day'),
          false,
          reason: 'day match');

      expect(
          m.isBetween(DateTime(2011, 1, 1, 7, 8, 9, 10),
              DateTime(2011, 1, 3, 7, 8, 9, 10), 'days'),
          true,
          reason: 'plural should work');

      expect(
          m.isBetween(DateTime(2011, 1, 1, 7, 8, 9, 10),
              DateTime(2011, 1, 3, 7, 8, 9, 10), 'day'),
          true,
          reason: 'day is between');

      expect(
          m.isBetween(DateTime(2011, 1, 2, 7, 8, 9, 10),
              DateTime(2011, 1, 4, 7, 8, 9, 10), 'day'),
          false,
          reason: 'day is earlier');

      expect(
          m.isBetween(DateTime(2011, 1, 1, 7, 8, 9, 10),
              DateTime(2011, 1, 2, 7, 8, 9, 10), 'day'),
          false,
          reason: 'day is later');

      expect(m.isBetween(m, m, 'day'), false,
          reason: 'same moments are not between the same day');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween day should not change moment');
    });

    test('is between hour', () {
      final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
      final mCopy = m.clone();
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 5, 9, 10),
              DateTime(2011, 1, 2, 3, 9, 9, 10), 'hour'),
          false,
          reason: 'hour match');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 1, 59, 59, 999),
              DateTime(2011, 1, 2, 4, 0, 0, 0), 'hours'),
          true,
          reason: 'plural should work');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 2, 59, 59, 999),
              DateTime(2011, 1, 2, 4, 0, 0, 0), 'hour'),
          true,
          reason: 'hour is between');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 7, 8, 9, 10),
              DateTime(2011, 1, 2, 7, 8, 9, 10), 'hour'),
          false,
          reason: 'hour is earlier');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 7, 8, 9, 10),
              DateTime(2011, 1, 2, 7, 8, 9, 10), 'hour'),
          false,
          reason: 'hour is later');
      expect(m.isBetween(m, m, 'hour'), false,
          reason: 'same moments are not between the same hour');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween hour should not change moment');
    });

    test('is between minute', () {
      final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
      final mCopy = m.clone();
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 9, 10),
              DateTime(2011, 1, 2, 3, 4, 9, 10), 'minute'),
          false,
          reason: 'minute match');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 3, 9, 10),
              DateTime(2011, 1, 2, 3, 5, 9, 10), 'minutes'),
          true,
          reason: 'plural should work');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 3, 59, 999),
              DateTime(2011, 1, 2, 3, 5, 0, 0), 'minute'),
          true,
          reason: 'minute is between');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 5, 0, 0),
              DateTime(2011, 1, 2, 3, 8, 9, 10), 'minute'),
          false,
          reason: 'minute is earlier');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 2, 9, 10),
              DateTime(2011, 1, 2, 3, 3, 59, 999), 'minute'),
          false,
          reason: 'minute is later');
      expect(m.isBetween(m, m, 'minute'), false,
          reason: 'same moments are not between the same minute');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween minute should not change moment');
    });

    test('is between second', () {
      final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
      final mCopy = m.clone();
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 5, 10),
              DateTime(2011, 1, 2, 3, 4, 5, 10), 'second'),
          false,
          reason: 'second match');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 4, 10),
              DateTime(2011, 1, 2, 3, 4, 6, 10), 'seconds'),
          true,
          reason: 'plural should work');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 4, 999),
              DateTime(2011, 1, 2, 3, 4, 6, 0), 'second'),
          true,
          reason: 'second is between');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 6, 0),
              DateTime(2011, 1, 2, 3, 4, 7, 10), 'second'),
          false,
          reason: 'second is earlier');
      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 3, 10),
              DateTime(2011, 1, 2, 3, 4, 4, 999), 'second'),
          false,
          reason: 'second is later');
      expect(m.isBetween(m, m, 'second'), false,
          reason: 'same moments are not between the same second');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween second should not change moment');
    });

    test('is between millisecond', () {
      final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
      final mCopy = m.clone();

      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 5, 6),
              DateTime(2011, 1, 2, 3, 4, 5, 6), 'millisecond'),
          false,
          reason: 'millisecond match');

      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 5, 5),
              DateTime(2011, 1, 2, 3, 4, 5, 7), 'milliseconds'),
          true,
          reason: 'plural should work');

      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 5, 5),
              DateTime(2011, 1, 2, 3, 4, 5, 7), 'millisecond'),
          true,
          reason: 'millisecond is between');

      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 5, 7),
              DateTime(2011, 1, 2, 3, 4, 5, 10), 'millisecond'),
          false,
          reason: 'millisecond is earlier');

      expect(
          m.isBetween(DateTime(2011, 1, 2, 3, 4, 5, 4),
              DateTime(2011, 1, 2, 3, 4, 5, 6), 'millisecond'),
          false,
          reason: 'millisecond is later');

      expect(m.isBetween(m, m, 'millisecond'), false,
          reason: 'same moments are not between the same millisecond');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween millisecond should not change moment');
    });

    test('is between without units inclusivity', () {
      final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
      final mCopy = m.clone();

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '()'),
          false,
          reason: 'start and end are excluded, start is equal to dayjs');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '()'),
          false,
          reason: 'start and end are excluded, end is equal to dayjs');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '()'),
          true,
          reason: 'start and end are excluded, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), null, '()'),
          false,
          reason: 'start and end are excluded, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '()'),
          false,
          reason:
              'start and end are excluded, should fail on same start/end date.');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '(]'),
          false,
          reason:
              'start is excluded and end is included should fail on same start date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '(]'),
          true,
          reason:
              'start is excluded and end is included should succeed on end date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '(]'),
          true,
          reason: 'start is excluded and end is included, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), null, '(]'),
          false,
          reason: 'start is excluded and end is included, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '(]'),
          false,
          reason:
              'start is excluded and end is included, should fail on same start/end date.');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '[)'),
          true,
          reason:
              'start is included and end is excluded should succeed on same start date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '[)'),
          false,
          reason:
              'start is included and end is excluded should fail on same end date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '[)'),
          true,
          reason: 'start is included and end is excluded, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), null, '[)'),
          false,
          reason: 'start is included and end is excluded, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '[)'),
          false,
          reason:
              'start is included and end is excluded, should fail on same end and start date');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '[]'),
          true,
          reason: 'start and end inclusive should succeed on same start date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '[]'),
          true,
          reason: 'start and end inclusive should succeed on same end date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), null, '[]'),
          true,
          reason: 'start and end inclusive, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), null, '[]'),
          false,
          reason: 'start and end inclusive, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), null, '[]'),
          true,
          reason:
              'start and end inclusive, should handle same end and start date');
      expect(m.isSame(mCopy), true,
          reason: 'isBetween millisecond should not change moment');
    });

    test('is between milliseconds inclusivity', () {
      final m = DateTime(2011, 3, 2, 3, 4, 5, 10);
      final mCopy = m.clone();

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds'),
          true,
          reason: 'options, no inclusive');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '()'),
          false,
          reason: 'start and end are excluded, start is equal to dayjs');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '()'),
          false,
          reason: 'start and end are excluded, end is equal to dayjs');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '()'),
          true,
          reason: 'start and end are excluded, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), 'milliseconds', '()'),
          false,
          reason: 'start and end are excluded, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '()'),
          false,
          reason:
              'start and end are excluded, should fail on same start/end date.');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '(]'),
          false,
          reason:
              'start is excluded and end is included should fail on same start date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '(]'),
          true,
          reason:
              'start is excluded and end is included should succeed on end date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '(]'),
          true,
          reason: 'start is excluded and end is included, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), 'milliseconds', '(]'),
          false,
          reason: 'start is excluded and end is included, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '(]'),
          false,
          reason:
              'start is excluded and end is included, should fail on same start/end date.');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '[)'),
          true,
          reason:
              'start is included and end is excluded should succeed on same start date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '[)'),
          false,
          reason:
              'start is included and end is excluded should fail on same end date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '[)'),
          true,
          reason: 'start is included and end is excluded, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), 'milliseconds', '[)'),
          false,
          reason: 'start is included and end is excluded, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '[)'),
          false,
          reason:
              'start is included and end is excluded, should fail on same end and start date');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '[]'),
          true,
          reason: 'start and end inclusive should succeed on same start date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '[]'),
          true,
          reason: 'start and end inclusive should succeed on same end date');

      expect(
          m.isBetween(DateTime(2010, 3, 2, 3, 4, 5, 10),
              DateTime(2012, 3, 2, 3, 4, 5, 10), 'milliseconds', '[]'),
          true,
          reason: 'start and end inclusive, is between');

      expect(
          m.isBetween(DateTime(2009, 3, 2, 3, 4, 5, 10),
              DateTime(2010, 3, 2, 3, 4, 5, 10), 'milliseconds', '[]'),
          false,
          reason: 'start and end inclusive, is not between');

      expect(
          m.isBetween(DateTime(2011, 3, 2, 3, 4, 5, 10),
              DateTime(2011, 3, 2, 3, 4, 5, 10), 'milliseconds', '[]'),
          true,
          reason:
              'start and end inclusive, should handle same end and start date');

      expect(m.isSame(mCopy), true,
          reason: 'isBetween second should not change moment');
    });
  });
}
