import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class SupportListItem extends StatelessWidget {
  const SupportListItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.textColor,
    super.key,
    this.isBold = false,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color textColor;
  final bool isBold;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: iconColor, size: 22),
      title: Text(
        label,
        style: AppTextStyles.normal14onSurfaceW400.copyWith(
          color: textColor,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: onTap,
    );
  }
}
