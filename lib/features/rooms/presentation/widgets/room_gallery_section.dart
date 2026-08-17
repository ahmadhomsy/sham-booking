import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_colors.dart';

class RoomGallerySection extends StatefulWidget {
  const RoomGallerySection({
    required this.images,
    required this.heroTag,
    super.key,
  });

  final List<String> images;
  final String heroTag;

  @override
  State<RoomGallerySection> createState() => _RoomGallerySectionState();
}

class _RoomGallerySectionState extends State<RoomGallerySection> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Icon(Icons.image_not_supported_outlined, color: AppColors.primary),
        ),
      );
    }

    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final image = widget.images[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) {
                        return FullScreenImageViewer(
                          images: widget.images,
                          initialIndex: index,
                          heroTag: widget.heroTag,
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: '${widget.heroTag}-$index',
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) {
                      return Container(
                        color: AppColors.surfaceContainer,
                      );
                    },
                    errorWidget: (_, __, ___) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 40,
                          color: AppColors.dangerRed,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          // Gradient
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Image counter
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentIndex + 1}/${widget.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Dots
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) {
                  final selected = index == _currentIndex;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: selected ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImageViewer extends StatefulWidget {
  const FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
    required this.heroTag,
    super.key,
  });

  final List<String> images;
  final int initialIndex;
  final String heroTag;

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.initialIndex;

    _controller = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: Hero(
                    tag: '${widget.heroTag}-$index',
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ViewerButton(
                    icon: Icons.close,
                    onTap: () => Navigator.pop(context),
                  ),
                  _ViewerButton(
                    icon: Icons.photo_library_outlined,
                    label: '${_currentIndex + 1}/${widget.images.length}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewerButton extends StatelessWidget {
  const _ViewerButton({
    required this.icon,
    this.label,
    this.onTap,
  });

  final IconData icon;
  final String? label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.close,
              color: Colors.white,
            ),
            if (label != null) ...[
              const SizedBox(width: 6),
              Text(
                label!,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
