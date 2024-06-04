import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/presentation/base_widgets/bottom_sheets/bottom_sheet_body.dart';
import 'package:duotask/presentation/base_widgets/buttons/custom_elevated_button.dart';
import 'package:duotask/presentation/base_widgets/buttons/svg_icon_button.dart';
import 'package:duotask/presentation/base_widgets/fields/date_time_input_field.dart';
import 'package:duotask/presentation/base_widgets/fields/styled_value_input_text_field.dart';
import 'package:duotask/presentation/view_models/task_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class CreateTaskBottomSheet extends StatelessWidget {
  const CreateTaskBottomSheet(
      {super.key,
      required TaskListViewModel taskListViewModel,
      required this.onCreateTask})
      : _taskListViewModel = taskListViewModel;

  final TaskListViewModel _taskListViewModel;

  final VoidCallback onCreateTask;

  @override
  Widget build(BuildContext context) {
    final newTaskViewModel = _taskListViewModel.newTask.value;

    void closeBottomSheet() => Navigator.of(context).pop();

    return MultiReactionBuilder(
      builders: [
        ReactionBuilder(
          builder: (context) {
            return reaction(
              (_) => _taskListViewModel
                  .tasksListController.requestAddItem.status.value,
              (status) {
                if (status == FutureStatus.rejected ||
                    status == FutureStatus.fulfilled) {
                  closeBottomSheet();
                }
              },
            );
          },
        ),
      ],
      child: BottomSheetBody(
        borderRadiusValue: 10,
        contentPadding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                SvgIconButton(
                  iconPath: Assets.close,
                  onPressed: closeBottomSheet,
                  iconSize: 24,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Create a new task',
                style: themeOf(context).h5OnSurfaceStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Observer(builder: (context) {
              return StyledValueInputTextField(
                hintText: 'Task name',
                onInput: newTaskViewModel.setTaskName,
                isFieldFailed:
                    _taskListViewModel.newTask.value.isTaskNameFailed.value,
                failedDescription:
                    _taskListViewModel.newTask.value.taskNameFailedText.value,
              );
            }),
            const SizedBox(height: 12),
            Observer(builder: (context) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DateTimeInputField(
                      labelDateText: 'Start date',
                      labelTimeText: 'Start time',
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initTime: newTaskViewModel.startDateTime.value,
                      minTime: newTaskViewModel.minStartDateTime,
                      onSelectDateTime: newTaskViewModel.setStartDateTime,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 12),
            Observer(builder: (context) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DateTimeInputField(
                      labelDateText: 'End date',
                      labelTimeText: 'End time',
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initTime: newTaskViewModel.endDateTime.value,
                      onSelectDateTime: newTaskViewModel.setEndDateTime,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
            Observer(builder: (context) {
              return CElevatedButton.primaryActionLarge(
                context: context,
                isLoading: _taskListViewModel
                    .tasksListController.requestAddItem.isPending.value,
                onPressed: onCreateTask,
                height: 56,
                child: Text(
                  'CREATE NEW TASK',
                  style: themeOf(context).buttonOnPrimaryActionStyle,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
