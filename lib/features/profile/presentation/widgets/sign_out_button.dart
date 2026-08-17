import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/profile/presentation/bloc/profile_bloc.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          final isLoading = state.status == ProfileStatus.loadingSignOut;

          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.surfaceContainerLowest,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              overlayColor: AppColors.dangerRed.withValues(alpha: 0.15),
            ),
            onPressed: isLoading
                ? null
                : () {
                    context.read<ProfileBloc>().add(SignOutEvent());
                  },
            child: isLoading
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.dangerRed,
                    ),
                  )
                : Text(
                    'home.profile.sign_out'.tr(),
                    style: AppTextStyles.normal12dangerRedW600,
                  ),
          );
        },
      ),
    );
  }
}
