import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/core/theme/text_theme.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/get_task/get_task_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetTaskCubit>(context).getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetTaskCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          context.pushReplacementNamed('kanban-dashboard');
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something Went Wrong! Try again later.'),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Task Trekker',
              style: textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                "assets/images/splash_image.jpg",
              ),
            ),
            BlocBuilder<GetTaskCubit, BaseState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return Lottie.asset(
                    'assets/animations/splash.json',
                    height: 150,
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
