import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 72, this.width = 72});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Hero(
      tag: 'app_logo_hero',
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: colorScheme.primary.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 6))],
          ),
          child: Icon(Icons.video_collection_outlined, color: colorScheme.primary, size: 36),
        ),
      ),
    );
  }
}
