// import 'package:flutter/material.dart';
//
// class HotelHeroSection extends StatelessWidget {
//   const HotelHeroSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // الصورة الرئيسية
//         Image.network(
//           "https://lh3.googleusercontent.com/aida-public/AB6AXuAePCYZAsw6KERA2uTnU4LL907FjRDfmGzttOUvFvZ9f9-cDwovVdy-zaOIV1xFGAdfEHhhvV_Jxg3lC40Zzfg_29gbT9873-89LrhIqcoO345V_qyDHWntAZtitjqa3ha6YV2ErQP7FMunqho4WrJpZrVLbP43cgOQzIn9UojBGrgRB6iPtxusq5NUvU9FFR6KSyZblaBWDATXKLg8YK-keiwa-VxLKcVLNKSUlUgmW83H31S1flfAniXX1nN1WcLYepmoaeyvdOM",
//           height: 530,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//         // تراكب التدرج اللوني
//         Positioned.fill(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.transparent,
//                   AppColors.primary.withOpacity(0.2),
//                   AppColors.primary.withOpacity(0.8),
//                 ],
//                 stops: const [0.0, 0.4, 1.0],
//               ),
//             ),
//           ),
//         ),
//         // محتوى النص (أسفل اليسار)
//         Positioned(
//           bottom: 32,
//           left: 24,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: List.generate(
//                   5,
//                   (index) => const Icon(
//                     Icons.star,
//                     color: AppColors.secondaryContainer,
//                     size: 24,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text("The Umayyad Palace", style: AppTypography.h1),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   const Icon(
//                     Icons.location_on,
//                     color: AppColors.onSurfaceVariant,
//                     size: 18,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "Damascus, Old City",
//                     style: AppTypography.bodyLg.copyWith(
//                       color: AppColors.onSurfaceVariant.withOpacity(0.9),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // معرض الصور العائم (أسفل اليمين)
//         Positioned(
//           bottom: 32,
//           right: 24,
//           child: Row(
//             children: [
//               // مصغرة 1
//               Container(
//                 width: 64,
//                 height: 64,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.2),
//                     width: 2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(2),
//                   child: Image.network(
//                     "https://lh3.googleusercontent.com/aida-public/AB6AXuA20NUAgpVC-A1qU4ZOO7CnQqkOGUoFpo1bg65gnjHklaMjBj1WLKka_KWVq6IHPUH5RcvFzLYn-kteB3cepMfWXqfWnGgDbXLH31ECF9sjOOjR9iDwFGmxv8lLfE4C9qFklPjGQB40Ssy9m88NIvK_HKRASKEWedTe5HRbsCCTqSQiZ4DX2sjYsBgyacXTbeZUZkV0AC6DNqFVQzLSTVHXyqCxww7NUx2iyBQEJEa3Ix0JL0HrJ69mZhAWmg-yjNvnqGHhtIuHHeg",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               // مصغرة 2 مع تغبيش
//               Container(
//                 width: 64,
//                 height: 64,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.2),
//                     width: 2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(2),
//                   child: Stack(
//                     children: [
//                       Image.network(
//                         "https://lh3.googleusercontent.com/aida-public/AB6AXuC79mRpwg5nxlE2vrDvYFt1hxGJUk-U6km6FKiT9UvDEJtTZvZq9Yu2zpQUER9H3b8kZBrgfe2h99FUBm6gKskJqh9wqMLBSjtixKjV37vsq34g0FeCdkCNztwx59C_aPHVSG0D5vXkOxNH7Foor2vZ2hWqjOT5E-K_HfLoqBug7C_20MbdgEROajsQ_qnKmcaPjNAfdLx6EYQ7qOqeNyZRqqHzCxLbpQv6edkFhk_laqN8ryBqpc4M1yrjaxdH4LCQM8_duKkGgec",
//                         fit: BoxFit.cover,
//                         width: 64,
//                         height: 64,
//                       ),
//                       Positioned.fill(
//                         child: BlurryContainer(
//                           blur: 4,
//                           color: AppColors.primary.withOpacity(0.6),
//                           borderRadius: BorderRadius.zero,
//                           child: const Center(
//                             child: Text(
//                               "+12",
//                               style: TextStyle(
//                                 fontFamily: 'Plus Jakarta Sans',
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.onPrimary,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
