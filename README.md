# date_extension 时间类扩展

## TODO

- [ ] Time from now(this need translate)

## question

1. DateTime.parse('2021-05-01T10:30:30.000Z').diff("2021-04-30T10:30:30.000Z") why is 0+1/365

dayjs is 0+1/30/12 see [dayjs](https://github.com/iamkun/dayjs/issues/1971)

in my opinion, 2021-03-01 比 2020-02-01 多了 1年零28天 ，可以拆解为 2021-02-01比2020-02-01多了1年，加上2021-03-01比2021-02-01多了28天。

<br />
<br />
<br />

<p align="center">
  <img src="https://github.com/g1eny0ung/day.dart/blob/master/day.dart.png?raw=true" alt="day.dart logo" />
</p>
<p align="center">A date library <a href="https://github.com/iamkun/dayjs/">Day.js</a> in dart.</p>

<p align="center">
  <img alt="Pub" src="https://img.shields.io/pub/v/day.svg">
  <img src="https://travis-ci.org/dayjs/day.dart.svg?branch=master" alt="Travis CI" />
  <img alt="GitHub" src="https://img.shields.io/github/license/g1eny0ung/day.dart.svg">
</p>

> Day.dart is inspired by Day.js. Write with nearly the same API. Build on the top of the powerful **DateTime** class.
>
> ~~Important: Day.dart use the **extension** syntax to implement plugins system. So the dart version must `>= 2.7.0`.~~
>
> As Day.dart already migrated to null safety. So the minimum dart version is `2.12.0`.

## Features

- 🕒 Nearly the same API as Day.js
- 💪 Contains Immutable Methods
- 🔗 Chainable
- 👀 Useful formatting method
- ⚙️ Plugin system
- 🌐 I18n support

### Documentation

- 📚 [API](https://github.com/cn1001wang/date_extension/blob/main/API.md)

- ⚙️ [Plugins](https://github.com/cn1001wang/date_extension/blob/main/PLUGINS.md)

- 🌐 [I18n](https://github.com/cn1001wang/date_extension/blob/main/I18N.md)

## License

Distributed under the MIT License.
