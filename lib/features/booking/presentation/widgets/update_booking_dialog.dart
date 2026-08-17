import 'package:flutter/material.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/data/models/update_booking_request.dart';

class UpdateBookingDialog extends StatefulWidget {
  final BookingData booking;

  const UpdateBookingDialog({super.key, required this.booking});

  @override
  State<UpdateBookingDialog> createState() => _UpdateBookingDialogState();
}

class _UpdateBookingDialogState extends State<UpdateBookingDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _notesController;
  late TextEditingController _checkInController;
  late TextEditingController _checkOutController;

  @override
  void initState() {
    super.initState();
    // تعبئة الحقول بالبيانات الحالية للحجز
    // ملاحظة: تأكد من أن أسماء المتغيرات (guestName, guestPhone...) تطابق ما هو موجود في موديل BookingData لديك
    _nameController = TextEditingController(
      text: widget.booking.guestName ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.booking.guestPhone ?? '',
    );
    _notesController = TextEditingController(text: widget.booking.notes ?? '');

    // يفضل أن تكون التواريخ بصيغة YYYY-MM-DD
    _checkInController = TextEditingController(
      text: widget.booking.checkIn ?? '',
    );
    _checkOutController = TextEditingController(
      text: widget.booking.checkOut ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  // دالة مساعدة لاختيار التاريخ بسهولة
  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // يمكنك تعديل النطاق الزمني
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // تحويل التاريخ لصيغة YYYY-MM-DD التي يقبلها السيرفر غالباً
        controller.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Booking Info'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // حقل اسم الضيف
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Guest Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // حقل رقم الهاتف
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Guest Phone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // حقل تاريخ الدخول
              TextFormField(
                controller: _checkInController,
                readOnly:
                    true, // يمنع الكتابة اليدوية لضمان استخدام الـ DatePicker
                onTap: () => _selectDate(_checkInController),
                decoration: const InputDecoration(
                  labelText: 'Check-in Date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // حقل تاريخ الخروج
              TextFormField(
                controller: _checkOutController,
                readOnly: true,
                onTap: () => _selectDate(_checkOutController),
                decoration: const InputDecoration(
                  labelText: 'Check-out Date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              // حقل الملاحظات
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(context), // العودة بدون حفظ (يرجع null)
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // إذا كانت جميع الحقول الإجبارية معبأة
            if (_formKey.currentState!.validate() &&
                widget.booking.id != null) {
              // إنشاء الريكويست وإعادته للزر الذي استدعى الـ Dialog
              final updateRequest = UpdateBookingRequest(
                id: widget.booking.id!,
                checkIn: _checkInController.text,
                checkOut: _checkOutController.text,
                guestName: _nameController.text,
                guestPhone: _phoneController.text,
                notes: _notesController.text,
              );
              Navigator.pop(context, updateRequest);
            }
          },
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}
