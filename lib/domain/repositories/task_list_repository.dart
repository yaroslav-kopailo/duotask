import 'package:duotask/domain/entities/task.dart';

abstract class TaskListRepository {
  Future<List<Task>> getTasks();

  Future<bool> createTask(Task task);

  Future<bool> removeTask(String taskId);

  Future<bool> reorderTask(int oldIndex, int newIndex);

  Future<Task> updateTask(Task task);
}
