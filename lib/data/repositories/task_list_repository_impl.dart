import 'package:duotask/data/datasources/task_http_data_source.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:duotask/domain/repositories/task_list_repository.dart';

class TaskListRepositoryImpl implements TaskListRepository {
  TaskListRepositoryImpl({required TaskHttpDataSource taskHttpDataSource})
      : _taskHttpDataSource = taskHttpDataSource;

  final TaskHttpDataSource _taskHttpDataSource;

  @override
  Future<bool> createTask(Task task) async {
    return _taskHttpDataSource.createTask(task);
  }

  @override
  Future<bool> removeTask(String taskId) async {
    return _taskHttpDataSource.deleteTask(taskId);
  }

  @override
  Future<List<Task>> getTasks() async {
    return _taskHttpDataSource.getTasks();
  }

  @override
  Future<Task> updateTask(Task task) async {
    return _taskHttpDataSource.updateTask(task);
  }

  @override
  Future<bool> reorderTask(int oldIndex, int newIndex) async {
    return _taskHttpDataSource.reorderTask(oldIndex, newIndex);
  }
}
