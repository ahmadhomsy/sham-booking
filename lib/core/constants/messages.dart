import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const String initializationErrorMessage = 'initialization_error_message';
const String unknownError = 'unknown_error';
const String offlineError = 'offline_error';

const List<Map<String, String>> onBoardingList = [
  {
    'image': 'assets/images/onboarding1.webp',
    'title': 'onboarding.discover_damascus.title',
    'description': 'onboarding.discover_damascus.description',
  },
  {
    'image': 'assets/images/onboarding2.webp',
    'title': 'onboarding.luxurious_damascene_experience.title',
    'description': 'onboarding.luxurious_damascene_experience.description',
  },
  {
    'image': 'assets/images/onboarding3.webp',
    'title': 'onboarding.your_journey_starts_here.title',
    'description': 'onboarding.your_journey_starts_here.description',
  },
];
final faqs = <Map<String, String>>[
  {
    'question': 'faq.item_1.question',
    'answer': 'faq.item_1.answer',
  },
  {
    'question': 'faq.item_2.question',
    'answer': 'faq.item_2.answer',
  },
  {
    'question': 'faq.item_3.question',
    'answer': 'faq.item_3.answer',
  },
];
final List<Map<String, dynamic>> categories = [
  {
    'title': 'help_center.categories.bookings'.tr(),
    'icon': Icons.calendar_month_outlined,
  },
  {
    'title': 'help_center.categories.payments'.tr(),
    'icon': Icons.payments_outlined,
  },
  {
    'title': 'help_center.categories.loyalty'.tr(),
    'icon': Icons.workspace_premium_outlined,
  },
  {
    'title': 'help_center.categories.account'.tr(),
    'icon': Icons.lock_outline,
  },
  {
    'title': 'help_center.categories.travel'.tr(),
    'icon': Icons.flight_takeoff_outlined,
  },
  {
    'title': 'help_center.categories.concierge'.tr(),
    'icon': Icons.support_agent_outlined,
  },
];
