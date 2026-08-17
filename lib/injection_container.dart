import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:sham_booking/core/api/api_consumer.dart';
import 'package:sham_booking/core/api/api_interceptors.dart';
import 'package:sham_booking/core/api/dio_consumer.dart';
import 'package:sham_booking/core/helpers/bloc_obs.dart';
import 'package:sham_booking/core/helpers/network_info.dart';
import 'package:sham_booking/core/helpers/speech_service.dart';
import 'package:sham_booking/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sham_booking/features/auth/domain/repositories/auth_repositories.dart';
import 'package:sham_booking/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/logged_in_usecase.dart';
import 'package:sham_booking/features/auth/domain/usecases/logout_usecase.dart';
import 'package:sham_booking/features/auth/domain/usecases/send_verification_code_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/sign_in_user_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/sign_up_user_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/verify_verification_code_use_case.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sham_booking/features/booking/data/data_sources/remote_booking_data_source.dart';
import 'package:sham_booking/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:sham_booking/features/booking/data/repositories/stripe_payment_method_repository_impl.dart';
import 'package:sham_booking/features/booking/domain/repositories/booking_repository.dart';
import 'package:sham_booking/features/booking/domain/repositories/stripe_payment_method_repository.dart';
import 'package:sham_booking/features/booking/domain/usecases/cancel_booking_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/create_stripe_payment_method_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/delete_booking_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/find_one_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/get_booking_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/update_booking_use_case.dart';
import 'package:sham_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:sham_booking/features/booking/presentation/bloc/crud_booking_bloc.dart';
import 'package:sham_booking/features/booking/presentation/bloc/details_book_bloc.dart';
import 'package:sham_booking/features/home/data/data_sources/hotel_local_data_source.dart';
import 'package:sham_booking/features/home/data/data_sources/hotel_remote_data_source.dart';
import 'package:sham_booking/features/home/data/repositories/hotel_repository_impl.dart';
import 'package:sham_booking/features/home/domain/repositories/hotel_repository.dart';
import 'package:sham_booking/features/home/domain/usecases/get_all_hotel_use_case.dart';
import 'package:sham_booking/features/home/domain/usecases/get_hotel_details_use_case.dart';
import 'package:sham_booking/features/home/presentation/bloc/get_book_bloc.dart';
import 'package:sham_booking/features/home/presentation/bloc/home_rooms_bloc.dart';
import 'package:sham_booking/features/home/presentation/bloc/hotel_bloc.dart';
import 'package:sham_booking/features/hotel/presentation/bloc/hotel_details_bloc.dart';
import 'package:sham_booking/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:sham_booking/features/profile/data/datasources/chat_remote_data_source.dart';
import 'package:sham_booking/features/profile/data/repositories/chat_repository_impl.dart';
import 'package:sham_booking/features/profile/domain/repositories/chat_repository.dart';
import 'package:sham_booking/features/profile/domain/usecases/send_message_usecase.dart';
import 'package:sham_booking/features/profile/presentation/bloc/chat_cubit.dart';
import 'package:sham_booking/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:sham_booking/features/rooms/data/data_sources/local_room_data_source.dart';
import 'package:sham_booking/features/rooms/data/data_sources/remote_room_data_source.dart';
import 'package:sham_booking/features/rooms/data/repositories/room_repository_impl.dart';
import 'package:sham_booking/features/rooms/domain/repositories/room_repositories.dart';
import 'package:sham_booking/features/rooms/domain/usecases/get_available_room_use_case.dart';
import 'package:sham_booking/features/rooms/domain/usecases/get_hotel_room_use_case.dart';
import 'package:sham_booking/features/rooms/domain/usecases/get_room_use_case.dart';
import 'package:sham_booking/features/rooms/domain/usecases/show_room_use_case.dart';
import 'package:sham_booking/features/rooms/presentation/bloc/show_room_bloc.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await dotenv.load();
  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  if (apiKey.isEmpty) {
    throw Exception('API Key is missing in .env file');
  }

  sl
    // Chat & Cubits
    ..registerFactory(
      () => ChatCubit(sendMessageUseCase: sl(), speechService: sl()),
    )
    ..registerLazySingleton(() => SendMessageUseCase(sl()))
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(sl()),
    )
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(apiKey: apiKey),
    )
    ..registerFactory<SplashCubit>(() => SplashCubit(loggedInUseCase: sl()))
    ..registerFactory<OnBoardingCubit>(OnBoardingCubit.new)
    // Auth Bloc
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        sendVerificationCodeUseCase: sl(),
        verificationCodeUseCase: sl(),
        signInUserUseCase: sl(),
        signUpUserUseCase: sl(),
      ),
    )
    // Booking Bloc
    ..registerFactory<BookingBloc>(
      () => BookingBloc(
        createBookingUseCase: sl(),
        createStripePaymentMethodUseCase: sl(),
        updateUserUseCase: sl(),
      ),
    )
    ..registerFactory<CrudBookingBloc>(
      () => CrudBookingBloc(
        cancelBookingUseCase: sl(),
        deleteBookingUseCase: sl(),
        updateBookingUseCase: sl(),
      ),
    )
    ..registerFactory<GetBookBloc>(
      () => GetBookBloc(
        getBookingUseCase: sl(),
      ),
    )
    // Other Blocs
    ..registerFactory<HomeRoomsBloc>(
      () => HomeRoomsBloc(
        getAvailableRoomUseCase: sl(),
      ),
    )
    ..registerFactory<HotelBloc>(
      () => HotelBloc(
        getAllHotelUseCase: sl(),
        getHotelDetailsUseCase: sl(),
      ),
    )
    ..registerFactoryParam<HotelDetailsBloc, int, void>(
      (hotelId, _) => HotelDetailsBloc(
        hotelId: hotelId,
        getHotelDetailsUseCase: sl(),
        getHotelRoomUseCase: sl(),
        getAvailableRoomUseCase: sl(),
      ),
    )
    ..registerFactoryParam<ShowRoomBloc, int, void>(
      (roomId, _) => ShowRoomBloc(
        roomId: roomId,
        showRoomUseCase: sl(),
      ),
    )
    ..registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: sl(),
        logoutUseCase: sl(),
        updateProfileUseCase: sl(),
        createStripePaymentMethodUseCase: sl(),
      ),
    )
    ..registerFactoryParam<DetailsBookBloc, int, void>(
      (bookId, _) => DetailsBookBloc(
        findOneBookingUseCase: sl(),
        bookId: bookId,
      ),
    )
    // Booking Use Cases
    ..registerLazySingleton<CreateBookingUseCase>(
      () => CreateBookingUseCase(sl()),
    )
    ..registerLazySingleton<CancelBookingUseCase>(
      () => CancelBookingUseCase(sl()),
    )
    ..registerLazySingleton<DeleteBookingUseCase>(
      () => DeleteBookingUseCase(sl()),
    )
    ..registerLazySingleton<FindOneUseCase>(
      () => FindOneUseCase(sl()),
    )
    ..registerLazySingleton<GetBookingUseCase>(
      () => GetBookingUseCase(sl()),
    )
    ..registerLazySingleton<UpdateBookingUseCase>(
      () => UpdateBookingUseCase(sl()),
    )
    ..registerLazySingleton<CreateStripePaymentMethodUseCase>(
      () => CreateStripePaymentMethodUseCase(sl()),
    )
    // User Use Cases
    // Auth & Profile Use Cases
    ..registerLazySingleton<LoggedInUseCase>(() => LoggedInUseCase(sl()))
    ..registerLazySingleton<SignInUserUseCase>(() => SignInUserUseCase(sl()))
    ..registerLazySingleton<SignUpUserUseCase>(() => SignUpUserUseCase(sl()))
    ..registerLazySingleton<SendVerificationCodeUseCase>(
      () => SendVerificationCodeUseCase(sl()),
    )
    ..registerLazySingleton<VerifyVerificationCodeUseCase>(
      () => VerifyVerificationCodeUseCase(sl()),
    )
    ..registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()))
    ..registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(sl()),
    )
    ..registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()))
    // Hotel & Room Use Cases
    ..registerLazySingleton<GetAllHotelUseCase>(() => GetAllHotelUseCase(sl()))
    ..registerLazySingleton<GetHotelDetailsUseCase>(
      () => GetHotelDetailsUseCase(sl()),
    )
    ..registerLazySingleton<GetRoomUseCase>(
      () => GetRoomUseCase(sl()),
    )
    ..registerLazySingleton<GetHotelRoomUseCase>(
      () => GetHotelRoomUseCase(sl()),
    )
    ..registerLazySingleton<ShowRoomUseCase>(
      () => ShowRoomUseCase(sl()),
    )
    ..registerLazySingleton<GetAvailableRoomUseCase>(
      () => GetAvailableRoomUseCase(sl()),
    )
    // Repositories
    ..registerLazySingleton<HotelRepository>(
      () => HotelRepositoryImpl(
        networkInfo: sl(),
        hotelRemoteDataSource: sl(),
        hotelLocalDataSource: sl(),
      ),
    )
    ..registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ),
    )
    ..registerLazySingleton<StripePaymentMethodRepository>(
      StripePaymentMethodRepositoryImpl.new,
    )
    ..registerLazySingleton<RoomRepository>(
      () => RoomRepositoryImpl(
        networkInfo: sl(),
        localDataSource: sl(),
        remoteAuthDataSource: sl(),
      ),
    )
    ..registerLazySingleton<AuthRepositories>(
      () => AuthRepositoryImpl(
        networkInfo: sl(),
        localDataSource: sl(),
        remoteAuthDataSource: sl(),
      ),
    )
    // Data Sources
    ..registerLazySingleton<HotelLocalDataSource>(
      HotelLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<LocalRoomDataSource>(
      LocalRoomDataSourceImpl.new,
    )
    ..registerLazySingleton<HotelRemoteDataSource>(
      () => HotelRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<RemoteBookingDataSource>(
      () => RemoteBookingDataSourceImpl(sl()),
    )
    ..registerLazySingleton<RemoteRoomDataSource>(
      () => RemoteRoomDataSourceImpl(sl()),
    )
    ..registerLazySingleton<LocalAuthDataSource>(
      () => LocalAuthDataSourceImpl(secureStorage: sl()),
    )
    ..registerLazySingleton<RemoteAuthDataSource>(
      () => RemoteAuthDataSourceImpl(sl()),
    )
    // Core & External
    ..registerLazySingleton<ApiConsumer>(
      () => DioConsumer(dio: sl(), apiInterceptors: sl()),
    )
    ..registerLazySingleton(
      () => ApiInterceptors(sl()),
    )
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<Dio>(Dio.new)
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(InternetConnectionChecker.createInstance)
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<MyBlocObserver>(() => MyBlocObserver(sl()))
    ..registerLazySingleton<SpeechService>(SpeechService.new);
}
