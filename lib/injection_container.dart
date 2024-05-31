import 'package:duotask/app_config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Service Locator instance for dependency injection.
final sl = GetIt.instance;

/// Sets up and registers dependencies for the app.
class InjectionContainer {
  /// Initializes and registers dependencies asynchronously.
  Future<void> init() async {
    await Hive.initFlutter();

    sl.registerSingleton<AppConfig>(
      AppConfig(
        apiHost: 'api.com',
      ),
    );

    // DataSources

    // Repositories

    // Controllers
  }
}
