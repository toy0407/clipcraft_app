import 'package:clipcraft/core/utils/logger.util.dart';
import 'package:clipcraft/core/utils/snackbar.util.dart';
import 'package:clipcraft/data/models/video.model.dart';
import 'package:clipcraft/data/repositories/video.repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final VideoRepository _videoRepository = VideoRepository();

  final RxBool isLoading = false.obs;

  final RxList<VideoModel> videos = <VideoModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString sortBy = 'time'.obs;
  final RxString sortOrder = 'desc'.obs;
  final RxMap<String, dynamic> filters = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  void setSearchQuery(String value) {
    searchQuery.value = value;
  }

  void setSort(String sortBy, String sortOrder) {
    this.sortBy.value = sortBy;
    this.sortOrder.value = sortOrder;
  }

  void setStatusFilter(String value) {
    if (value == 'all') {
      filters.remove('status');
      return;
    }
    filters['status'] = value;
  }

  bool clearFilters() {
    if (filters.isEmpty) {
      return false;
    }
    filters.clear();
    return true;
  }

  Future<void> fetchVideos() async {
    isLoading.value = true;
    try {
      videos.value = await _videoRepository.getVideos(filters: filters, query: searchQuery.value, sortBy: sortBy.value, sortOrder: sortOrder.value);
    } catch (e) {
      Logger.error('Error fetching videos: $e', name: 'HomeController.fetchVideos');
      SnackbarUtil.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
