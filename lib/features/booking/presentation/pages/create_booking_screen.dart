import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
// تأكد من استيراد مسارات ملفاتك الصحيحة هنا
import 'package:sham_booking/features/booking/data/models/create_booking_request.dart';
import 'package:sham_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:sham_booking/injection_container.dart' as di;

enum PaymentMethodType { cash, stripe }

class CreateBookingScreen extends StatelessWidget {
  const CreateBookingScreen({
    required this.roomId,
    required this.hotelId,
    // تم إزالة checkIn و checkOut من هنا
    super.key,
  });

  final int roomId;
  final int hotelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<BookingBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundStart,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'إتمام الحجز',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: _CreateBookingView(
          roomId: roomId,
          hotelId: hotelId,
        ),
      ),
    );
  }
}

class _CreateBookingView extends StatefulWidget {
  const _CreateBookingView({
    required this.roomId,
    required this.hotelId,
  });

  final int roomId;
  final int hotelId;

  @override
  State<_CreateBookingView> createState() => _CreateBookingViewState();
}

class _CreateBookingViewState extends State<_CreateBookingView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  // متغيرات التواريخ
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  PaymentMethodType _selectedPaymentMethod = PaymentMethodType.cash;
  bool _isCardComplete = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // دالة اختيار التواريخ
  Future<void> _selectDateRange() async {
    final pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(), // لا يمكن الحجز بالماضي
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ), // متاح لسنة للأمام
      builder: (context, child) {
        // تخصيص ألوان الـ DatePicker لتتناسب مع ألوان تطبيقك
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surfaceContainerLowest,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        _checkInDate = pickedRange.start;
        _checkOutDate = pickedRange.end;
      });
    }
  }

  // دالة مساعدة لتنسيق التاريخ (مثال: 2024-05-12)
  String _formatDate(DateTime date) {
    // هذا التنسيق يطابق تماماً ما أرسلته ونجح معك
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == BookingStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'حدث خطأ غير متوقع'),
              backgroundColor: AppColors.dangerRed,
            ),
          );
        } else if (state.status == BookingStatus.createSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم الحجز بنجاح!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('تفاصيل الحجز'),
              SizedBox(height: 16.h),

              // --- حقل اختيار التواريخ ---
              GestureDetector(
                onTap: _selectDateRange,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: _checkInDate == null
                          ? AppColors.outlineVariant
                          : AppColors.primary, // يتغير لون الحدود عند الاختيار
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          _checkInDate == null || _checkOutDate == null
                              ? 'حدد تاريخ الدخول والمغادرة'
                              : 'من: ${_formatDate(_checkInDate!)}\nإلى: ${_formatDate(_checkOutDate!)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: _checkInDate == null
                                ? AppColors.onSurfaceVariant
                                : AppColors.onSurface,
                            fontWeight: _checkInDate == null
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      if (_checkInDate == null)
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.sp,
                          color: AppColors.outline,
                        ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32.h),
              _buildSectionTitle('بيانات الضيف'),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: _nameController,
                label: 'الاسم الكامل',
                icon: Icons.person_outline,
                validator: (value) => value == null || value.isEmpty
                    ? 'الرجاء إدخال الاسم'
                    : null,
              ),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: _phoneController,
                label: 'رقم الهاتف',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? 'الرجاء إدخال رقم الهاتف'
                    : null,
              ),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: _notesController,
                label: 'ملاحظات إضافية (اختياري)',
                icon: Icons.notes,
                maxLines: 3,
              ),
              SizedBox(height: 32.h),

              _buildSectionTitle('طريقة الدفع'),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _buildPaymentOption(
                      title: 'الدفع عند الوصول',
                      icon: Icons.money,
                      value: PaymentMethodType.cash,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildPaymentOption(
                      title: 'بطاقة ائتمانية',
                      icon: Icons.credit_card,
                      value: PaymentMethodType.stripe,
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _selectedPaymentMethod == PaymentMethodType.stripe
                    ? Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'بيانات البطاقة',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColors.outlineVariant,
                                ),
                              ),
                              child: CardField(
                                onCardChanged: (card) {
                                  setState(() {
                                    _isCardComplete = card?.complete ?? false;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: AppColors.outline,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              SizedBox(height: 40.h),
              BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  final isLoading = state.status == BookingStatus.loading;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.secondaryFixed,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                    onPressed: isLoading ? null : () => _submitBooking(context),
                    child: isLoading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.secondaryFixed,
                          )
                        : Text(
                            'تأكيد الحجز',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryContainer,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.onSurfaceVariant),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.dangerRed),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required IconData icon,
    required PaymentMethodType value,
  }) {
    final isSelected = _selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryFixedDim
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.outline,
              size: 28.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8.h),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.outline,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _submitBooking(BuildContext context) {
    // 1. التحقق من اختيار التواريخ أولاً
    if (_checkInDate == null || _checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء تحديد تاريخ الدخول والمغادرة'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 2. التحقق من صحة الفورم (الاسم، الهاتف)
    if (_formKey.currentState!.validate()) {
      // 3. التحقق من بيانات البطاقة البنكية إذا تم اختيارها
      if (_selectedPaymentMethod == PaymentMethodType.stripe &&
          !_isCardComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('الرجاء إكمال بيانات البطاقة البنكية بشكل صحيح'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final isStripe = _selectedPaymentMethod == PaymentMethodType.stripe;

      final request = CreateBookingRequest(
        hotelId: widget.hotelId,
        roomId: widget.roomId,
        checkIn: _formatDate(_checkInDate!), // تحويل التاريخ لنص
        checkOut: _formatDate(
          _checkOutDate!,
        ),
        // checkIn: "2026-04-08", // تحويل التاريخ لنص
        // checkOut: "2026-04-09", // تحويل التاريخ لنص
        guestName: _nameController.text.trim(),
        guestPhone: _phoneController.text.trim(),
        notes: _notesController.text.trim(),
        paymentMethod: isStripe ? 'Stripe' : 'Cash',
      );

      context.read<BookingBloc>().add(
        SubmitCreateBookingEvent(
          request: request,
          isStripe: isStripe,
        ),
      );
    }
  }
}
