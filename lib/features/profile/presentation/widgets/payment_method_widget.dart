import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/profile/presentation/widgets/update_payment_method_sheet.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    required this.onUpdate,
    super.key,
  });

  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.goldAccent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.goldAccent.withValues(alpha: 0.35),
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.creditCard,
                      size: 19,
                      color: AppColors.goldAccent,
                    ),
                  ),

                  12.horizontalSpace,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'home.profile.payment_method.title'.tr(),
                          style: const TextStyle(
                            color: AppColors.surfaceContainerLowest,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'home.profile.payment_method.subtitle'.tr(),
                          style: const TextStyle(
                            color: AppColors.primaryFixedDim,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.goldAccent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: AppColors.goldAccent,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'home.profile.payment_method.active'.tr(),
                          style: const TextStyle(
                            color: AppColors.goldAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              24.verticalSpace,

              // Card preview
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryContainer,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.goldAccent.withValues(alpha: 0.25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.simCard,
                          color: AppColors.goldAccent,
                          size: 26,
                        ),
                        Text(
                          'home.profile.payment_method.card'.tr(),
                          style: TextStyle(
                            color: AppColors.primaryFixedDim.withValues(
                              alpha: 0.7,
                            ),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),

                    22.verticalSpace,

                    const Text(
                      '••••  ••••  ••••  ••••',
                      style: TextStyle(
                        color: AppColors.surfaceContainerLowest,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),

                    16.verticalSpace,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'home.profile.payment_method.secure_payment'.tr(),
                          style: const TextStyle(
                            color: AppColors.primaryFixedDim,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const FaIcon(
                          FontAwesomeIcons.shieldHalved,
                          size: 16,
                          color: AppColors.goldAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              18.verticalSpace,

              // Update button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _showUpdatePaymentSheet(context),
                  icon: const FaIcon(
                    FontAwesomeIcons.penToSquare,
                    size: 15,
                  ),
                  label: Text(
                    'home.profile.payment_method.update'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldAccent,
                    foregroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          duration: 500.ms,
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.08,
          end: 0,
          duration: 500.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Future<void> _showUpdatePaymentSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return UpdatePaymentMethodSheet(
          onUpdate: onUpdate,
        );
      },
    );
  }
}
