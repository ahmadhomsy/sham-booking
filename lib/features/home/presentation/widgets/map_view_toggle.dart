import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/home/presentation/bloc/hotel_bloc.dart';

class MapViewToggle extends StatelessWidget {
  const MapViewToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton.icon(
        onPressed: () async {
          final hotels = context.read<HotelBloc>().state.hotels ?? [];
          await context.pushNamed(
            'hotelsMap',
            extra: hotels,
          );
        },
        icon: const FaIcon(FontAwesomeIcons.mapLocation, size: 18),
        label: Text(
          'home.explore.map_view'.tr(),
          style: AppTextStyles.normal12W600,
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryContainer,
          backgroundColor: AppColors.surfaceContainerLowest,
          side: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
