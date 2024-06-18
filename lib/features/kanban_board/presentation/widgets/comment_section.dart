part of '../pages/task_details_screen.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.taskId});

  final String taskId;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetCommentsCubit>(context).getComments(
      taskId: widget.taskId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCommentCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          BlocProvider.of<GetCommentsCubit>(context).getComments(
            taskId: widget.taskId,
          );

          BlocProvider.of<TaskManagerCubit>(context).updateTaskCommentCount(
            widget.taskId,
          );
        }
      },
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Comments:',
              style: textTheme.bodyLarge!.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: BlocBuilder<GetCommentsCubit, BaseState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessState) {
                    var comments = state.data as List<CommentEntity>;

                    if (comments.isEmpty) {
                      return Center(
                        child: Text(
                          'No comments yet',
                          style: textTheme.bodyLarge,
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comments[index].content,
                              style: textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Date: ${comments[index].getDate()}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
