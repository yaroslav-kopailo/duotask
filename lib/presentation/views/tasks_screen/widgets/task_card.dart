import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:duotask/presentation/base_widgets/icons/circle_svg_icon.dart';
import 'package:duotask/presentation/views/tasks_screen/widgets/task_status_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  static final _timeFormat = DateFormat('h:mm a');

  final String title;
  final DateTime startTime;
  final DateTime finishTime;
  final TaskStatusType status;

  const TaskCard({
    Key? key,
    required this.title,
    required this.startTime,
    required this.finishTime,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startTimeString = _timeFormat.format(startTime);
    final finishTimeString = _timeFormat.format(finishTime);

    return Container(
      padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 8),
      decoration: BoxDecoration(
        color: themeOf(context).surfaceContainerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (status == TaskStatusType.done)
                      CircleSvgIcon(
                        size: 16,
                        backgroundColor: themeOf(context).onSurfaceColor,
                        foregroundColor: themeOf(context).surfaceContainerColor,
                        iconPath: Assets.check,
                      ),
                    if (status == TaskStatusType.done)
                      const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        title,
                        style: themeOf(context).subtitle2OnSurfaceStyle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '$startTimeString - $finishTimeString',
                  style: themeOf(context).body2OnSurfaceStyleWithOpacity(0.7),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TaskStatusLabel(status: status),
        ],
      ),
    );
  }
}
