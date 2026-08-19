import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_shadow.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/core/theme/theme_cubit.dart';
import 'package:sham_booking/features/profile/presentation/widgets/change_language.dart';
import 'package:sham_booking/features/profile/presentation/widgets/section_title.dart';
import 'package:sham_booking/features/profile/presentation/widgets/settings_list_item.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'home.profile.settings.title'.tr(),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [AppShadow.cardShadow],
          ),
          child: Column(
            children: [
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  final isDark = themeMode == ThemeMode.dark;
                  return SettingsListItem(
                    icon: isDark ? Icons.dark_mode : Icons.light_mode,
                    label: 'home.profile.settings.dark_mode'.tr(),
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isDark,
                        thumbColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.white;
                          }
                          return AppColors.outline;
                        }),
                        trackColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.secondaryContainer;
                          }
                          return AppColors.surfaceContainerLow;
                        }),
                        trackOutlineColor: WidgetStateProperty.resolveWith((
                          states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.transparent;
                          }
                          return AppColors.outlineVariant;
                        }),
                        onChanged: (value) async {
                          await context.read<ThemeCubit>().toggleTheme(
                            isDark: value,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const Divider(indent: 16, height: 1),
              SettingsListItem(
                icon: Icons.language,
                label: 'home.profile.settings.language'.tr(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.locale.languageCode == 'ar'
                          ? 'العربية'
                          : 'English',
                      style: AppTextStyles.normal14onSurfaceVariantW400,
                    ),
                    4.horizontalSpace,
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
                onTap: () async {
                  await showGeneralDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: 'LanguageDialog',
                    barrierColor: Colors.black.withValues(alpha: 0.6),
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, _, _) => const DialogChangeLanguage(),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(begin: 0.85, end: 1).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutCubic,
                                ),
                              ),
                              child: child,
                            ),
                          );
                        },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
