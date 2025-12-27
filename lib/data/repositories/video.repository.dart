import 'package:clipcraft/data/datasources/remote/video.api.dart';
import 'package:clipcraft/data/models/video.model.dart';

class VideoRepository {
  VideoRepository._internal();
  static final VideoRepository _instance = VideoRepository._internal();
  factory VideoRepository() => _instance;

  Future<List<VideoModel>> getVideos({Map<String, dynamic>? filters, String? query, String? sortBy, String? sortOrder}) async {
    final result = await VideoApi().getVideosByQuery(filters: filters, query: query, sortBy: sortBy, sortOrder: sortOrder);

    return result.map<VideoModel>((json) => VideoModel.fromMap(json)).toList();
  }
}
