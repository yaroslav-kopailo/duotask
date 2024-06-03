import 'package:duotask/core/obs/observable_list_controller.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:duotask/domain/repositories/task_list_repository.dart';
import 'package:mobx/mobx.dart';

class TaskListViewModel {
  TaskListViewModel({required TaskListRepository taskListRepository})
      : _taskListRepository = taskListRepository {
    setupTasksList();
  }

  final TaskListRepository _taskListRepository;

  final ObservableListController<Task> tasksListController =
      ObservableListController(
    defaultValue: [],
    equalityChecker: (task1, task2) => task1.id == task2.id,
  );

  final Observable<String> selectedTaskStatusTypeName = Observable('All');

  void selectTaskTypeName(String taskTypeName) {
    runInAction(() {
      selectedTaskStatusTypeName.value = taskTypeName;
    });
  }

  late final Computed<List<Task>> filteredTasks = Computed(() {
    final selectedTaskTypeName = selectedTaskStatusTypeName.value;

    if (TaskStatusType.names.contains(selectedTaskTypeName)) {
      return tasksListController.list.data
          .where((Task task) => task.status.value.name == selectedTaskTypeName)
          .toList();
    }

    return tasksListController.list.data.toList();
  });

  void setupTasksList() {
    tasksListController.executeSetList(
      request: _taskListRepository.getTasks,
    );
  }

  void resetTasksList() {
    setupTasksList();
  }

  void addNewTask(Task task) {
    tasksListController.executeAddItem(
      item: task,
      request: () async {
        return await _taskListRepository.createTask(task);
      },
    );
  }

  void reorderTask({required Task task, Task? previousTask, Task? nextTask}) {
    final oldIndex = tasksListController.list.data.lastIndexWhere(
      (t) => t == task,
    );

    int? newIndex;
    if (previousTask != null) {
      newIndex = tasksListController.list.data.lastIndexWhere(
        (t) => t == previousTask,
      );
    } else if (nextTask != null) {
      newIndex = tasksListController.list.data.lastIndexWhere(
        (t) => t == nextTask,
      );
    }

    if (newIndex == null) return;

    tasksListController.executeReorderItem(
      oldIndex: oldIndex,
      newIndex: newIndex,
      request: () async {
        return await _taskListRepository.reorderTask(oldIndex, newIndex!);
      },
    );
  }

  void removeTask(Task task) {
    tasksListController.executeRemoveItem(
      item: task,
      request: () async {
        return await _taskListRepository.removeTask(task.id);
      },
    );
  }
}
