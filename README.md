# date_extension 时间类扩展

## TODO

- [ ] Time from now(this need translate)
- [ ]

## question

1. DateTime.parse('2021-05-01T10:30:30.000Z').diff("2021-04-30T10:30:30.000Z") why is 0+1/365

dayjs is 0+1/30/12 see [dayjs](https://github.com/iamkun/dayjs/issues/1971)

in my opinion, 2021-03-01 比 2020-02-01 多了 1年零28天 ，可以拆解为 2021-02-01比2020-02-01多了1年，加上2021-03-01比2021-02-01多了28天。
