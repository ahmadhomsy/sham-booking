import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sham_booking/features/booking/domain/repositories/stripe_payment_method_repository.dart';

class StripePaymentMethodRepositoryImpl
    implements StripePaymentMethodRepository {
  @override
  Future<String> createCardPaymentMethodId() async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      return paymentMethod.id;
    } on Exception catch (_) {
      return '';
    }
  }
}
