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

  test("format", () {
    var date = DateTime(2022, 6, 9, 10, 50, 20);
    expect(date.format("YYYY-MM-DD HH:mm:ss"), "2022-06-09 10:50:20");
  });

  test("diff", () {
    final date1 = DateTime.parse('2019-01-25');
    final date2 = DateTime.parse('2018-06-05');

    expect(date1.diff2(date2), 20217600000); //  默认单位是毫秒
    expect(date1.diff('2018-06-05', 'month'), 7);
    expect(date1.diff('2018-06-05', 'month', true), 7.645161290322581);
  });
}
