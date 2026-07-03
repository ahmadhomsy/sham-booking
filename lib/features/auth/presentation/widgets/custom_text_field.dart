import 'package:flutter/material.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    super.key,
    this.keyboardType,
    this.isObscure,
    this.onToggleVisibility,
    this.validator,
  });
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final VoidCallback? onToggleVisibility;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.normal12onSurfaceVariantW600,
        ),
        8.verticalSpace,
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: isObscure ?? false,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.outline.withValues(alpha: 0.7),
            ),
            prefixIcon: Icon(icon, color: AppColors.outline, size: 22),
            suffixIcon: onToggleVisibility != null
                ? IconButton(
                    icon: Icon(
                      isObscure!
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.outline,
                      size: 20,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.surfaceTint,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
