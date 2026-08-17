import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sham_booking/features/booking/domain/repositories/stripe_payment_method_repository.dart';

class StripePaymentMethodRepositoryImpl
    implements StripePaymentMethodRepository {
  @override
  Future<String> createCardPaymentMethodId() async {
    try {
      print('Creating PaymentMethod...');
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );
      print("**************************************************************");
      print(paymentMethod.id);
      print("**************************************************************");
      return paymentMethod.id;
    } catch (e) {
      print("**************************************************************");

      print(e);
      print("**************************************************************");

      return "";
    }
  }
}
