part of '../pages/task_details_screen.dart';

final formKey = GlobalKey<FormState>();

class CommentBottomSheet extends StatelessWidget {
  final String taskId;

  const CommentBottomSheet({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              controller: context.read<AddCommentCubit>().contentController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: const TextStyle(color: Colors.black),
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter content';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          Button(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AddCommentCubit>().addComment(
                      taskId: taskId,
                    );
                context.pop();
              }
            },
            isLoading: context.watch<AddCommentCubit>().state is LoadingState,
            label: 'Post',
          ),
        ],
      ),
    );
  }
}
