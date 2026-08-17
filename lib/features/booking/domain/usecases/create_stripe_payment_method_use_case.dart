import 'package:sham_booking/features/booking/domain/repositories/stripe_payment_method_repository.dart';

class CreateStripePaymentMethodUseCase {
  CreateStripePaymentMethodUseCase(this.repository);
  final StripePaymentMethodRepository repository;

  Future<String> call() {
    return repository.createCardPaymentMethodId();
  }
}
