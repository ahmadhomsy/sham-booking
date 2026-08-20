import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/core/widgets/error_bottom_sheet.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sham_booking/features/auth/presentation/widgets/illustration.dart';
import 'package:sham_booking/features/auth/presentation/widgets/ambient_backgrounds.dart';
import 'package:sham_booking/features/auth/presentation/widgets/back_to_sign_up.dart';
import 'package:sham_booking/features/auth/presentation/widgets/glass_email_card.dart';
import 'package:sham_booking/features/auth/presentation/widgets/resend_button.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.status == AuthStatus.failure) {
          await showModalBottomSheet<void>(
            context: context,
            isDismissible: false,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            builder: (_) => ErrorBottomSheet(
              onPressed: () async {
                Navigator.pop(context);
              },
              errorMessage:
                  state.errorMessage ??
                  'auth.email_verification.verification_error'.tr(),
            ),
          );
          return;
        } else if (state.status == AuthStatus.successVerify) {
          if (state.role == 'user') {
            context.go('/home');
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundStart,
          body: Stack(
            children: [
              const AmbientBackgrounds(),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 48,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Illustration(),
                        32.verticalSpace,
                        Text(
                          'auth.email_verification.title'.tr(),
                          style: AppTextStyles.normal32primaryBold,
                          textAlign: TextAlign.center,
                        ),
                        12.verticalSpace,
                        Text(
                          'auth.email_verification.description'.tr(),
                          style: AppTextStyles.normal16onSurfaceVariant
                              .copyWith(
                                height: 1.5,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        32.verticalSpace,
                        const GlassEmailCard(),
                        8.verticalSpace,
                        if (state.status == AuthStatus.loading)
                          const CircularProgressIndicator()
                        else
                          Pinput(
                            length: 6,
                            onCompleted: (code) {
                              context.read<AuthBloc>().add(
                                VerifyVerificationCodeEvent(code: code),
                              );
                            },
                          ),
                        32.verticalSpace,
                        const ResendButton(),
                        20.verticalSpace,
                        const BackToSignUp(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
