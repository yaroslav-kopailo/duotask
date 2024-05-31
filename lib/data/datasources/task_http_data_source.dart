import 'dart:convert';

import 'package:duotask/core/error/exceptions.dart';
import 'package:duotask/core/network/mock_request.dart';
import 'package:duotask/core/storage/json_locale_storage.dart';
import 'package:duotask/data/models/default_response_model.dart';
import 'package:duotask/data/models/task_model.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:http/http.dart' as http;

abstract class TaskHttpDataSource {
  Future<List<Task>> getTasks();

  Future<bool> createTask(Task task);

  Future<bool> deleteTask(String taskId);

  Future<Task> updateTask(Task task);
}

class MockTaskHttpDataSourceImpl with MockClient implements TaskHttpDataSource {
  MockTaskHttpDataSourceImpl({required String authToken})
      : _authToken = authToken;

  final String _authToken;

  @override
  Future<List<Task>> getTasks() async {
    final resp = await mockRequest(
      authToken: _authToken,
      request: () async {
        // Simulate fetching tasks
        final data = await JsonLocaleStorage.loadTasksData();

        return http.Response(data, 200);
      },
    );

    if (resp.statusCode != 200) {
      throw ApiException(statusCode: resp.statusCode, message: resp.body);
    }

    final tasks = jsonDecode(resp.body)
        .map((json) => TaskModel.fromJson(json).toTask())
        .toList();

    return tasks;
  }

  @override
  Future<bool> createTask(Task task) async {
    final resp = await mockRequest(
      authToken: _authToken,
      request: () async {
        // Simulate creating task
        final data = await JsonLocaleStorage.loadDefaultResponseData();

        return http.Response(data, 200);
      },
    );

    if (resp.statusCode != 200) {
      throw ApiException(statusCode: resp.statusCode, message: resp.body);
    }

    final responseModel = DefaultResponseModel.fromJson(
      jsonDecode(resp.body),
    );

    return responseModel.success;
  }

  @override
  Future<bool> deleteTask(String taskId) async {
    final resp = await mockRequest(
      authToken: _authToken,
      request: () async {
        // Simulate deleting task
        final data = await JsonLocaleStorage.loadDefaultResponseData();

        return http.Response(data, 200);
      },
    );

    if (resp.statusCode != 200) {
      throw ApiException(statusCode: resp.statusCode, message: resp.body);
    }

    final responseModel = DefaultResponseModel.fromJson(
      jsonDecode(resp.body),
    );

    return responseModel.success;
  }

  @override
  Future<Task> updateTask(Task task) async {
    final resp = await mockRequest(
      authToken: _authToken,
      request: () async {
        // Simulate updating task
        final data = jsonEncode(TaskModel.fromTask(task).toJson());

        return http.Response(data, 200);
      },
    );

    if (resp.statusCode != 200) {
      throw ApiException(statusCode: resp.statusCode, message: resp.body);
    }

    final updatedTask = TaskModel.fromJson(
      jsonDecode(resp.body),
    ).toTask();

    return updatedTask;
  }
}
