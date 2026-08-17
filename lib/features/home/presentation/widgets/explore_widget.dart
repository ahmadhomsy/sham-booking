import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/home/presentation/bloc/hotel_bloc.dart';
import 'package:sham_booking/features/home/presentation/widgets/featured_gems_list.dart';
import 'package:sham_booking/features/home/presentation/widgets/hero_search_section.dart';
import 'package:sham_booking/features/home/presentation/widgets/map_view_toggle.dart';

class ExploreWidget extends StatelessWidget {
  const ExploreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final topOffset = kToolbarHeight + MediaQuery.of(context).padding.top;
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        color: AppColors.secondaryContainer,
        edgeOffset:
            topOffset, // <--- يضمن ظهور الـ Refresh تحت الـ AppBar مباشرة دون سحب الصفحة بالكامل
        onRefresh: () async {
          context.read<HotelBloc>().add(RefreshHotelsEvent());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 40,
              top: kToolbarHeight + 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeroSearchSection(),
                15.verticalSpace,
                const MapViewToggle(),
                5.verticalSpace,
                Text(
                  'home.explore.featured_gems'.tr(),
                  style: AppTextStyles.normal32primaryContainerW600,
                ).animate().fade(duration: 500.ms).slideY(begin: 0.5, end: 0),
                15.verticalSpace,
                const FeaturedGemsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
