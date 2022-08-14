# datetime_extension 时间类扩展

## TODO

- [ ] Time from now(this need translate)

## Features

- 🕒 Nearly the same API as Day.js
- 💪 Contains Immutable Methods
- 🔗 Chainable
- 👀 Useful formatting method
- ⚙️ Plugin system
- 🌐 I18n support

### Documentation

- 📚 [API](https://github.com/cn1001wang/datetime_extension/blob/main/doc/API.md)

- 🌐 [I18n](https://github.com/cn1001wang/datetime_extension/blob/main/doc/I18N.md)

## API

```dart
final d1=DateTime.parse("2020-01-01");
final d2=DateTime.parse("2022-01-01");
```

API | Usage | Result
--- | --- | ---|
clone | d1.clone() | 复制一个DateTime
addTime | DateTime.now().addTime(1,"d")|  加一天
subtractTime | DateTime.now().subtractTime(1,"d") |  减一天
startOf | DateTime.now().startOf('year') |  返回今年一月一日的复制的 DateTime 对象
endOf | DateTime.now().endOf('year') |  返回今年12月31日的复制的 DateTime 对象
format | DateTime.parse('2019-01-25').format('DD/MM/YYYY') |  '25/01/2019'
isAfter | d2.isAfter(d1) |  true
isAfterUnit  | d2.isAfterUnit(d1,"year") |  false
isBefore | d2.isBefore(d1) |  false
isBeforeUnit  | d2.isBeforeUnit(d1,"year") |  true
isSame  | d2.isSame(d1) |  false
isSameUnit  | d2.isSameUnit(d1,"M") |  false
isSameOrAfter  | d2.isSameOrAfter(d1,"M") |  false
isSameOrBefore  | d2.isSameOrBefore(d1,"M") |  false
isBetween  | DateTime.parse('2018-01-01').isBetween(DateTime.parse('2017-12-31'), DateTime.parse('2018-01-02')) |  true

## License

Distributed under the MIT License.

## question

1. DateTime.parse('2021-05-01T10:30:30.000Z').diff("2021-04-30T10:30:30.000Z") why is 0+1/365

dayjs is 0+1/30/12 see [dayjs](https://github.com/iamkun/dayjs/issues/1971)

in my opinion, 2021-03-01 is one year and 28 days more than 2020-02-01. It can be disassembled into 2021-02-01 which is one year more than 2020-02-01. In addition, 2021-03-01 is 28 days more than 2021-02-01

在我看来, 2021-03-01 比 2020-02-01 多了 1年零28天 ，可以拆解为 2021-02-01比2020-02-01多了1年，加上2021-03-01比2021-02-01多了28天。
