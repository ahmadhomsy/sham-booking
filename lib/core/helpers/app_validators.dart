import 'package:easy_localization/easy_localization.dart';

class AppValidators {
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.full_name_required'.tr();
    }
    if (value.trim().length < 3) {
      return 'validation.name_too_short'.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.email_required'.tr();
    }

    final emailRegex = RegExp(
      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'validation.invalid_email'.tr();
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.password_required'.tr();
    }

    if (value.length < 8) {
      return 'validation.password_too_short'.tr();
    }

    return null;
  }
}
