import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/core/theme/text_theme.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.white,
      title: Text(
        "Task Trekker",
        style: textTheme.displaySmall!.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add_circle_rounded,
            color: AppColors.black,
            size: 32,
            semanticLabel: "Add Task",
          ),
          onPressed: () {
            context.pushNamed('add-task');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
