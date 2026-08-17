import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sham_booking/core/theme/app_colors.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HotelVideoSection extends StatefulWidget {
  const HotelVideoSection({
    required this.videoUrl,
    super.key,
  });

  final String videoUrl;

  @override
  State<HotelVideoSection> createState() => _HotelVideoSectionState();
}

class _HotelVideoSectionState extends State<HotelVideoSection> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    final videoId = _extractYoutubeId(widget.videoUrl);

    if (videoId != null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          enableCaption: true,
        ),
      );
    }
  }

  String? _extractYoutubeId(String url) {
    final uri = Uri.tryParse(url);

    if (uri == null) return null;

    // https://www.youtube.com/watch?v=VIDEO_ID
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    }

    // https://youtu.be/VIDEO_ID
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    return null;
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (controller == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience the Hotel',
          style: GoogleFonts.notoSerif(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryContainer,
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: YoutubePlayer(
            controller: controller,
            aspectRatio: 16 / 9,
          ),
        ),
      ],
    );
  }
}
