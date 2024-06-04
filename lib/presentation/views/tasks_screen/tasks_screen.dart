import 'package:auto_route/auto_route.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:duotask/presentation/base_widgets/reaction_handlers/retry_request_handler.dart';
import 'package:duotask/presentation/view_models/task_list_view_model.dart';
import 'package:duotask/presentation/views/tasks_screen/widgets/tasks_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class TasksScreen extends StatefulWidget {
  const TasksScreen({
    super.key,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.removeAnimationDuration = const Duration(milliseconds: 250),
  });

  final Duration insertAnimationDuration;
  final Duration removeAnimationDuration;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  static final _tabNames = ['All', ...TaskStatusType.names];

  late final _tabController = TabController(length: 4, vsync: this);
  late final _taskListViewModel =
      Provider.of<TaskListViewModel>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _tabController.addListener(() {
      _taskListViewModel.selectTaskTypeName(
        _tabNames[_tabController.index],
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RetryRequestHandler(
          request: _taskListViewModel.tasksListController.requestSetList,
          retryRequestAction: _taskListViewModel.resetTasksList,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: themeOf(context).onBackgroundColor,
                indicatorWeight: 2,
                dividerColor: themeOf(context).dividerColor,
                dividerHeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                tabAlignment: TabAlignment.start,
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateColor.transparent,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                labelStyle: themeOf(context).h6OnBackgroundStyle,
                unselectedLabelStyle:
                    themeOf(context).h6OnBackgroundStyleWithOpacity(0.4),
                tabs: _tabNames
                    .map((name) => Tab(
                          text: name,
                        ))
                    .toList(),
                isScrollable: true,
              ),
              const Flexible(
                child: TasksReorderableList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
