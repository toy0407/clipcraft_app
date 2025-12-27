import 'package:clipcraft/features/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFilterSheet extends StatefulWidget {
  const HomeFilterSheet({super.key});

  @override
  State<HomeFilterSheet> createState() => _HomeFilterSheetState();
}

class _HomeFilterSheetState extends State<HomeFilterSheet> {
  final HomeController controller = Get.find<HomeController>();
  late String statusFilter;

  @override
  void initState() {
    super.initState();
    statusFilter = controller.filters['status'] ?? 'all';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filters', style: textTheme.titleLarge),
          const SizedBox(height: 16),
          Text('Status', style: textTheme.labelLarge),
          const SizedBox(height: 8),
          _StatusFilterChips(selectedStatus: statusFilter, onStatusChanged: (value) => setState(() => statusFilter = value)),
          const Spacer(),
          _FilterActions(onClear: _handleClear, onApply: _handleApply),
        ],
      ),
    );
  }

  void _handleClear() {
    final changed = controller.clearFilters();
    Navigator.of(context).pop();
    if (changed) {
      controller.fetchVideos();
    }
  }

  void _handleApply() {
    controller.setStatusFilter(statusFilter);
    Navigator.of(context).pop();
    controller.fetchVideos();
  }
}

// Status filter chips widget
class _StatusFilterChips extends StatelessWidget {
  const _StatusFilterChips({required this.selectedStatus, required this.onStatusChanged});

  final String selectedStatus;
  final ValueChanged<String> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: [_buildChip('All', 'all'), _buildChip('Finished', 'finished'), _buildChip('Queued', 'queued')]);
  }

  Widget _buildChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedStatus == value,
      onSelected: (selected) {
        if (selected) onStatusChanged(value);
      },
    );
  }
}

// Filter action buttons
class _FilterActions extends StatelessWidget {
  const _FilterActions({required this.onClear, required this.onApply});

  final VoidCallback onClear;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: onClear, child: const Text('Clear')),
        const SizedBox(width: 8),
        FilledButton(onPressed: onApply, child: const Text('Apply')),
      ],
    );
  }
}
