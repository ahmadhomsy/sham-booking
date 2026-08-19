import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';
import 'package:sham_booking/features/home/presentation/bloc/get_book_bloc.dart';
import 'package:sham_booking/features/home/presentation/bloc/home_rooms_bloc.dart';
import 'package:sham_booking/features/home/presentation/bloc/hotel_bloc.dart';
import 'package:sham_booking/features/home/presentation/widgets/books_widget.dart';
import 'package:sham_booking/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:sham_booking/features/home/presentation/widgets/explore_widget.dart';
import 'package:sham_booking/features/home/presentation/widgets/rooms_widget.dart';
import 'package:sham_booking/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:sham_booking/features/profile/presentation/pages/profile_page.dart';
import 'package:sham_booking/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _hideController;
  final double _scrollDistanceToHide = 100;

  final List<Widget> _pages = [
    const ExploreWidget(),
    const RoomsWidget(),
    const BooksWidget(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _hideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 0,
    );
  }

  @override
  void dispose() {
    _hideController.dispose();
    super.dispose();
  }

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    await _hideController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<HotelBloc>()..add(GetAllHotelsEvent()),
        ),
        BlocProvider(
          create: (_) => sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<HomeRoomsBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<GetBookBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundStart,
        extendBody: true,
        body: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  if (notification.metrics.pixels <=
                      notification.metrics.minScrollExtent) {
                    if (_hideController.value > 0.0) {
                      unawaited(
                        _hideController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeOut,
                        ),
                      );
                    }
                    return false;
                  }

                  if (notification.metrics.outOfRange) {
                    unawaited(_hideController.reverse());
                    return false;
                  }

                  final delta = notification.scrollDelta ?? 0.0;
                  _hideController.value += delta / _scrollDistanceToHide;
                } else if (notification is ScrollEndNotification) {
                  if (_hideController.value > 0.0 &&
                      _hideController.value < 1.0) {
                    if (_hideController.value > 0.5) {
                      unawaited(_hideController.forward());
                    } else {
                      unawaited(_hideController.reverse());
                    }
                  }
                }
                return false;
              },
              child: IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
            ),

            AnimatedBuilder(
              animation: _hideController,
              builder: (context, child) {
                final height = kToolbarHeight + topPadding;
                return Positioned(
                  top: -height * _hideController.value,
                  left: 0,
                  right: 0,
                  height: height,
                  child: child!,
                );
              },
              child: _buildAppBar(context),
            ),
          ],
        ),

        bottomNavigationBar: AnimatedBuilder(
          animation: _hideController,
          builder: (context, child) {
            return FractionalTranslation(
              translation: Offset(0, _hideController.value),
              child: child,
            );
          },
          child: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.topBarBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: AppColors.primaryContainer.withValues(alpha: 0.1),
          height: 1,
        ),
      ),
      title: const Text(
        'SHAM BOOK',
        style: AppTextStyles.notoSerif20primaryContainerBold,
      ),
      centerTitle: true,
    );
  }
}
