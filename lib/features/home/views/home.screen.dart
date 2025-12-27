import 'package:clipcraft/features/home/widgets/filter_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:clipcraft/features/home/controllers/home.controller.dart';
import 'package:clipcraft/features/home/widgets/video_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 136,
              toolbarHeight: 56,
              backgroundColor: colorScheme.surface,
              surfaceTintColor: Colors.transparent,
              title: Text('My Library', style: textTheme.titleLarge),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: colorScheme.primary.withAlpha(25),
                    child: Icon(Icons.person, color: colorScheme.primary),
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(64),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: _HomeSearchBar(controller: _homeController),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _FilterSortHeaderDelegate(controller: _homeController, onFilterPressed: _openFilters, colorScheme: colorScheme),
            ),
            _VideoSliverList(controller: _homeController),
          ],
        ),
      ),
    );
  }

  Future<void> _openFilters() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const FractionallySizedBox(heightFactor: 0.5, child: HomeFilterSheet()),
    );
  }
}

/// Search bar component
class _HomeSearchBar extends StatelessWidget {
  const _HomeSearchBar({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SearchBar(
      hintText: 'Search your videos',
      leading: Icon(Icons.search, color: colorScheme.onSurface.withAlpha(128)),
      onChanged: controller.setSearchQuery,
    );
  }
}

// Video sliver list with loading and empty states
class _VideoSliverList extends StatelessWidget {
  const _VideoSliverList({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
      }

      final videos = controller.videos;
      if (videos.isEmpty) {
        return const SliverFillRemaining(child: Center(child: Text('No videos found.')));
      }

      return SliverPadding(
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 16),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index.isOdd) return const SizedBox(height: 8);
            final videoIndex = index ~/ 2;
            return VideoListItem(video: videos[videoIndex]);
          }, childCount: videos.length * 2 - 1),
        ),
      );
    });
  }
}

class _FilterSortHeaderDelegate extends SliverPersistentHeaderDelegate {
  _FilterSortHeaderDelegate({required this.controller, required this.onFilterPressed, required this.colorScheme});

  final HomeController controller;
  final VoidCallback onFilterPressed;
  final ColorScheme colorScheme;

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _FilterButton(controller: controller, onPressed: onFilterPressed),
          _SortButton(controller: controller),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// Filter button with active state indicator
class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.controller, required this.onPressed});

  final HomeController controller;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Obx(() {
      final activeFilterCount = controller.filters.length;
      final isActive = activeFilterCount > 0;

      return TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: isActive ? colorScheme.secondary : colorScheme.onSurface.withAlpha(179),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onPressed: onPressed,
        icon: Icon(Icons.filter_list, size: 18, color: isActive ? colorScheme.secondary : null),
        label: Text(
          isActive ? 'Filter ($activeFilterCount)' : 'Filter',
          style: textTheme.labelLarge?.copyWith(
            color: isActive ? colorScheme.secondary : null,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      );
    });
  }
}

// Sort popup menu button
class _SortButton extends StatelessWidget {
  const _SortButton({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      return PopupMenuButton<String>(
        initialValue: '${controller.sortBy.value}-${controller.sortOrder.value}',
        onSelected: (value) async {
          final parts = value.split('-');
          controller.setSort(parts[0], parts[1]);
          await controller.fetchVideos();
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'time-desc', child: Text('Time - Desc')),
          PopupMenuItem(value: 'time-asc', child: Text('Time - Asc')),
        ],
        child: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.onSurface.withAlpha(179),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          onPressed: null,
          icon: Icon(Icons.sort, size: 18, color: colorScheme.onSurface.withAlpha(179)),
          label: Text('Sort', style: textTheme.labelLarge),
        ),
      );
    });
  }
}
