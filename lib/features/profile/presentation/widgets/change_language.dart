import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class DialogChangeLanguage extends StatelessWidget {
  const DialogChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.goldAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              margin: const EdgeInsets.only(bottom: 24),
            ),

            RadioGroup<Locale>(
              groupValue: currentLocale,
              onChanged: (newLocale) async {
                if (newLocale == null || newLocale == currentLocale) return;

                final lang = newLocale.languageCode;

                // حفظ اللغة
                await box.write(enLangKey, lang);

                // إغلاق Dialog
                if (!context.mounted) return;
                context.pop();

                // تغيير اللغة
                await context.setLocale(newLocale);

                // إعادة تشغيل التطبيق
                await Restart.restartApp();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRadioTile(
                    context: context,
                    title: 'العربية',
                    value: const Locale('ar'),
                    currentLocale: currentLocale,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),

                  _buildRadioTile(
                    context: context,
                    title: 'English',
                    value: const Locale('en'),
                    currentLocale: currentLocale,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile({
    required BuildContext context,
    required String title,
    required Locale value,
    required Locale currentLocale,
  }) {
    final isSelected = currentLocale == value;

    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: AppColors.outlineVariant,
      ),
      child: RadioListTile<Locale>(
        value: value,
        activeColor: AppColors.goldAccent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.goldAccent : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
