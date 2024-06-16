part of '../pages/kanban_dashboard_screen.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.read<GetTaskCubit>().tasks;

    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(tasks.length, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            width: 280,
            decoration: BoxDecoration(
              color: index == 0
                  ? AppColors.backgroundGray
                  : index == 1
                      ? AppColors.backgroundBlue
                      : AppColors.backgroundGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DragTarget<TaskEntity>(
              onAccept: (task) {
                final cubit = context.read<GetTaskCubit>();
                cubit.moveTask(cubit.draggedFromColumn, index, task);
              },
              builder: (context, candidateData, rejectedData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoardColumn(index: index),
                    const SizedBox(height: 8),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: tasks[index].length,
                        itemBuilder: (context, taskIndex) {
                          final task = tasks[index][taskIndex];
                          return Draggable<TaskEntity>(
                            data: task,
                            onDragStarted: () {
                              final cubit = context.read<GetTaskCubit>();
                              cubit.draggedFromColumn = index;
                              cubit.draggedTask = task;
                            },
                            feedback: Material(
                              child: TaskItem(task: task, index: index),
                            ),
                            childWhenDragging: Container(),
                            child: TaskItem(task: task, index: index),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.index,
  });

  final TaskEntity task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (task.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  task.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.flag_sharp,
                    color: AppColors.golden,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    task.getPriority(), // assuming TaskEntity has a priority field
                    style: textTheme.bodyMedium!.copyWith(
                      color: task.priority == 3 || task.priority == 4
                          ? AppColors.error
                          : AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.insert_comment,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${task.commentCount} Comments', // assuming TaskEntity has a priority field
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (index == 2) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      color: AppColors.blue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Tracked Time:', // assuming TaskEntity has a priority field
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      task.getDuration(), // assuming TaskEntity has a priority field
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
              if (index == 2) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_sharp,
                      color: AppColors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Completed On:', // assuming TaskEntity has a priority field
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      task.getCompletedOn(), // assuming TaskEntity has a priority field
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          if (task.isActiveTask()) ...[
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    height: 14.06 / 12,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
