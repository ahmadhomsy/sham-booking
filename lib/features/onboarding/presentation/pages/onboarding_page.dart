import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:sham_booking/features/onboarding/presentation/widgets/bottom_controls.dart';
import 'package:sham_booking/features/onboarding/presentation/widgets/onboarding_background_and_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: context.read<OnBoardingCubit>().state,
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    for (final pageData in onBoardingList) {
      await precacheImage(AssetImage(pageData['image']!), context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<OnBoardingCubit, int>(
        builder: (context, currentPage) {
          return Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<OnBoardingCubit>().changePage(index);
                },
                itemCount: onBoardingList.length,
                itemBuilder: (context, index) {
                  final pageData = onBoardingList[index];
                  return OnboardingBackgroundAndText(
                    image: pageData['image']!,
                    title: pageData['title']!,
                    desc: pageData['desc']!,
                  );
                },
              ),

              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: BottomControls(
                      currentPage: currentPage,
                      onNext: () async {
                        if (currentPage < onBoardingList.length - 1) {
                          await _pageController.animateToPage(
                            currentPage + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          await context.read<OnBoardingCubit>().finishPage();
                          if (context.mounted) {
                            context.go('/signIn');
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
