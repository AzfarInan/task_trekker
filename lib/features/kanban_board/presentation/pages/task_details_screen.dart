import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_trekker/core/base/base_state.dart';
import 'package:task_trekker/core/cache_service/cached_task_entity.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/core/theme/text_theme.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/comment_entity.dart';
import 'package:task_trekker/features/kanban_board/domain/entities/task_entity.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/add_comment/add_comment_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/get_comments/get_comments_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/task_manager/task_manager_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/task_timer/task_timer_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/manager/update_task/update_task_cubit.dart';
import 'package:task_trekker/features/kanban_board/presentation/widgets/stopwatch.dart';
import 'package:task_trekker/features/shared/presentation/widgets/button.dart';

part '../widgets/comment_section.dart';
part '../widgets/comment_bottomsheet.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final TaskEntity task;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  int activatedTime = 0;
  bool autoStart = false;

  @override
  void initState() {
    super.initState();

    print("Time: ${widget.task.getActivatedTime()}");
    activatedTime = widget.task.getActivatedTime();
    if (widget.task.isActiveTask()) {
      BlocProvider.of<TaskTimerCubit>(context).getTask(widget.task.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: AppColors.primary,
      ),
      body: BlocConsumer<TaskTimerCubit, BaseState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is GetTaskSuccessState) {
            setState(() {
              print(state.data.taskActivationTime);
              activatedTime = (state.data.taskActivationTime
                      .difference(DateTime.now())
                      .inMinutes)
                  .abs();
              print(activatedTime);

              activatedTime =
                  (widget.task.getActivatedTime() - activatedTime).abs() +
                      widget.task.getActivatedTime();
              print(activatedTime);

              autoStart = true;
            });
          } else if (state is RemoveTaskSuccessState) {
            setState(() {
              autoStart = false;
            });
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.error,
                content: Text(
                  state.data.toString(),
                  style: textTheme.bodyLarge,
                ),
              ),
            );
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                viewItem(title: 'Title', body: widget.task.content),
                viewItem(title: 'Description', body: widget.task.description),
                viewItem(
                  title: 'Priority',
                  body: widget.task.getPriority(),
                  icon: const Icon(
                    Icons.flag_sharp,
                    color: AppColors.golden,
                  ),
                ),
                if (widget.task.isInProgressTask() ||
                    widget.task.isActiveTask()) ...[
                  titleText('Track Time'),
                  const SizedBox(height: 4),
                  if (state is GetTaskSuccessState ||
                      state is SaveTaskSuccessState ||
                      state is RemoveTaskSuccessState) ...[
                    StopwatchWidget(
                      onStop: (duration) {
                        /// print
                        print("On Stop");

                        /// Remove The Task Time Locally
                        BlocProvider.of<TaskTimerCubit>(context)
                            .removeTask(widget.task.id);

                        /// Activate task label
                        BlocProvider.of<UpdateTaskCubit>(context)
                            .deactivateTask(
                          taskId: widget.task.id,
                          duration: duration.inMinutes,
                        );

                        BlocProvider.of<TaskManagerCubit>(context)
                            .inactiveActiveTask(
                                widget.task, duration.inMinutes);
                      },
                      onStart: (duration) {
                        if (!autoStart) {
                          print("On Start");

                          /// Save The Task Time Locally
                          BlocProvider.of<TaskTimerCubit>(context).saveTask(
                            CachedTaskEntity(
                              taskId: widget.task.id,
                              taskActivationTime:
                                  widget.task.getActivatedTime() == 0
                                      ? DateTime.now()
                                      : DateTime.now().subtract(
                                          Duration(
                                              minutes: widget.task
                                                  .getActivatedTime()),
                                        ),
                            ),
                          );

                          /// Activate task label
                          BlocProvider.of<UpdateTaskCubit>(context)
                              .activateTask(taskId: widget.task.id);

                          BlocProvider.of<TaskManagerCubit>(context)
                              .updateActiveTask(widget.task);
                        }
                      },
                      autoStart: autoStart,
                      initialMinutes: activatedTime,
                    ),
                  ],
                ] else ...[
                  viewItem(
                    title: 'Task Duration',
                    body: widget.task.duration != null
                        ? '${widget.task.duration!.amount} minutes'
                        : '0 Minutes',
                    icon: const Icon(
                      Icons.timer,
                      color: AppColors.primary,
                    ),
                  ),
                ],
                CommentSection(taskId: widget.task.id),
              ],
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<AddCommentCubit, BaseState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () => _showCommentBottomSheet(context),
            backgroundColor: AppColors.primary,
            child: state is LoadingState
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
          );
        },
      ),
    );
  }

  void _showCommentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CommentBottomSheet(
            taskId: widget.task.id,
          ),
        );
      },
    );
  }

  Widget viewItem({required String title, required String body, Widget? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(title),
        Row(
          children: [
            icon ?? const SizedBox(),
            icon != null ? const SizedBox(width: 6) : const SizedBox(),
            bodyText(body),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Text titleText(String title) {
    return Text(
      '$title:',
      style: textTheme.bodyLarge!.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text bodyText(String body) {
    return Text(
      body,
      style: textTheme.bodyLarge!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
