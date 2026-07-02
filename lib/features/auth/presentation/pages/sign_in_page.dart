import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/features/auth/presentation/widgets/decorative_circles.dart';
import 'package:sham_booking/features/auth/presentation/widgets/divider_auth.dart';
import 'package:sham_booking/features/auth/presentation/widgets/header_section_sign_in.dart';
import 'package:sham_booking/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:sham_booking/features/auth/presentation/widgets/sign_link.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppDecorations.backgroundDecoration,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const DecorativeCircles(),
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 450),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryContainer.withValues(
                            alpha: 0.04,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const HeaderSectionSignIn(),
                        32.verticalSpace,
                        const SignInForm(),
                        24.verticalSpace,
                        const DividerAuth(),
                        24.verticalSpace,
                        const SignLink(
                          title1: "Don't have an account? ",
                          title2: 'Sign up',
                          addressPage: 'signUp',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
