import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_decorations.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/profile/presentation/bloc/faq_cubit.dart';

class PopularQuestionsList extends StatelessWidget {
  const PopularQuestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqCubit(),
      child: BlocBuilder<FaqCubit, Set<int>>(
        builder: (context, expandedItems) {
          return Column(
            children: List.generate(faqs.length, (index) {
              final faq = faqs[index];
              final isExpanded = expandedItems.contains(index);
              return _FAQItem(
                question: faq['question']!,
                answer: faq['answer']!,
                isExpanded: isExpanded,
                onTap: () => context.read<FaqCubit>().toggle(index),
              );
            }),
          );
        },
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  const _FAQItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppDecorations.helpCenterCardDecoration,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      question.tr(), // <-- هنا أضفنا .tr()
                      style: AppTextStyles.normal16onSurfaceW500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.outlineVariant,
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Column(
                        children: [
                          const SizedBox(height: 12),
                          const Divider(
                            color: AppColors.outlineVariant,
                            thickness: 0.3,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            answer.tr(), // <-- وهنا أيضاً أضفنا .tr()
                            style: AppTextStyles.normal14onSurfaceVariant,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
