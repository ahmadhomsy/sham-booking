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
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';
import 'package:sham_booking/features/auth/domain/usecases/logged_in_usecase.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sham_booking/injection_container.dart';

class _FakeAuthRepository implements AuthRepositories {
  @override
  Future<Either<Failure, bool>> loggedIn() async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, Unit>> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> sendVerificationCode() {
    // TODO: implement sendVerificationCode
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signInUser(SignInUserRequestModel request) {
    // TODO: implement signInUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> signUpUser(SignUpUserRequestModel request) {
    // TODO: implement signUpUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(UserInfoRequest userInfo) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> verifyVerificationCode(String code) {
    // TODO: implement verifyVerificationCode
    throw UnimplementedError();
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
    sl.registerFactory<SplashCubit>(
      () => SplashCubit(loggedInUseCase: useCase),
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
