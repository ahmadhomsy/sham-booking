import 'package:flutter/material.dart';

class RoomBookingBar extends StatelessWidget {
  const RoomBookingBar({
    required this.price,
    super.key,
  });

  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price per night',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0F2040),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Book Now',
            ),
          ),
        ],
      ),
    );
  }
}
