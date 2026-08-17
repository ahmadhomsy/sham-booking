import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          title,
          style: AppTextStyles.normal16primaryW600.copyWith(
            height: 1,
            letterSpacing: 0.05 * 12,
          ),
        ),
      ),
    );
  }
}
