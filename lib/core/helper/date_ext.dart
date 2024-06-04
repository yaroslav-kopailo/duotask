import 'package:intl/intl.dart';

extension DateFormatExt on DateTime {
  static final _datePickerFormat = DateFormat('EEEE, d MMM');
  static final _timePickerFormat = DateFormat('HH:mm');

  String get datePickerFormat => _datePickerFormat.format(this);

  String get timePickerFormat => _timePickerFormat.format(this);
}
