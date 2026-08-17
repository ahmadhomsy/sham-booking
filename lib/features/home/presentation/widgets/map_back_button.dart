import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class MapBackButton extends StatelessWidget {
  const MapBackButton({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      child: CircleAvatar(
        backgroundColor: AppColors.surfaceContainerLowest,
        radius: 22,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          color: AppColors.primaryContainer,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
