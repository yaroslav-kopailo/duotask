import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:flutter/material.dart';

class TaskStatusLabel extends StatelessWidget {
  final TaskStatusType status;

  const TaskStatusLabel({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    final String text = status.name;

    switch (status) {
      case TaskStatusType.done:
        backgroundColor = themeOf(context).greenAccentColor;
        break;
      case TaskStatusType.inProgress:
        backgroundColor = themeOf(context).orangeAccentColor;
        break;
      case TaskStatusType.toDo:
        backgroundColor = themeOf(context).blueAccentColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        style: themeOf(context).caption1OnAccentStyle,
      ),
    );
  }
}
