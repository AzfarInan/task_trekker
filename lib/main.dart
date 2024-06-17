import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/add_task/add_task_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/get_task/get_task_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/task_manager/task_manager_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/task_timer/task_timer_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/update_task/update_task_cubit.dart';
import 'core/dependency/injection.dart';
import 'core/navigation/navigator_service.dart';
import 'core/theme/theme.dart';
import 'features/shared/presentation/widgets/custom_error_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTaskCubit>(create: (_) => getIt<GetTaskCubit>()),
        BlocProvider<AddTaskCubit>(create: (_) => getIt<AddTaskCubit>()),
        BlocProvider<TaskManagerCubit>(
            create: (_) => getIt<TaskManagerCubit>()),
        BlocProvider<UpdateTaskCubit>(create: (_) => getIt<UpdateTaskCubit>()),
        BlocProvider<TaskTimerCubit>(create: (_) => getIt<TaskTimerCubit>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Task Trekker',
        routerConfig: getIt<AppRouter>().router,
        theme: themeData,
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomErrorScreen(errorDetails: errorDetails);
          };
          return widget!;
        },
      ),
    );
  }
}
