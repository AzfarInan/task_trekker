import 'package:flutter/material.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'package:task_trekker/core/theme/theme.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? Transform.scale(
                    scale: 1,
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        label,
                        style: themeData.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
