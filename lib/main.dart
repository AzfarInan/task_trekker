import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/get_task/get_task_cubit.dart';
import 'core/dependency/injection.dart';
import 'core/navigation/navigator_service.dart';
import 'core/theme/theme.dart';
import 'features/shared/presentation/widgets/custom_error_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTaskCubit>(
          create: (_) => getIt<GetTaskCubit>(),
        ),
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
