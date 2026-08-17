import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';

class ResendButton extends StatelessWidget {
  const ResendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.surfaceContainerLow,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: const Icon(Icons.refresh, size: 18),
        label: Text(
          'auth.email_verification.resend_code'.tr(),
          style: AppTextStyles.normal12W600,
        ),
        onPressed: () {
          context.read<AuthBloc>().add(
            SendVerificationCodeEvent(),
          );
        },
      ),
    );
  }
}
