import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';
import 'package:sham_booking/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';
import 'package:sham_booking/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/logout_usecase.dart';
import 'package:sham_booking/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/create_stripe_payment_method_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.createStripePaymentMethodUseCase,
    required this.updateProfileUseCase,
    required this.logoutUseCase,
    required this.getProfileUseCase,
  }) : super(ProfileState()) {
    on<GetProfileEvent>((event, emit) async {
      emit(state.copyWith(status: ProfileStatus.loading));

      final failureOrUnit = await getProfileUseCase();

      await failureOrUnit.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (profileResponse) async {
          final hasPaymentMethod = box.read<bool>(hasPaymentMethodKey) ?? false;

          emit(
            state.copyWith(
              status: ProfileStatus.success,
              name: profileResponse.name,
              email: profileResponse.email,
              hasPaymentMethod: hasPaymentMethod,
            ),
          );
        },
      );
    });
    on<SignOutEvent>((event, emit) async {
      emit(state.copyWith(status: ProfileStatus.loadingSignOut));
      final failureOrUnit = await logoutUseCase();
      await failureOrUnit.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (_) async {
          emit(
            state.copyWith(
              status: ProfileStatus.successSignOut,
            ),
          );
        },
      );
    });
    on<RefreshProfileEvent>((event, emit) async {
      emit(state.copyWith(status: ProfileStatus.loading));

      final failureOrUnit = await getProfileUseCase();

      await failureOrUnit.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (profileResponse) async {
          final hasPaymentMethod = box.read<bool>(hasPaymentMethodKey) ?? false;

          emit(
            state.copyWith(
              status: ProfileStatus.success,
              name: profileResponse.name,
              email: profileResponse.email,
              hasPaymentMethod: hasPaymentMethod,
            ),
          );
        },
      );
    });
    on<UpdateProfileEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: ProfileStatus.updateProfileLoading,
            errorMessage: null,
          ),
        );

        final paymentMethodId = await createStripePaymentMethodUseCase();

        final id = box.read<int>(userId);

        if (id == null) {
          emit(
            state.copyWith(
              status: ProfileStatus.updateProfileFailure,
              errorMessage: 'User ID not found',
            ),
          );
          return;
        }

        final request = UserInfoRequest(
          id: id,
          paymentMethodId: paymentMethodId,
        );

        final result = await updateProfileUseCase(request);

        result.fold(
          (failure) {
            emit(
              state.copyWith(
                status: ProfileStatus.updateProfileFailure,
                errorMessage: _mapFailureToMessage(failure),
              ),
            );
          },
          (response) {
            emit(
              state.copyWith(
                status: ProfileStatus.updateProfileSuccess,
              ),
            );
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: ProfileStatus.updateProfileFailure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
  final CreateStripePaymentMethodUseCase createStripePaymentMethodUseCase;
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is OfflineFailure) {
      return offlineError;
    } else {
      return unknownError;
    }
  }
}
