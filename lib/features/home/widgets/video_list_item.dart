import 'package:clipcraft/core/theme/app_colors.dart';
import 'package:clipcraft/core/utils/datetime.util.dart';
import 'package:clipcraft/data/models/video.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({super.key, required this.video});

  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary.withValues(alpha: 0.07),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              video.thumbnailUrl == null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Container(
                        width: double.infinity,
                        height: Get.width * 9 / 21,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: _getRandomGradientColors()),
                        ),
                        child: const Center(child: Icon(Icons.videocam_off, size: 40, color: Colors.white70)),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(video.thumbnailUrl!, width: double.infinity, fit: BoxFit.cover),
                    ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.black.withAlpha(179), borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    DateTimeUtil().formatSecondsToHMS(video.duration),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        video.title ?? 'Untitled',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(width: 6),
                    _buildStatusChip(context, video.status),
                  ],
                ),
                Row(
                  children: [
                    if (video.language != null) ...[_buildInfoChip(context, video.language!), const SizedBox(width: 6)],
                    _buildInfoChip(context, video.style),
                    const Spacer(),
                    Text(
                      DateTimeUtil().formatRelativeTime(video.updatedAt ?? video.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: Colors.grey),
                    ),
                    PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_vert, size: 24, color: Colors.grey),
                      onSelected: (value) {
                        // TODO: Handle update/delete
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
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

  Widget _buildInfoChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceDim, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10)),
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    final statusData = _getStatusStyle(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: statusData['bgColor'], borderRadius: BorderRadius.circular(12)),
      child: Text(
        status.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w600, color: statusData['textColor']),
      ),
    );
  }

  Map<String, Color> _getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'finished':
      case 'completed':
        return {'bgColor': Colors.green.withValues(alpha: 0.4), 'textColor': Colors.green.shade200};
      case 'queued':
      case 'pending':
        return {'bgColor': Colors.orange.withValues(alpha: 0.4), 'textColor': Colors.orange.shade200};
      case 'processing':
      case 'in_progress':
        return {'bgColor': Colors.blue.withValues(alpha: 0.4), 'textColor': Colors.blue.shade200};
      case 'failed':
      case 'error':
        return {'bgColor': Colors.red.withValues(alpha: 0.4), 'textColor': Colors.red.shade200};
      default:
        return {'bgColor': Colors.grey.withValues(alpha: 0.4), 'textColor': Colors.grey.shade200};
    }
  }

  List<Color> _getRandomGradientColors() {
    // Use video ID to generate consistent random colors
    final hash = video.id.hashCode;

    // Material Design color palettes
    final colorPalettes = [
      [Colors.purple.shade400, Colors.deepPurple.shade600, Colors.indigo.shade700],
      [Colors.blue.shade400, Colors.cyan.shade600, Colors.teal.shade700],
      [Colors.green.shade400, Colors.lightGreen.shade600, Colors.lime.shade700],
      [Colors.orange.shade400, Colors.deepOrange.shade600, Colors.red.shade700],
      [Colors.pink.shade400, Colors.purple.shade600, Colors.deepPurple.shade700],
      [Colors.indigo.shade400, Colors.blue.shade600, Colors.lightBlue.shade700],
      [Colors.teal.shade400, Colors.green.shade600, Colors.lightGreen.shade700],
      [Colors.amber.shade400, Colors.orange.shade600, Colors.deepOrange.shade700],
    ];

    final selectedPalette = colorPalettes[hash.abs() % colorPalettes.length];
    return selectedPalette;
  }
}
