import 'package:duotask/app_config.dart';
import 'package:duotask/core/helper/hive_keys.dart';
import 'package:duotask/data/datasources/auth_http_data_source.dart';
import 'package:duotask/data/datasources/task_http_data_source.dart';
import 'package:duotask/data/datasources/token_cache_data_source.dart';
import 'package:duotask/data/repositories/auth_repository_impl.dart';
import 'package:duotask/data/repositories/task_list_repository_impl.dart';
import 'package:duotask/data/repositories/token_repository_impl.dart';
import 'package:duotask/domain/repositories/auth_repository.dart';
import 'package:duotask/domain/repositories/task_list_repository.dart';
import 'package:duotask/domain/repositories/token_repository.dart';
import 'package:duotask/presentation/view_models/auth_view_model.dart';
import 'package:duotask/presentation/view_models/task_list_view_model.dart';
import 'package:duotask/presentation/view_models/token_view_model.dart';
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

    sl.registerSingleton<Box>(
      await Hive.openBox(HiveKeys.authTokenBox),
      instanceName: HiveKeys.authTokenBox,
    );

    // DataSources
    sl
      ..registerFactory<TokenCacheDataSource>(
        () => TokenCacheDataSourceImpl(
          tokenCacheBox: sl(instanceName: HiveKeys.authTokenBox),
        ),
      )
      ..registerFactory<AuthHttpDataSource>(
        () => MockAuthHttpDataSourceImpl(),
      )
      ..registerFactory<TaskHttpDataSource>(
        () => MockTaskHttpDataSourceImpl(
          authToken: sl<TokenViewModel>().authToken.value ?? '',
        ),
      );

    // Repositories
    sl
      ..registerFactory<TokenRepository>(
        () => TokenRepositoryImpl(tokenCacheDataSource: sl()),
      )
      ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(authHttpDataSource: sl()),
      )
      ..registerFactory<TaskListRepository>(
        () => TaskListRepositoryImpl(taskHttpDataSource: sl()),
      );

    // ViewModels
    sl
      ..registerSingleton<TokenViewModel>(
        TokenViewModel(tokenRepository: sl()),
      )
      ..registerFactory<AuthViewModel>(
        () => AuthViewModel(
          tokenRepository: sl(),
          authRepository: sl(),
        ),
      )
      ..registerFactory<TaskListViewModel>(
        () => TaskListViewModel(taskListRepository: sl()),
      );
  }
}
