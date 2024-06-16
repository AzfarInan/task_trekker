import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/core/theme/text_theme.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/get_task/get_task_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/widgets/primary_app_bar.dart';

part '../widgets/kanban_board.dart';
part '../widgets/board_column.dart';

class KanbanDashboardScreen extends StatelessWidget {
  const KanbanDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      backgroundColor: AppColors.white,
      body: BlocBuilder<GetTaskCubit, BaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(child: Text(state.data));
          } else if (state is SuccessState) {
            return KanbanBoard();
          }

          return const SizedBox();
        },
      ),
    );
  }
}
