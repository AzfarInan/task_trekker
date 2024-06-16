import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:task_trekker/core/globals/global_variables.dart';
import 'package:task_trekker/features/kanban_board/presentation/pages/add_task_screen.dart';
import 'package:task_trekker/features/kanban_board/presentation/pages/kanban_dashboard_screen.dart';
import 'package:task_trekker/features/splash/presentation/pages/splash_screen.dart';

@singleton
class AppRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: GlobalVariables.rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: [
          GoRoute(
            name: 'kanban-dashboard',
            path: 'kanban-dashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const KanbanDashboardScreen();
            },
            routes: [
              GoRoute(
                name: 'add-task',
                path: 'add-task',
                builder: (BuildContext context, GoRouterState state) {
                  return const AddTaskScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
