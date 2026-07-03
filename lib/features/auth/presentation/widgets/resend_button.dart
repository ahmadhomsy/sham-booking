import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/extension/sized_box_extension.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/auth/presentation/bloc/auth/auth_bloc.dart';

class ResendButton extends StatelessWidget {
  const ResendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.surfaceContainerLow,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: const Icon(Icons.refresh, size: 18),
        label: const Text(
          'RESEND CODE',
          style: AppTextStyles.normal12W600,
        ),
        onPressed: () {
          context.read<AuthBloc>().add(
            SendVerificationCodeEvent(),
          );
        },
      ),
    );
  }
}

// class ActionButtons extends StatelessWidget {
//   const ActionButtons({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // SizedBox(
//         //   width: double.infinity,
//         //   height: 56,
//         //   child: ElevatedButton(
//         //     style: ElevatedButton.styleFrom(
//         //       backgroundColor: AppColors.primary,
//         //       foregroundColor: Colors.white,
//         //       shape: RoundedRectangleBorder(
//         //         borderRadius: BorderRadius.circular(
//         //           30,
//         //         ),
//         //       ),
//         //       elevation: 4,
//         //       shadowColor: AppColors.primary.withValues(alpha: 0.4),
//         //     ),
//         //     onPressed: () {},
//         //     child: Row(
//         //       mainAxisAlignment: MainAxisAlignment.center,
//         //       children: [
//         //         const Text(
//         //           'VERIFY NOW',
//         //           style: AppTextStyles.normal12W600,
//         //         ),
//         //         8.horizontalSpace,
//         //         const Icon(Icons.arrow_forward, size: 18),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         // 16.verticalSpace,
//         SizedBox(
//           width: double.infinity,
//           height: 56,
//           child: TextButton.icon(
//             style: TextButton.styleFrom(
//               backgroundColor: AppColors.surfaceContainerLow,
//               foregroundColor: AppColors.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//             ),
//             icon: const Icon(Icons.refresh, size: 18),
//             label: const Text(
//               'RESEND CODE',
//               style: AppTextStyles.normal12W600,
//             ),
//             onPressed: () {},
//           ),
//         ),
//       ],
//     );
//   }
// }
