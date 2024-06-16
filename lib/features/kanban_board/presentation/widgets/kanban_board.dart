part of '../pages/kanban_dashboard_screen.dart';

class KanbanBoard extends StatefulWidget {
  const KanbanBoard({super.key, required this.list});

  final List<TaskEntity> list;

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TaskManagerCubit>(context).initiateTasks(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerCubit, BaseState>(
      builder: (context, state) {
        final tasks = context.read<TaskManagerCubit>().tasks;

        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

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
                    BlocProvider.of<UpdateTaskCubit>(context).changeLabel(
                      index: index,
                      taskId: task.id,
                    );

                    final cubit = context.read<TaskManagerCubit>();
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
                                  final cubit =
                                      context.read<TaskManagerCubit>();
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
      },
    );
  }
}
