import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/home/presentation/bloc/home_rooms_bloc.dart';
import 'package:sham_booking/features/hotel/presentation/widgets/room_card.dart';

class RoomsWidget extends StatefulWidget {
  const RoomsWidget({super.key});

  @override
  State<RoomsWidget> createState() => _RoomsWidgetState();
}

class _RoomsWidgetState extends State<RoomsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HomeRoomsBloc>().add(GetAvailableRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final topOffset = kToolbarHeight + MediaQuery.of(context).padding.top;
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        color: AppColors.secondaryContainer,
        edgeOffset: topOffset,
        onRefresh: () async {
          context.read<HomeRoomsBloc>().add(GetAvailableRoomsEvent());
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
                // const HeroSearchSection(),
                Text(
                  'home.rooms.featured_rooms'.tr(),
                  style: AppTextStyles.normal32primaryContainerW600.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ).animate().fade(duration: 500.ms).slideY(begin: 0.5, end: 0),
                15.verticalSpace,
                BlocBuilder<HomeRoomsBloc, HomeRoomsState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case HomeRoomsStatus.initial:
                      case HomeRoomsStatus.loading:
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: CircularProgressIndicator(),
                          ),
                        );

                      case HomeRoomsStatus.failure:
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              state.errorMessage ?? 'Something went wrong',
                            ),
                          ),
                        );

                      case HomeRoomsStatus.success:
                        if (state.availableRooms.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Text(
                                'No rooms available',
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: state.availableRooms
                              .map(
                                (room) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  child: RoomCard(
                                    id: room.id,
                                    title: room.name,
                                    price: room.basePrice,
                                    imgUrl: room.images.isNotEmpty
                                        ? room.images.first
                                        : 'https://lh3.googleusercontent.com/aida-public/AB6AXuDb3RSX6Ngi4Rs7OprYciO4TivMn88JFvJFMoMUboJfSBfU4OAYpuj9gdRgw23hDD1w4Vg0-SxD8nsVNGk7zAYCsIij5sM9zi-0bNVT_U2WZsrlmtlLiL2X8IEe1U05odfhEllXOrHSPXqnUHUb6NigZWGTcZ3wCx9_ClqgTEgFp3lsfYVysIJ1ld5y7ZOz9oZKWYcSdyiJcBRhwIoE_ce9OYPfSeEDgunUY52krm52W2_fIA1izU1a',
                                    features: room.amenities,
                                  ),
                                ),
                              )
                              .toList(),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
