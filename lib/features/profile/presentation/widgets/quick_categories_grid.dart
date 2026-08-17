import 'package:flutter/material.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class QuickCategoriesGrid extends StatelessWidget {
  const QuickCategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: AppDecorations.helpCenterCardDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: AppDecorations.iconSecondaryFixedDecoration,
                child: Icon(
                  categories[index]['icon'] as IconData,
                  color: AppColors.onSecondaryFixed,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                categories[index]['title'] as String,
                textAlign: TextAlign.center,
                style: AppTextStyles.normal14onSurfaceW500,
              ),
            ],
          ),
        );
      },
    );
  }
}
