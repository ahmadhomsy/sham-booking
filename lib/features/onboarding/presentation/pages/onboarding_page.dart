import 'package:flutter/material.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            await box.write(isFirstOpenKey, true);
          },
          child: Text(
            'Onboarding Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
