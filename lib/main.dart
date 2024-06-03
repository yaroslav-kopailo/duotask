import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/injection_container.dart';
import 'package:duotask/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themexpert/themexpert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the dependency injection container.
  await InjectionContainer().init();

  // Run the app with MyApp as the root widget.
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {}
  }

  @override
  Widget build(BuildContext context) {
    return ThemeXConfiguration(
      darkMode: true,
      builder: (context) {
        return ThemeXWrapper(
          theme: AppTheme(context),
          builder: (context) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter.config(),
              theme: ThemeData(
                useMaterial3: true,
                scaffoldBackgroundColor: themeOf(context).backgroundColor,
              ),
            );
          },
        );
      },
    );
  }
}
