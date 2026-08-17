import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
// 🔴 تأكد من أن المسار هنا يطابق مسار ملف المودل في مشروعك
import 'package:sham_booking/features/booking/data/models/get_booking_response.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.booking,
    this.onTap,
  });

  // الآن نستخدم المودل الحقيقي بدلاً من dynamic!
  final BookingModel booking;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // بما أننا نستخدم الـ Model، جميع المتغيرات هنا آمنة ومعروفة النوع (Type-Safe)
    final String hotelName = booking.hotel.name;
    final String status = booking.status;
    final String roomName = booking.room.type.name;
    final String checkIn = booking.checkIn;
    final String checkOut = booking.checkOut;
    final String nights = booking.nights.toString(); // تحويل من int إلى String
    final String totalPrice = booking.totalPrice;

    // جلب الصورة (إذا لم توجد صور للغرفة، نعرض صورة الفندق الرئيسية)
    final String image = booking.room.type.images.isNotEmpty
        ? booking.room.type.images.first
        : booking.hotel.mainImg;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withValues(alpha: 0.3) : AppColors.primary.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      hotelName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusBadge(status),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: Theme.of(context).colorScheme.surface,
                        child: const Icon(
                          Icons.hotel,
                          color: AppColors.outline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          Icons.calendar_month_outlined,
                          '$checkIn  ➔  $checkOut',
                        ),
                        const SizedBox(height: 6),
                        _buildInfoRow(
                          Icons.nightlight_round_outlined,
                          '$nights ${'home.bookings.nights'.tr()}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home.bookings.total_price'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: TextStyle(
                      color: isDark ? AppColors.goldAccent : AppColors.primaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.outline),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    final String text = 'home.bookings.${status.toLowerCase()}'.tr();

    // التلوين بناءً على الحالة الواردة من السيرفر
    final (Color bgColor, Color textColor) = switch (status.toLowerCase()) {
      'completed' => (
        Colors.green.withValues(alpha: 0.1),
        Colors.green.shade700,
      ),
      'cancelled' => (
        AppColors.dangerRed.withValues(alpha: 0.1),
        AppColors.dangerRed,
      ),
      _ => (
        AppColors.secondaryContainer.withValues(alpha: 0.2),
        AppColors.secondary,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
