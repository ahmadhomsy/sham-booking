class StripeConfig {
  const StripeConfig._();

  static const String publishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue:
        'pk_test_51TLOqx2RX1osNFAjgp9u9hKNgoGmFwdnkpYvgDph7Ej7LetZTXnCU4YCkSWj9NLhKFZ7p6c4C6t1pQIsglMqp1xK00aRXHgfAo',
  );
}
