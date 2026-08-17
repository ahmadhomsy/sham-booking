import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/features/home/presentation/bloc/hotel_bloc.dart';
import 'package:sham_booking/features/home/presentation/widgets/hotel_card.dart';
import 'package:sham_booking/features/home/presentation/widgets/hotel_card_shimmer.dart';

class FeaturedGemsList extends StatelessWidget {
  const FeaturedGemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        if (state.status == HotelStatus.loading) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, _) => 24.verticalSpace,
            itemBuilder: (_, index) {
              return const HotelCardShimmer();
            },
          );
        }

        if (state.status == HotelStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage?.tr() ??
                  'home.explore.something_went_wrong'.tr(),
            ),
          );
        }

        final hotels = state.hotels ?? [];

        if (hotels.isEmpty) {
          return Center(
            child: Text(
              'home.explore.no_hotels_found'.tr(),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: hotels.length,

          separatorBuilder: (context, index) => 24.verticalSpace,

          itemBuilder: (context, index) {
            final hotel = hotels[index];

            return HotelCard(
              hotel: hotel,
            );
          },
        );
      },
    );
  }
}
