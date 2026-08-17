import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/home/presentation/bloc/get_book_bloc.dart';
import 'package:sham_booking/features/home/presentation/widgets/book_card.dart';

class BooksWidget extends StatefulWidget {
  const BooksWidget({super.key});

  @override
  State<BooksWidget> createState() => _BooksWidgetState();
}

class _BooksWidgetState extends State<BooksWidget> {
  @override
  void initState() {
    super.initState();
    context.read<GetBookBloc>().add(SubmitGetBookingEvent());
  }

  @override
  Widget build(BuildContext context) {
    final topOffset = kToolbarHeight + MediaQuery.of(context).padding.top;

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        color: AppColors.secondaryContainer, // لون مؤشر التحميل (ذهبي)
        edgeOffset: topOffset,
        onRefresh: () async {
          context.read<GetBookBloc>().add(SubmitGetBookingEvent());
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
                Text(
                  'bookings.title'.tr(),
                  style: AppTextStyles.normal32primaryContainerW600,
                ).animate().fade(duration: 500.ms).slideY(begin: 0.5, end: 0),

                15.verticalSpace,

                // تم التعديل لاستخدام GetBookBloc بدلاً من HomeRoomsBloc
                BlocBuilder<GetBookBloc, GetBookState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case GetBookStatus.initial:
                      case GetBookStatus.loading:
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryContainer,
                            ),
                          ),
                        );

                      case GetBookStatus.failure:
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              state.errorMessage ?? 'bookings.error'.tr(),
                              style: const TextStyle(
                                color: AppColors.dangerRed,
                              ),
                            ),
                          ),
                        );

                      case GetBookStatus.success:
                        final bookingsList = state.bookingsResponse?.data ?? [];

                        if (bookingsList.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Text(
                                'bookings.no_bookings'.tr(),
                                style: const TextStyle(
                                  color: AppColors.outline,
                                ),
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: bookingsList.map((booking) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: BookCard(
                                booking: booking,
                                onTap: () async {
                                  await context.pushNamed(
                                    'bookDetails',
                                    pathParameters: {
                                      'id': booking.id.toString(),
                                    },
                                  );
                                },
                              ).animate().fade().slideY(begin: 0.2, end: 0),
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
                50.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
