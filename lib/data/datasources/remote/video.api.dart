import 'package:clipcraft/core/utils/network.util.dart';

class VideoApi {
  VideoApi._internal();
  static final VideoApi _instance = VideoApi._internal();
  factory VideoApi() => _instance;

  Future<dynamic> getVideosByQuery({Map<String, dynamic>? filters, String? query, String? sortBy = "time", String? sortOrder = "desc"}) async {
    final params = <String, dynamic>{};
    if (filters != null && filters.isNotEmpty) {
      for (final entry in filters.entries) {
        dynamic value = entry.value;
        if (value != null) {
          if (value is String && value.trim().isNotEmpty) {
            params[entry.key] = value.trim();
          } else if (value is List && value.isNotEmpty) {
            params[entry.key] = value.join(',');
          } else if (value is bool) {
            params[entry.key] = value;
          }
        }
      }
    }
    if (query != null && query.trim().isNotEmpty) {
      params['q'] = query.trim();
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      params['sortBy'] = sortBy;
    }
    if (sortOrder != null && sortOrder.isNotEmpty) {
      params['sortOrder'] = sortOrder;
    }
    await Future.delayed(const Duration(seconds: 1));
    return NetworkUtil.get('/videos', params: params.isEmpty ? null : params, sendAccessToken: true);
  }
}
