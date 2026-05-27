import 'package:flutter/material.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In Page"),
      ),
      body: MaterialButton(
        onPressed: () async {
          await box.write(isVerifiedKey, true);
        },
        child: const Center(
          child: Text("Sign In Page"),
        ),
      ),
    );
  }
}
