import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    required this.icon,
    required this.label,
    required this.trailing,
    super.key,
    this.onTap,
  });
  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: Colors.grey, size: 22),
      title: Text(label, style: AppTextStyles.normal14onSurfaceW400),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
