import 'package:flutter/material.dart';
import 'package:sham_booking/core/theme/app_text_styles.dart';

class RoomDescriptionSection extends StatefulWidget {
  const RoomDescriptionSection({
    required this.description,
    super.key,
  });

  final String description;

  @override
  State<RoomDescriptionSection> createState() => _RoomDescriptionSectionState();
}

class _RoomDescriptionSectionState extends State<RoomDescriptionSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.description.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About this room',
          style: AppTextStyles.normal28primaryBold,
        ),
        const SizedBox(height: 10),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            widget.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.normal14onSurfaceVariantW400,
          ),
          secondChild: Text(
            widget.description,
            style: AppTextStyles.normal14onSurfaceVariantW400,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Text(
            _expanded ? 'Show less' : 'Read more',
            style: AppTextStyles.normal16primaryW700.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}


