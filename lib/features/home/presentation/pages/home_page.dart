import 'package:flutter/material.dart';

// لوحة الألوان المأخوذة من تصميم Tailwind
class AppColors {
  static const Color background = Color(0xFFFCF9F8);
  static const Color primaryContainer = Color(0xFF0F2040);
  static const Color secondary = Color(0xFF735C00);
  static const Color secondaryContainer = Color(0xFFFED65B);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F3F2);
  static const Color outlineVariant = Color(0xFFC5C6CF);
  static const Color onSurfaceVariant = Color(0xFF44474E);
  static const Color topBarBackground = Color(0xFFF9F9F7);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قسم البحث الترحيبي
              const _HeroSearchSection(),
              const SizedBox(height: 24),

              // زر عرض الخريطة
              const _MapViewToggle(),
              const SizedBox(height: 48),

              // قسم الفنادق المميزة
              Text(
                'Featured Gems',
                style: const TextStyle(
                  fontFamily: 'NotoSerif',
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryContainer,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 24),

              // قائمة الفنادق
              const _FeaturedGemsList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _CustomBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.topBarBackground,
      elevation: 0,
      scrolledUnderElevation: 0, // لمنع تغيير اللون عند التمرير
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.primaryContainer.withOpacity(0.1),
          height: 1.0,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.primaryContainer),
        onPressed: () {},
      ),
      title: const Text(
        'SHAMBOOK',
        style: TextStyle(
          fontFamily: 'NotoSerif',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColors.primaryContainer,
          letterSpacing: 2.0,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.primaryContainer,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

// =====================================================================
// الويدجت الفرعية
// =====================================================================

class _HeroSearchSection extends StatelessWidget {
  const _HeroSearchSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Discover Levantine Luxury',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'NotoSerif',
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryContainer,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Find your perfect sanctuary in the heart of Syria.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // شريط البحث
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.outlineVariant.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryContainer.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(Icons.search, color: Colors.grey.shade500),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Where would you like to stay?',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapViewToggle extends StatelessWidget {
  const _MapViewToggle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.map_outlined, size: 18),
        label: const Text(
          'MAP VIEW',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryContainer,
          backgroundColor: AppColors.surfaceContainerLowest,
          side: BorderSide(color: AppColors.outlineVariant.withOpacity(0.5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}

class _FeaturedGemsList extends StatelessWidget {
  const _FeaturedGemsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HotelCard(
          title: 'Beit Al Mamlouka',
          location: 'Old Damascus',
          imageUrl:
              'https://images.unsplash.com/photo-1542314831-c53cd4b85ca4?auto=format&fit=crop&q=80', // صورة توضيحية
          rating: '4.9',
          tags: const ['Courtyard', 'Spa', 'Fine Dining'],
          price: '\$280',
          oldPrice: '\$350',
        ),
        const SizedBox(height: 24),
        _HotelCard(
          title: 'The Omayyad Grand',
          location: 'Aleppo City Center',
          imageUrl:
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80',
          rating: '4.8',
          tags: const ['City View', 'Business Lounge'],
          price: '\$190',
        ),
        const SizedBox(height: 24),
        _HotelCard(
          title: 'Palmyra Oasis Resort',
          location: 'Tadmur',
          imageUrl:
              'https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&q=80',
          rating: '5.0',
          tags: const ['Pool', 'Desert Tours', 'All-Inclusive'],
          price: '\$420',
        ),
      ],
    );
  }
}

class _HotelCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String rating;
  final List<String> tags;
  final String price;
  final String? oldPrice;

  const _HotelCard({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.tags,
    required this.price,
    this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryContainer.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة مع التقييم
          Stack(
            children: [
              Image.network(
                imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // تأثير التدرج اللوني أسفل الصورة (Gradient Overlay)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.primaryContainer.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // بطاقة التقييم (Rating)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.secondaryContainer,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // تفاصيل الفندق
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'NotoSerif',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // التاجات (Tags)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 24),
                const Divider(height: 1, color: AppColors.outlineVariant),
                const SizedBox(height: 16),

                // السعر
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (oldPrice != null) ...[
                      Text(
                        oldPrice!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      price,
                      style: const TextStyle(
                        fontFamily: 'NotoSerif',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '/night',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.topBarBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryContainer.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(
        bottom: 24,
        top: 12,
      ), // مراعاة منطقة الـ Safe Area
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(icon: Icons.explore, label: 'Explore', isActive: true),
          _NavBarItem(icon: Icons.search, label: 'Search', isActive: false),
          _NavBarItem(
            icon: Icons.calendar_month,
            label: 'Bookings',
            isActive: false,
          ),
          _NavBarItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? const Color(0xFFD4AF37)
        : AppColors.primaryContainer.withOpacity(0.6);

    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
