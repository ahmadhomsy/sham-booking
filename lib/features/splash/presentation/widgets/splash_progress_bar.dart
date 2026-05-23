import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_state.dart';

class SplashProgressBar extends StatelessWidget {
  const SplashProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      buildWhen: (p, c) => p.progress != c.progress,
      builder: (context, state) {
        return TweenAnimationBuilder<double>(
          tween: Tween(end: state.progress),
          duration: 400.ms,
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                valueColor: const AlwaysStoppedAnimation(
                  AppColors.goldAccent,
                ),
              ),
            );
          },
        );
      },
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }
}
