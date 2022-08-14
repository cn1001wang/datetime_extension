# API

## usage

```dart
import 'package:datetime_extension/datetime_extension.dart';
```

## 解析

### 克隆

```dart
DateTime.now().clone()
```

## 支持的单位列表

各个传入的单位对大小写不敏感，支持缩写和复数。
|  单位   | 缩写  | 详情 |
|  ----  | ----  | ---|
| year  | y | 今年一月1日上午 00:00 |
| quarter  | Q | 本季度第一个月1日上午 00:00 ( 依赖 QuarterOfYear 插件 ) |
| month  | M | 本月1日上午 00:00 |
| week  | w | 本周的第一天上午 00:00 (取决于国际化设置) |
| isoWeek  |  | 本周的第一天上午 00:00 (根据 ISO 8601) ( 依赖 IsoWeek 插件 ) |
| date  | D | 当天 00:00 |
| day  | d | 当天 00:00 |
| hour  | h | 当前时间，0 分、0 秒、0 毫秒 |
| minute  | m | 当前时间，0 秒、0 毫秒 |
| second  | s | 当前时间，0 毫秒 |

## Manipulate 操作

### Add

返回增加一定时间的复制的DateTime对象

```dart
DateTime.now().add(Duration(days: 1))
// or
DateTime.now().addTime(1,"d"); // Get the current time until tomorrow
// or
DateTimeExtension(DateTime.now()).add(1,"d");
```

### Subtract

返回减少一定时间的复制的DateTime对象

```dart
DateTime.now().subtract(Duration(days: 1))
// or
DateTime.now().subtractTime(1,"d"); // Get the current time until yesterday
// or
DateTimeExtension(DateTime.now()).subtract(1,"d");
```

### Start of Time

返回复制的 DateTime 对象，并设置到一个时间的开始。

```dart
DateTime.now().startOf('year')
```

### End of Time

返回复制的 DateTime 对象，并设置到一个时间的结束。

```dart
DateTime.now().endOf('year')
```

## Display

### Format

根据传入的占位符返回格式化后的日期。

将字符放在方括号中，即可原样返回而不被格式化替换 (例如， [MM])。

```dart
final d=DateTime.now();
// 默认返回的是 ISO8601 格式字符串 '2020-04-02T08:02:17-05:00'
d.format()==d.toIso8601String();

DateTime.parse('2019-01-25').format('[YYYYescape] YYYY-MM-DDTHH:mm:ssZ[Z]')
// 'YYYYescape 2019-01-25T00:00:00-02:00Z'

DateTime.parse('2019-01-25').format('DD/MM/YYYY') // '25/01/2019'
```

| 占位符  | 输出 | 详情 |
|------|-------------|-------------|
| YY   | 18 | 两位数的年份 |
| YYYY | 2018 | 四位数的年份 |
| M    | 1-12 | 月份，从 1 开始 |
| MM   | 01-12 | 月份，两位数 |
| MMM  | Jan-Dec | 缩写的月份名称 |
| MMMM | January-December | 完整的月份名称 |
| D    | 1-31 | 月份里的一天 |
| DD   | 01-31 | 月份里的一天，两位数 |
| d    | 0-6 | 一周中的一天，星期天是 0 |
| dd   | Su-Sa | 最简写的星期几 |
| ddd  | Sun-Sat | 简写的星期几 |
| dddd | Sunday-Saturday  | 星期几 |
| H    | 0-23 | 小时 |
| HH   | 00-23 | 小时，两位数 |
| h    | 1-12 | 小时, 12 小时制 |
| hh   | 01-12 | 小时, 12 小时制, 两位数 |
| m    | 0-59 | 分钟 |
| mm   | 00-59 | 分钟，两位数 |
| s    | 0-59 | 秒 |
| ss   | 00-59 | 秒 两位数 |
| SSS  | 000-999 | 毫秒 三位数 |
| Z    | +05:00 | UTC 的偏移量，±HH:mm |
| ZZ   | +0500 | UTC 的偏移量，±HHmm |
| A    | AM PM | |
| a    | am pm | |

### Difference

返回指定单位下两个日期时间之间的差异。

要获得以毫秒为单位的差异，请使用 DateTime#diff。

```dart
const date1 = DateTime.parse('2019-01-25')
const date2 = DateTime.parse('2018-06-05')
date1.diff(date2) // 20217600000 默认单位是毫秒
date1.diff2('2018-06-05') // 20217600000 默认单位是毫秒
```

要获取其他单位下的差异，则在第二个参数传入相应的单位。

```dart
const date1 = DateTime.parse('2019-01-25')
date1.diff2('2018-06-05', 'month') // 7
```

默认情况下 dayjs#diff 会将结果进位成整数。 如果要得到一个浮点数，将 true 作为第三个参数传入。

```dart
    final d2 = DateTime.parse('2019-02-01T10:30:30.000Z');

    d1.diff2(d2, DateUnit.M);//2 
    d2.diff2(d1, 'M');//-2
    d1.diff2(d2, DateUnit.M, true);//2 + 29 / 30
```

## 查询

### isBefore

isBefore是dart本身提供的功能

```dart
final d1=DateTime.parse("2020-01-01");
final d2=DateTime.parse("2022-01-01");
d1.isBefore(d2);//true
// <与>为DateTimeExtension提供的功能，Dart提供了==
d1<d2;

```

### isBeforeUnit

isBeforeUnit是针对需要只比较年份或月份的情况; 第二个参数取值范围参见开头

```dart
final d1=DateTime.parse("2020-01-01");
final d2=DateTime.parse("2022-01-01");
d1.isBeforeUnit(d2,"year");//true
```

### isAfter

isAfter是dart本身提供的功能

```dart
final d1=DateTime.parse("2020-01-01");
final d2=DateTime.parse("2022-01-01");
d2.isAfter(d1); // true
// <与>为DateTimeExtension提供的功能，Dart提供了==
d2>d1;

```

### isAfterUnit

isAfterUnit是针对需要只比较年份或月份的情况; 第二个参数取值范围参见开头

```dart
final d1=DateTime.parse("2020-01-01");
final d2=DateTime.parse("2020-04-01");
d2.isAfterUnit(d1,"year");//false
d2.isAfterUnit(d1,"month");//true
```

### isSame

isSame 是 对于isAtSameMomentAs的别名

### isSameUnit

```dart
final m = DateTime(2011, 1, 2, 3, 4, 5, 6);
m.isSameUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'year');//true
m.isSameUnit(DateTime(2011, 5, 6, 7, 8, 9, 10), 'month');//false
```

### isBetween

```dart
DateTime.parse('2018-01-01').isBetween(DateTime.parse('2017-12-31'), DateTime.parse('2018-01-02'));//true
DateTime.parse('2018-01-01').isBetween(DateTime.parse('2018-01-02'), DateTime.parse('2017-12-31'));//true
```
