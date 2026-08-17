import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/features/booking/data/models/cancel_request.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/data/models/update_booking_request.dart';
import 'package:sham_booking/features/booking/presentation/bloc/crud_booking_bloc.dart';
import 'package:sham_booking/features/booking/presentation/bloc/details_book_bloc.dart';
import 'package:sham_booking/features/booking/presentation/widgets/update_booking_dialog.dart';
import 'package:sham_booking/injection_container.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailsBookBloc>().add(FetchBookingDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CrudBookingBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundStart,
        appBar: AppBar(
          backgroundColor: AppColors.topBarBackground,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Booking Details',
            style: TextStyle(
              color: AppColors.primaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: const IconThemeData(
            color: AppColors.primaryContainer,
          ),
        ),
        // استخدمنا BlocListener للاستماع لنتائج عمليات (الحذف/التعديل/الإلغاء)
        body: BlocListener<CrudBookingBloc, CrudBookingState>(
          listener: (context, crudState) {
            if (crudState.status == CrudBookingStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(crudState.errorMessage ?? 'Operation failed'),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (crudState.status == CrudBookingStatus.deleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking deleted successfully')),
              );
              Navigator.pop(context); // العودة للصفحة السابقة بعد الحذف
            } else if (crudState.status == CrudBookingStatus.cancelSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking cancelled successfully')),
              );
              // إعادة جلب التفاصيل لتحديث حالة الحجز في الواجهة لتصبح cancelled
              context.read<DetailsBookBloc>().add(FetchBookingDetailsEvent());
            } else if (crudState.status == CrudBookingStatus.updateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking updated successfully')),
              );
              // إعادة جلب التفاصيل لتحديث البيانات
              context.read<DetailsBookBloc>().add(FetchBookingDetailsEvent());
            }
          },
          child: BlocBuilder<DetailsBookBloc, DetailsBookState>(
            builder: (context, state) {
              switch (state.status) {
                case DetailsBookStatus.loading:
                  return const _LoadingView(); // افتراض أن لديك هذه الـ Widget

                case DetailsBookStatus.failure:
                  return _ErrorView(
                    message: state.errorMessage ?? 'Something went wrong',
                    onRetry: () {
                      context.read<DetailsBookBloc>().add(
                        FetchBookingDetailsEvent(),
                      );
                    },
                  );

                case DetailsBookStatus.success:
                  final booking = state.bookingDetails?.data;

                  if (booking == null) {
                    return const _ErrorView(
                      message: 'Booking details are not available.',
                    );
                  }

                  return Column(
                    children: [
                      // الـ Widget الخاصة بعرض تفاصيل الحجز (يجب أن تأخذ Expanded أو Flexible إذا كانت قابلة للتمرير)
                      Expanded(
                        child: _BookingDetailsContent(booking: booking),
                      ),
                      // شريط الأزرار في الأسفل
                      _BookingActionButtons(booking: booking),
                    ],
                  );

                case DetailsBookStatus.initial:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _BookingActionButtons extends StatelessWidget {
  const _BookingActionButtons({required this.booking});

  final BookingData
  booking; // استبدل dynamic بنوع الموديل الخاص بك (مثلاً BookingData)

  @override
  Widget build(BuildContext context) {
    // 1. تحديد الحالات (تأكد من مطابقة الكلمات المكتوبة هنا للكلمات القادمة من الـ API لديك)
    final String? status = booking.status.toString().toLowerCase();

    // الإلغاء والتعديل مسموح فقط إذا كان الحجز قيد الانتظار أو مؤكد ولم يكتمل أو يلغى
    final bool canCancelOrUpdate = status == 'pending' || status == 'confirmed';

    // الحذف مسموح إذا انتهى الحجز (مكتمل) أو تم إلغاؤه مسبقاً
    final bool canDelete = status == 'completed' || status == 'cancelled';

    return BlocBuilder<CrudBookingBloc, CrudBookingState>(
      builder: (context, crudState) {
        final isLoading = crudState.status == CrudBookingStatus.loading;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                if (canCancelOrUpdate) ...[
                  // زر التعديل
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              // نفتح الـ Dialog وننتظر منه الريكويست المُحدث
                              final UpdateBookingRequest? updatedRequest =
                                  await showDialog<UpdateBookingRequest>(
                                    context: context,
                                    builder: (ctx) =>
                                        UpdateBookingDialog(booking: booking),
                                  );

                              // إذا عاد المستخدم ببيانات (لم يضغط إلغاء) وكان الـ id غير فارغ
                              if (updatedRequest != null && context.mounted) {
                                context.read<CrudBookingBloc>().add(
                                  SubmitUpdateBookingEvent(updatedRequest),
                                );
                              }
                            },
                      child: const Text('Update'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // زر الإلغاء
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // لون تحذيري
                        foregroundColor: Colors.white,
                      ),
                      onPressed: isLoading
                          ? null
                          : () => _confirmAction(
                              context: context,
                              title: 'Cancel Booking',
                              content:
                                  'Are you sure you want to cancel this booking?',
                              onConfirm: () {
                                // التأكد من أن الـ id ليس null قبل الإرسال
                                if (booking.id != null) {
                                  context.read<CrudBookingBloc>().add(
                                    SubmitCancelBookingEvent(
                                      // هنا نمرر الـ Request كاملاً بالبيانات المطلوبة
                                      CancelBookingRequest(
                                        id: booking.id!,
                                        cancelReason:
                                            'Cancelled by user', // نص افتراضي لسبب الإلغاء
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Cancel'),
                    ),
                  ),
                ],

                // if (canDelete) ...[
                //   // زر الحذف
                //   Expanded(
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.red, // لون خطر للحذف
                //         foregroundColor: Colors.white,
                //       ),
                //       onPressed: isLoading
                //           ? null
                //           : () => _confirmAction(
                //               context: context,
                //               title: 'Delete Booking',
                //               content:
                //                   'Are you sure you want to delete this record? This action cannot be undone.',
                //               onConfirm: () {
                //                 context.read<CrudBookingBloc>().add(
                //                   SubmitDeleteBookingEvent(booking.id!),
                //                 );
                //               },
                //             ),
                //       child: isLoading
                //           ? const SizedBox(
                //               height: 20,
                //               width: 20,
                //               child: CircularProgressIndicator(
                //                 color: Colors.white,
                //               ),
                //             )
                //           : const Text('Delete Record'),
                //     ),
                //   ),
                // ],
              ],
            ),
          ),
        );
      },
    );
  }

  // دالة مساعدة لإظهار Dialog تأكيد قبل الحذف أو الإلغاء لتجنب الأخطاء غير المقصودة
  void _confirmAction({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No, Back'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx); // إغلاق الـ Dialog
              onConfirm(); // تنفيذ العملية
            },
            child: const Text(
              'Yes, Confirm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingDetailsContent extends StatelessWidget {
  const _BookingDetailsContent({
    required this.booking,
  });

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    final hotel = booking.hotel;
    final room = booking.room;
    final roomType = room?.type;

    return RefreshIndicator(
      color: AppColors.secondaryContainer,
      onRefresh: () async {
        context.read<DetailsBookBloc>().add(
          FetchBookingDetailsEvent(),
        );
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(
          20,
          16,
          20,
          40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BookingHeader(
              booking: booking,
              hotel: hotel,
            ),

            const SizedBox(height: 20),

            _HotelCard(
              hotel: hotel,
            ),

            const SizedBox(height: 16),

            _RoomCard(
              room: room,
              roomType: roomType,
            ),

            const SizedBox(height: 16),

            _StayDetailsCard(
              booking: booking,
            ),

            const SizedBox(height: 16),

            _GuestDetailsCard(
              booking: booking,
            ),

            const SizedBox(height: 16),

            _PriceSummaryCard(
              booking: booking,
            ),

            if (booking.notes != null && booking.notes!.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              _NotesCard(
                notes: booking.notes!,
              ),
            ],

            if (booking.cancelReason != null &&
                booking.cancelReason!.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              _CancelReasonCard(
                reason: booking.cancelReason!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BookingHeader extends StatelessWidget {
  const _BookingHeader({
    required this.booking,
    required this.hotel,
  });

  final BookingData booking;
  final Hotel? hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 32, 64, 0.12),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking',
                      style: TextStyle(
                        color: AppColors.primaryFixedDim,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '#${booking.id ?? '-'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(
                status: booking.status,
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.12),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(
                Icons.hotel_outlined,
                color: AppColors.secondaryContainer,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hotel?.name ?? 'Hotel',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final String? status;

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status?.toLowerCase();

    final Color backgroundColor;
    final Color textColor;
    final IconData icon;

    switch (normalizedStatus) {
      case 'confirmed':
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        icon = Icons.check_circle_outline;

      case 'completed':
        backgroundColor = AppColors.secondaryContainer;
        textColor = AppColors.onSecondaryFixed;
        icon = Icons.verified_outlined;

      case 'cancelled':
      case 'canceled':
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = AppColors.dangerRed;
        icon = Icons.cancel_outlined;

      case 'pending':
      default:
        backgroundColor = const Color(0xFFFFF8E1);
        textColor = AppColors.secondary;
        icon = Icons.access_time_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 5),
          Text(
            _capitalize(status ?? 'Unknown'),
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;

    return value[0].toUpperCase() + value.substring(1);
  }
}

class _HotelCard extends StatelessWidget {
  const _HotelCard({
    required this.hotel,
  });

  final Hotel? hotel;

  @override
  Widget build(BuildContext context) {
    final image =
        hotel?.mainImg ??
        ((hotel?.images?.isNotEmpty ?? false) ? hotel!.images!.first : null);

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.hotel_outlined,
            title: 'Hotel',
          ),

          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: image != null
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return const _ImagePlaceholder();
                          },
                        )
                      : const _ImagePlaceholder(),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel?.name ?? 'Unknown Hotel',
                      style: const TextStyle(
                        color: AppColors.primaryContainer,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    if (hotel?.address != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 17,
                            color: AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              hotel!.address!,
                              style: const TextStyle(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 8),

                    if (hotel?.rating != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.goldAccent,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            hotel!.rating!,
                            style: const TextStyle(
                              color: AppColors.primaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({
    required this.room,
    required this.roomType,
  });

  final Room? room;
  final RoomType? roomType;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.bed_outlined,
            title: 'Room',
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.softSand,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.king_bed_outlined,
                  color: AppColors.primaryContainer,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomType?.name ?? 'Room',
                      style: const TextStyle(
                        color: AppColors.primaryContainer,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Room ${room?.roomNumber ?? '-'}',
                      style: const TextStyle(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              _RoomStatus(
                status: room?.status,
              ),
            ],
          ),

          if (roomType?.amenities?.isNotEmpty ?? false) ...[
            const SizedBox(height: 18),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: roomType!.amenities!
                  .map(
                    (amenity) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundEnd,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        amenity,
                        style: const TextStyle(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _RoomStatus extends StatelessWidget {
  const _RoomStatus({
    required this.status,
  });

  final String? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status ?? '-',
        style: const TextStyle(
          color: AppColors.primaryContainer,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StayDetailsCard extends StatelessWidget {
  const _StayDetailsCard({
    required this.booking,
  });

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.calendar_month_outlined,
            title: 'Stay Details',
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _DateItem(
                  title: 'Check-in',
                  date: booking.checkIn,
                  icon: Icons.login_rounded,
                ),
              ),

              Container(
                width: 1,
                height: 65,
                color: AppColors.outlineVariant,
              ),

              Expanded(
                child: _DateItem(
                  title: 'Check-out',
                  date: booking.checkOut,
                  icon: Icons.logout_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundEnd,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.nights_stay_outlined,
                  color: AppColors.primaryContainer,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${booking.nights ?? 0} ${booking.nights == 1 ? 'Night' : 'Nights'}',
                  style: const TextStyle(
                    color: AppColors.primaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateItem extends StatelessWidget {
  const _DateItem({
    required this.title,
    required this.date,
    required this.icon,
  });

  final String title;
  final String? date;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.secondary,
            size: 22,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            date ?? '-',
            style: const TextStyle(
              color: AppColors.primaryContainer,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestDetailsCard extends StatelessWidget {
  const _GuestDetailsCard({
    required this.booking,
  });

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    final user = booking.user;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.person_outline,
            title: 'Guest Details',
          ),

          const SizedBox(height: 18),

          _InfoRow(
            icon: Icons.person_outline,
            title: 'Guest Name',
            value: booking.guestName ?? user?.fullName ?? '-',
          ),

          const SizedBox(height: 14),

          _InfoRow(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: booking.guestPhone ?? user?.phone ?? '-',
          ),

          if (user?.email != null) ...[
            const SizedBox(height: 14),
            _InfoRow(
              icon: Icons.email_outlined,
              title: 'Email',
              value: user!.email!,
            ),
          ],
        ],
      ),
    );
  }
}

class _PriceSummaryCard extends StatelessWidget {
  const _PriceSummaryCard({
    required this.booking,
  });

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.receipt_long_outlined,
            title: 'Price Summary',
          ),

          const SizedBox(height: 18),

          _PriceRow(
            title: 'Price per night',
            value: '${booking.pricePerNight ?? '0.00'} \$',
          ),

          const SizedBox(height: 12),

          _PriceRow(
            title: 'Nights',
            value: '${booking.nights ?? 0}',
          ),

          const SizedBox(height: 12),

          _PriceRow(
            title: 'Taxes',
            value: '${booking.taxes ?? '0.00'} \$',
          ),

          const SizedBox(height: 12),

          _PriceRow(
            title: 'Discount',
            value: '- ${booking.discount ?? '0.00'} \$',
            valueColor: const Color(0xFF2E7D32),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: AppColors.outlineVariant,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: AppColors.primaryContainer,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${booking.totalPrice ?? '0.00'} \$',
                style: const TextStyle(
                  color: AppColors.primaryContainer,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.title,
    required this.value,
    this.valueColor,
  });

  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.onSurfaceVariant,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.primaryContainer,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _NotesCard extends StatelessWidget {
  const _NotesCard({
    required this.notes,
  });

  final String notes;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: Icons.notes_outlined,
            title: 'Notes',
          ),

          const SizedBox(height: 14),

          Text(
            notes,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _CancelReasonCard extends StatelessWidget {
  const _CancelReasonCard({
    required this.reason,
  });

  final String reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.dangerRed.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: AppColors.dangerRed,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cancellation Reason',
                  style: TextStyle(
                    color: AppColors.dangerRed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  reason,
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
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.45),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 32, 64, 0.04),
            blurRadius: 18,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.softSand,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryContainer,
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryContainer,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.onSurfaceVariant,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: AppColors.primaryContainer,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundEnd,
      child: const Icon(
        Icons.hotel_outlined,
        color: AppColors.primaryContainer,
        size: 30,
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.secondaryContainer,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline,
                color: AppColors.dangerRed,
                size: 36,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Unable to load booking',
              style: TextStyle(
                color: AppColors.primaryContainer,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.onSurfaceVariant,
                fontSize: 14,
              ),
            ),

            if (onRetry != null) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryContainer,
                  side: const BorderSide(
                    color: AppColors.primaryContainer,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
