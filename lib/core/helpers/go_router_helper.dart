import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/helpers/page_transitions.dart';
import 'package:sham_booking/features/splash/presentation/pages/splash_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashPage(),
        transitionsBuilder: PageTransitions.fadeTransition,
      ),
    ),
  ],
);
