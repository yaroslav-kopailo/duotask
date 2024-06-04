import 'package:auto_route/auto_route.dart';
import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/injection_container.dart';
import 'package:duotask/presentation/base_widgets/bottom_sheets/create_task_bottom_sheet.dart';
import 'package:duotask/presentation/base_widgets/reaction_handlers/default_failures_handler.dart';
import 'package:duotask/presentation/base_widgets/toasts/custom_toasts.dart';
import 'package:duotask/presentation/view_models/task_list_view_model.dart';
import 'package:duotask/presentation/views/home_navigation_screen/widgets/custom_bottom_nav_bar.dart';
import 'package:duotask/presentation/views/root_screen/root_screen.dart';
import 'package:duotask/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeNavigationScreen extends StatefulWidget {
  const HomeNavigationScreen({super.key});

  @override
  State<HomeNavigationScreen> createState() => HomeNavigationScreenState();
}

class HomeNavigationScreenState extends State<HomeNavigationScreen> {
  static HomeNavigationScreenState of(BuildContext context) {
    return context.findAncestorStateOfType<HomeNavigationScreenState>()!;
  }

  late final _taskListViewModel = sl<TaskListViewModel>();

  Future<void> onCreateTask() async {
    _taskListViewModel.startCreatingNewTask();
    await RootScreenState.of(context).showBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      onDismiss: () {},
      bottomSheet: CreateTaskBottomSheet(
        taskListViewModel: _taskListViewModel,
        onCreateTask: _taskListViewModel.addNewTask,
      ),
    );
  }

  void showSuccessToast({required String text}) {
    CustomToasts.showSecondaryToast(
      context: context,
      text: text,
      iconPath: Assets.checkCircle,
      iconColor: themeOf(context).greenSuccessColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TaskListViewModel>(create: (context) => _taskListViewModel),
      ],
      child: AutoTabsRouter(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        routes: [
          TasksRoute(),
          TasksRoute(),
          TasksRoute(),
        ],
        lazyLoad: true,
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return DefaultFailuresHandler(
            failures: [
              _taskListViewModel.tasksListController.requestAddItem.failure,
              _taskListViewModel.tasksListController.requestReorderItem.failure,
              _taskListViewModel.tasksListController.requestRemoveItem.failure,
            ],
            child: MultiReactionBuilder(
              builders: [
                ReactionBuilder(
                  builder: (context) {
                    return reaction(
                      (_) => _taskListViewModel.tasksListController
                          .requestRemoveItem.isFulfilled.value,
                      (isFulfilled) {
                        if (isFulfilled) {
                          HomeNavigationScreenState.of(context)
                              .showSuccessToast(
                            text: 'Task was deleted successfully.',
                          );
                        }
                      },
                    );
                  },
                ),
                ReactionBuilder(
                  builder: (context) {
                    return reaction(
                      (_) => _taskListViewModel
                          .tasksListController.requestAddItem.isFulfilled.value,
                      (isFulfilled) {
                        if (isFulfilled) {
                          HomeNavigationScreenState.of(context)
                              .showSuccessToast(
                            text: 'Task was created successfully.',
                          );
                        }
                      },
                    );
                  },
                ),
              ],
              child: Scaffold(
                body: child,
                extendBody: true,
                bottomNavigationBar: CBottomNavBar(
                  onAddTaskPressed: onCreateTask,
                  onTabSelected: (index) {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
