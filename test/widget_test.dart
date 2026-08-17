// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sham_booking/app.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/data/models/get_profile_response.dart';
import 'package:sham_booking/features/auth/data/models/get_profile_response_local.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';
import 'package:sham_booking/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/logout_usecase.dart';
import 'package:sham_booking/features/auth/domain/usecases/logged_in_usecase.dart';
import 'package:sham_booking/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/domain/repositories/hotel_repository.dart';
import 'package:sham_booking/features/home/domain/usecases/get_all_hotel_use_case.dart';
import 'package:sham_booking/features/home/domain/usecases/get_hotel_details_use_case.dart';
import 'package:sham_booking/features/home/presentation/bloc/hotel_bloc.dart';
import 'package:sham_booking/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sham_booking/injection_container.dart';

class _FakeAuthRepository implements AuthRepositories {
  @override
  Future<Either<Failure, bool>> loggedIn() async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, GetProfileResponseLocal>> getProfile() async {
    return Right(GetProfileResponseLocal(name: 'Tester', email: 't@t.com'));
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> sendVerificationCode() async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, String>> signInUser(
    SignInUserRequestModel request,
  ) async {
    return const Right('tester');
  }

  @override
  Future<Either<Failure, Unit>> signUpUser(
    SignUpUserRequestModel request,
  ) async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(UserInfoRequest userInfo) async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, String>> verifyVerificationCode(String code) async {
    return const Right('tester');
  }
}

class _FakeHotelRepository implements HotelRepository {
  @override
  Future<Either<Failure, List<HotelModel>>> getAllHotels() async {
    return const Right(<HotelModel>[]);
  }

  @override
  Future<Either<Failure, HotelModel>> getHotelDetails(int id) async {
    return Left(UnexpectedFailure());
  }
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (methodCall) async => '.',
        );
    await GetStorage.init();
    await sl.reset();
    final useCase = LoggedInUseCase(_FakeAuthRepository());
    final hotelRepository = _FakeHotelRepository();
    final authRepository = _FakeAuthRepository();
    sl
      ..registerFactory<SplashCubit>(
        () => SplashCubit(loggedInUseCase: useCase),
      )
      ..registerLazySingleton<HotelRepository>(() => hotelRepository)
      ..registerLazySingleton<GetAllHotelUseCase>(
        () => GetAllHotelUseCase(sl()),
      )
      ..registerLazySingleton<GetHotelDetailsUseCase>(
        () => GetHotelDetailsUseCase(sl()),
      )
      ..registerFactory<HotelBloc>(
        () => HotelBloc(
          getAllHotelUseCase: sl(),
          getHotelDetailsUseCase: sl(),
        ),
      )
      ..registerLazySingleton<AuthRepositories>(() => authRepository)
      ..registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()))
      ..registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()))
      ..registerLazySingleton<UpdateProfileUseCase>(
        () => UpdateProfileUseCase(sl()),
      )
      ..registerFactory<ProfileBloc>(
        () => ProfileBloc(
          getProfileUseCase: sl(),
          logoutUseCase: sl(),
          updateProfileUseCase: sl(),
          createStripePaymentMethodUseCase: sl(),
        ),
      );
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          null,
        );
  });

  testWidgets('App basic smoke test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    // Splash screen should be visible immediately
    expect(find.text('ShamBook'), findsOneWidget);

    // Pump timers to allow initSplash to finish and navigate
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify that our app navigates away from Splash UI.
    expect(find.text('ShamBook'), findsNothing);
  });
}
