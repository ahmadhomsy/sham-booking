import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: state.isAgreeTerms,
                activeColor: AppColors.surfaceTint,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (value) {
                  context.read<AuthBloc>().add(ToggleAgreeTerms());
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 13,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
