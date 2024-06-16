import 'package:flutter/material.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/core/theme/text_theme.dart';

class KanbanDashboardScreen extends StatelessWidget {
  const KanbanDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: Text(
            "Kanban Board",
            style: textTheme.displaySmall!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: const Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "Kanban Board",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      height: 25.78 / 22,
                    ),
                  ),
                ),
              ),
              // KanbanBoardWidget(),
            ],
          ),
        ));
  }
}
