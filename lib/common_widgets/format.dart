import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Format {
  static String hours(double hours) {
    final hoursNotNagitive = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNagitive);
    return '${formatted}h';
  }

  static String date(DateTime date) => DateFormat.yMMMd().format(date);

  static String dateTime(DateTime date) {
    final fomatedDate = Format.date(date);
    final formatedTime = DateFormat.Hm().format(date);
    return '$fomatedDate   -   $formatedTime';
  }

  static String dayOfWeek(DateTime date) => DateFormat.E().format(date);

  static String time(DateTime date, BuildContext context) =>
      TimeOfDay.fromDateTime(date).format(context);

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }
}
