import 'package:auto_route/auto_route.dart';
import 'package:duotask/presentation/views/home_navigation_screen/widgets/custom_bottom_nav_bar.dart';
import 'package:duotask/router/router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeNavigationScreen extends StatefulWidget {
  const HomeNavigationScreen({super.key});

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
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
        return Scaffold(
          body: child,
          extendBody: true,
          bottomNavigationBar: CBottomNavBar(
            onAddTaskPressed: () {},
            onTabSelected: (index) {},
          ),
        );
      },
    );
  }
}
