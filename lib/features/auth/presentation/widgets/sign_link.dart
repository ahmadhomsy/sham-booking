import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class SignLink extends StatelessWidget {
  const SignLink({
    required this.addressPage,
    required this.title1,
    required this.title2,
    super.key,
  });
  final String title1;
  final String title2;
  final String addressPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title1,
          style: AppTextStyles.normal16onSurfaceVariant,
        ),
        GestureDetector(
          onTap: () async {
            await context.push('/$addressPage');
          },
          child: Text(
            title2,
            style: AppTextStyles.normal16primaryW700,
          ),
        ),
      ],
    );
  }
}
