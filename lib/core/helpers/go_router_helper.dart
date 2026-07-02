import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/helpers/page_transitions.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sham_booking/features/auth/presentation/pages/email_verification_page.dart';
import 'package:sham_booking/features/auth/presentation/pages/sign_in_page.dart';
import 'package:sham_booking/features/auth/presentation/pages/sign_up_page.dart';
import 'package:sham_booking/features/home/presentation/pages/home_page.dart';
import 'package:sham_booking/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:sham_booking/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sham_booking/features/splash/presentation/pages/splash_page.dart';
import 'package:sham_booking/injection_container.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (context) {
            final cubit = sl<SplashCubit>();
            unawaited(cubit.initSplash());
            return cubit;
          },
          child: const SplashPage(),
        ),
        transitionsBuilder: PageTransitions.fadeTransition,
      ),
    ),
    GoRoute(
      path: '/onBoarding',
      name: 'onBoarding',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (_) => sl<OnBoardingCubit>(),
          child: const OnboardingPage(),
        ),
        transitionsBuilder: PageTransitions.fadeTransition,
      ),
    ),
    GoRoute(
      path: '/signIn',
      name: 'signIn',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInPage(),
        ),
        transitionsBuilder: PageTransitions.fadeTransition,
      ),
    ),
    GoRoute(
      path: '/signUp',
      name: 'signUp',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpPage(),
        ),
        transitionsBuilder: PageTransitions.fadeTransition,
      ),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: PageTransitions.fadeTransition,
      ),
    ),
    GoRoute(
      path: '/emailVerification',
      name: 'emailVerification',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (context) {
            final bloc = sl<AuthBloc>();
            unawaited(bloc.sendVerificationCodeUseCase());
            return bloc;
          },
          // create: (_) => sl<AuthBloc>(),
          child: const EmailVerificationPage(),
        ),
        transitionsBuilder: PageTransitions.fadeTransition,
      ),
    ),
  ],
);
