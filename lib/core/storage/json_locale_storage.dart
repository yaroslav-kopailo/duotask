import 'package:duotask/core/helper/asset_paths.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class JsonLocaleStorage {
  static Future<String> loadTasksData() async {
    final data = await rootBundle.loadString(Assets.tasksJson);
    return data;
  }

  static Future<String> loadDefaultResponseData() async {
    final data = await rootBundle.loadString(Assets.defaultResponseJson);
    return data;
  }

  static Future<String> loadAuthCredData() async {
    final data = await rootBundle.loadString(Assets.authCredJson);
    return data;
  }

  static Future<String> loadAuthTokenData() async {
    final data = await rootBundle.loadString(Assets.tokenJson);
    return data;
  }
}
