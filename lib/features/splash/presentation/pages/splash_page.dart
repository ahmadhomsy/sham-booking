import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/widgets/no_internet_bottom_sheet.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_state.dart';
import 'package:sham_booking/features/splash/presentation/widgets/splash_content.dart';
import 'package:sham_booking/features/splash/presentation/widgets/splash_progress_bar.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) async {
        if (state.status == SplashStatus.error) {
          await showModalBottomSheet<void>(
            context: context,
            isDismissible: false,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            builder: (_) => ErrorBottomSheet(
              onPressed: () async {
                Navigator.pop(context);
                await context.read<SplashCubit>().initSplash();
              },
              errorMessage: state.message,
            ),
          );
          return;
        }
        if (state.status == SplashStatus.completed) {
          if (state.isFirstOpen) {
            context.go('/onBoarding');
          } else if (!state.isSignedIn) {
            context.go('/signIn');
          } else if (!state.isEmailVerified) {
            context.go('/emailVerification');
          } else if (state.isEmailVerified) {
            context.go('/home');
          }
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: AppDecorations.splashDecoration,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: AppDecorations.glassDecoration,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SplashContent(),
                        48.verticalSpace,

                        const SplashProgressBar(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
