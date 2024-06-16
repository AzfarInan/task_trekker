part of '../pages/kanban_dashboard_screen.dart';

class BoardColumn extends StatelessWidget {
  const BoardColumn({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: index == 0
            ? AppColors.grey
            : index == 1
                ? AppColors.blue
                : AppColors.green,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          if (index == 0) ...[
            const Icon(
              Icons.circle,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
          ] else if (index == 1) ...[
            const Icon(
              Icons.play_circle_outline_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
          ] else ...[
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            index == 0
                ? "To-Do"
                : index == 1
                    ? "In Progress"
                    : "Completed",
            style: const TextStyle(
              fontFamily: "Roboto",
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 25.78 / 22,
            ),
          ),
        ],
      ),
    );
  }
}
