import 'dart:ui';

import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:duotask/presentation/base_widgets/bottom_sheets/confirmation_delete_bottom_sheet.dart';
import 'package:duotask/presentation/base_widgets/buttons/outlined_svg_icon_button.dart';
import 'package:duotask/presentation/base_widgets/icons/svg_icon.dart';
import 'package:duotask/presentation/view_models/task_list_view_model.dart';
import 'package:duotask/presentation/views/root_screen/root_screen.dart';
import 'package:duotask/presentation/views/tasks_screen/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class TasksReorderableList extends StatefulWidget {
  const TasksReorderableList({
    super.key,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.scrollToEndAnimationDuration = const Duration(milliseconds: 250),
  });

  final Duration insertAnimationDuration;
  final Duration scrollToEndAnimationDuration;

  @override
  State<TasksReorderableList> createState() => _TasksReorderableListState();
}

class _TasksReorderableListState extends State<TasksReorderableList> {
  final _scrollController = ScrollController();
  late final _taskListViewModel =
      Provider.of<TaskListViewModel>(context, listen: false);
  final List<Task> _tasks = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTasks(_taskListViewModel.filteredTasks.value);
    _scrollToEnd(withAnimation: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateTasks(List<Task> updatedTasks) {
    setState(() {
      _tasks.clear();
      _tasks.addAll(updatedTasks);
    });
  }

  void _onReorderTask(int oldIndex, int newIndex) {
    if (!mounted) return;
    final taskListViewModel =
        Provider.of<TaskListViewModel>(context, listen: false);

    final updatedIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;

    taskListViewModel.reorderTask(
      task: _tasks[oldIndex],
      previousTask: updatedIndex < oldIndex ? _tasks[updatedIndex] : null,
      nextTask: updatedIndex > oldIndex ? _tasks[updatedIndex] : null,
    );
  }

  Future<void> _onRemoveTask(
      {required Task task, required Function(bool) closeItemHandler}) async {
    await RootScreenState.of(context).showBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        onDismiss: () {
          if (mounted) closeItemHandler(false);
        },
        bottomSheet: ConfirmationDeleteBottomSheet(
          onConfirm: () async {
            if (mounted) {
              await closeItemHandler(true);
              _taskListViewModel.removeTask(task);
            }
          },
          onCancel: () {
            if (mounted) closeItemHandler(false);
          },
        ));
  }

  void _scrollToEnd({bool withAnimation = false}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!_scrollController.hasClients || !mounted) return;

        if (_scrollController.position.maxScrollExtent > 0) {
          _initialScrollToEnd(withAnimation: withAnimation);
        }
      },
    );
  }

  void _initialScrollToEnd({bool withAnimation = false}) async {
    await Future.delayed(widget.insertAnimationDuration);

    if (!_scrollController.hasClients || !mounted) return;

    if (_scrollController.offset < _scrollController.position.maxScrollExtent) {
      if (widget.scrollToEndAnimationDuration == Duration.zero ||
          !withAnimation) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      } else {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: widget.scrollToEndAnimationDuration,
          curve: Curves.linearToEaseOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiReactionBuilder(
      builders: [
        ReactionBuilder(
          builder: (context) {
            return reaction(
              (_) => _taskListViewModel.filteredTasks.value,
              _updateTasks,
            );
          },
        ),
        ReactionBuilder(
          builder: (context) {
            return reaction(
              (_) => _taskListViewModel.selectedTaskStatusTypeName.value,
              (_) => _scrollToEnd(withAnimation: true),
            );
          },
        ),
        ReactionBuilder(
          builder: (context) {
            return reaction(
              (_) => _taskListViewModel
                  .tasksListController.requestSetList.isFulfilled.value,
              (isFulfilled) => _scrollToEnd(withAnimation: true),
            );
          },
        ),
        ReactionBuilder(
          builder: (context) {
            return reaction(
              (_) => _taskListViewModel
                  .tasksListController.requestAddItem.isPending.value,
              (isPending) => _scrollToEnd(withAnimation: true),
            );
          },
        ),
      ],
      child: CustomScrollView(
        shrinkWrap: true,
        reverse: true,
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: SizedBox(height: 60),
          ),
          Builder(builder: (context) {
            if (_tasks.isEmpty) {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }

            return SliverReorderableList(
              proxyDecorator: proxyDecorator,
              itemCount: _tasks.length,
              onReorder: _onReorderTask,
              itemBuilder: (context, index) {
                final task = _tasks[index];

                return SwipeActionCell(
                  key: ValueKey(task),
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                      content: OutlinedSvgIconButton(
                        iconPath: Assets.trash,
                        color: themeOf(context).redAccentColor,
                        iconSize: 24,
                        padding: 14,
                        width: 52,
                        height: 52,
                      ),
                      onTap: (handler) async {
                        await _onRemoveTask(
                          task: task,
                          closeItemHandler: handler,
                        );
                      },
                      color: Colors.transparent,
                    ),
                  ],
                  child: _ReorderableTaskCard(task: task, index: index),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.02, animValue)!;
        return Transform.scale(
          scale: scale,
          child: _ReorderableTaskCard(task: _tasks[index], index: index),
        );
      },
      child: child,
    );
  }
}

class _ReorderableTaskCard extends StatelessWidget {
  const _ReorderableTaskCard(
      {super.key, required this.index, required this.task});

  final int index;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 11,
      ),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: index,
            key: Key('$index'),
            child: SvgIcon(
              color: themeOf(context).onBackgroundColor,
              iconPath: Assets.dragLines,
              iconSize: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TaskCard(
              title: task.title,
              status: task.status.value,
              startTime: task.startDate,
              finishTime: task.finishDate,
            ),
          ),
        ],
      ),
    );
  }
}
