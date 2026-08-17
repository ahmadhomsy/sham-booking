import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/helpers/page_transitions.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sham_booking/features/auth/presentation/pages/email_verification_page.dart';
import 'package:sham_booking/features/auth/presentation/pages/sign_in_page.dart';
import 'package:sham_booking/features/auth/presentation/pages/sign_up_page.dart';
import 'package:sham_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:sham_booking/features/booking/presentation/bloc/details_book_bloc.dart';
import 'package:sham_booking/features/booking/presentation/pages/book_details_page.dart';
import 'package:sham_booking/features/booking/presentation/pages/create_booking_screen.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/presentation/pages/home_page.dart';
import 'package:sham_booking/features/home/presentation/widgets/hotels_map_page.dart';
import 'package:sham_booking/features/hotel/presentation/bloc/hotel_details_bloc.dart';
import 'package:sham_booking/features/hotel/presentation/pages/hotel_details_page.dart';
import 'package:sham_booking/features/hotel/presentation/pages/hotels_map_page.dart';
import 'package:sham_booking/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:sham_booking/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:sham_booking/features/profile/presentation/bloc/chat_cubit.dart';
import 'package:sham_booking/features/profile/presentation/pages/contact_ai_concierge_page.dart';
import 'package:sham_booking/features/profile/presentation/pages/help_center_page.dart';
import 'package:sham_booking/features/rooms/presentation/bloc/show_room_bloc.dart';
import 'package:sham_booking/features/rooms/presentation/pages/room_page.dart';
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
    GoRoute(
      path: '/hotelsMap',
      name: 'hotelsMap',
      pageBuilder: (context, state) {
        final hotels = state.extra is List<HotelModel>
            ? state.extra! as List<HotelModel>
            : <HotelModel>[];

        return CustomTransitionPage(
          key: state.pageKey,
          child: HotelsMapPage(hotels: hotels),
          transitionsBuilder: PageTransitions.fadeTransition,
        );
      },
    ),
    GoRoute(
      path: '/helpCenter',
      name: 'helpCenter',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HelpCenterPage(),
          transitionsBuilder: PageTransitions.fadeTransition,
        );
      },
    ),
    GoRoute(
      path: '/contactAiConcierge',
      name: 'contactAiConcierge',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<ChatCubit>(),
            child: const ContactAiConciergePage(),
          ),
          transitionsBuilder: PageTransitions.fadeTransition,
        );
      },
    ),
    GoRoute(
      path: '/hotelDetails/:id',
      name: 'hotelDetails',
      pageBuilder: (context, state) {
        final hotelId = int.parse(state.pathParameters['id']!);

        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<HotelDetailsBloc>(param1: hotelId),
            child: const HotelDetailsPage(),
          ),
          transitionsBuilder: PageTransitions.fadeTransition,
        );
      },
    ),
    GoRoute(
      path: '/bookDetails/:id',
      name: 'bookDetails',
      pageBuilder: (context, state) {
        final bookId = int.parse(state.pathParameters['id']!);

        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<DetailsBookBloc>(param1: bookId),
            child: const BookDetailsPage(),
          ),
          transitionsBuilder: PageTransitions.fadeTransition,
        );
      },
    ),
    GoRoute(
      path: '/roomDetails/:id',
      name: 'roomDetails',
      pageBuilder: (context, state) {
        final roomId = int.parse(state.pathParameters['id']!);

        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<ShowRoomBloc>(param1: roomId),
            child: const RoomDetailsPage(),
          ),
          transitionsBuilder: PageTransitions.fadeTransition,
        );
      },
    ),
    GoRoute(
      // أضفنا hotelId إلى مسار الرابط
      path: '/createBooking/:hotelId/:roomId',
      name: 'createBooking',
      pageBuilder: (context, state) {
        // استخراج المتغيرين من الرابط
        final hotelId = int.parse(state.pathParameters['hotelId']!);
        final roomId = int.parse(state.pathParameters['roomId']!);

        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<BookingBloc>(),
            child: CreateBookingScreen(
              roomId: roomId,
              hotelId: hotelId, // تم تمرير hotelId بنجاح
            ),
          ),
          transitionsBuilder: PageTransitions.fadeTransition,
        );
      },
    ),
    GoRoute(
      name: 'hotelLocation',
      path: '/hotel-location',
      builder: (context, state) {
        final latitude = double.tryParse(
          state.uri.queryParameters['latitude'] ?? '',
        );

        final longitude = double.tryParse(
          state.uri.queryParameters['longitude'] ?? '',
        );

        final hotelName = state.uri.queryParameters['hotelName'] ?? 'Hotel';

        final address = state.uri.queryParameters['address'] ?? '';

        if (latitude == null || longitude == null) {
          return const Scaffold(
            body: Center(
              child: Text('Hotel location is unavailable'),
            ),
          );
        }

        return HotelLocationPage(
          latitude: latitude,
          longitude: longitude,
          hotelName: hotelName,
          address: address,
        );
      },
    ),
  ],
);
