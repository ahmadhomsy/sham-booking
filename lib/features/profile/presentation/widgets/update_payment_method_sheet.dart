import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class UpdatePaymentMethodSheet extends StatefulWidget {
  const UpdatePaymentMethodSheet({
    required this.onUpdate,
    super.key,
  });

  final VoidCallback onUpdate;

  @override
  State<UpdatePaymentMethodSheet> createState() =>
      _UpdatePaymentMethodSheetState();
}

class _UpdatePaymentMethodSheetState extends State<UpdatePaymentMethodSheet> {
  CardFieldInputDetails? cardDetails;

  @override
  Widget build(BuildContext context) {
    final isComplete = cardDetails?.complete ?? false;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            24.verticalSpace,

            // Header
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.goldAccent.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.credit_card_rounded,
                    color: AppColors.goldAccent,
                  ),
                ),

                12.horizontalSpace,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'home.profile.payment_method.update_title'.tr(),
                        style: const TextStyle(
                          color: AppColors.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'home.profile.payment_method.update_subtitle'.tr(),
                        style: const TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            24.verticalSpace,

            // Stripe Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.outlineVariant,
                ),
              ),
              child: CardField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.zero,
                ),
                onCardChanged: (details) {
                  setState(() {
                    cardDetails = details;
                  });
                },
              ),
            ),

            12.verticalSpace,

            // Security message
            Row(
              children: [
                const Icon(
                  Icons.lock_outline_rounded,
                  size: 15,
                  color: AppColors.outline,
                ),
                6.horizontalSpace,
                Expanded(
                  child: Text(
                    'home.profile.payment_method.card_information'.tr(),
                    style: const TextStyle(
                      color: AppColors.outline,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            24.verticalSpace,

            // Update button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isComplete
                    ? () {
                        Navigator.of(context).pop();
                        widget.onUpdate();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldAccent,
                  disabledBackgroundColor: AppColors.surfaceContainer,
                  foregroundColor: AppColors.primary,
                  disabledForegroundColor: AppColors.outline,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'home.profile.payment_method.secure_payment_description'.tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
