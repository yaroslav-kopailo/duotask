import 'package:duotask/core/helper/date_ext.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class DateTimeInputField extends StatelessWidget {
  const DateTimeInputField({
    super.key,
    required this.labelDateText,
    required this.labelTimeText,
    required this.mode,
    this.minTime,
    this.maxTime,
    required this.onSelectDateTime,
    this.initTime,
  });

  final String labelDateText;
  final String labelTimeText;

  final CupertinoDatePickerMode mode;

  final DateTime? initTime;

  final DateTime? minTime;

  final DateTime? maxTime;

  final Function(DateTime) onSelectDateTime;

  @override
  Widget build(BuildContext context) {
    return TimePickerSpinnerPopUp(
      mode: mode,
      barrierColor: Colors.black12,
      minTime: minTime,
      maxTime: maxTime,
      initTime: initTime,
      radius: 10,
      paddingHorizontalOverlay: 4,
      textStyle: themeOf(context).body1OnSurfaceStyle,
      onChange: onSelectDateTime,
      timeWidgetBuilder: (dateTime) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: _FormattedDateTimeContainer(
                labelText: labelDateText,
                mode: DateTimeContainerMode.date,
                dateTime: dateTime,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: _FormattedDateTimeContainer(
                labelText: labelTimeText,
                mode: DateTimeContainerMode.time,
                dateTime: dateTime,
              ),
            ),
          ],
        );
      },
    );
  }
}

enum DateTimeContainerMode { time, date }

class _FormattedDateTimeContainer extends StatelessWidget {
  final DateTime dateTime;

  final String labelText;

  final DateTimeContainerMode mode;

  _FormattedDateTimeContainer({
    super.key,
    required this.dateTime,
    required this.mode,
    required this.labelText,
  });

  String get formattedDateTimeText => mode == DateTimeContainerMode.date
      ? dateTime.datePickerFormat
      : dateTime.timePickerFormat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: themeOf(context).subtitle2OnSurfaceStyle,
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: themeOf(context).outlineColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            formattedDateTimeText,
            textAlign: mode == DateTimeContainerMode.time
                ? TextAlign.center
                : TextAlign.start,
            style: themeOf(context).body1OnSurfaceStyle,
          ),
        ),
      ],
    );
  }
}
