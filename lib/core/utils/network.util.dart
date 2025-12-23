import 'dart:convert';
import 'dart:async';
import 'package:clipcraft/core/constants/app_config.constants.dart';
import 'package:clipcraft/core/constants/shared_prefs.constants.dart';
import 'package:clipcraft/core/utils/logger.util.dart';
import 'package:clipcraft/core/utils/shared_prefs.utils.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  NetworkUtil._internal();
  static final NetworkUtil _instance = NetworkUtil._internal();
  factory NetworkUtil() => _instance;

  static String baseUrl = AppConfigConstants.apiBaseUrl;
  static int timeoutDurationInSeconds = 20;

  static Future<Map<String, String>> getHeaders({bool sendAccessToken = false, Map<String, String>? additionalHeaders}) async {
    Map<String, String> headers = {};

    // Set default headers
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    headers['Connection'] = 'keep-alive';

    // Send Access token if necessary
    if (sendAccessToken) {
      Logger.debug('Fetching access token', name: 'NetworkUtil.getHeaders');
      String? accessToken = SharedPrefsUtil.getString(SharedPrefsConstants.ACCESS_TOKEN);
      if (accessToken == null) {
        throw Exception('Unauthenticated user');
      }
      headers['Authorization'] = 'Bearer $accessToken';
    }

    // Send other headers as and when required
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    return headers;
  }

  // Checks if the device has an active internet connection by pinging a reliable endpoint.
  static Future<bool> hasInternetConnection() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com/generate_204')).timeout(Duration(seconds: timeoutDurationInSeconds));
      return response.statusCode == 204;
    } on TimeoutException {
      return false;
    } catch (e) {
      return false;
    }
  }

  static Uri _buildUri(String endpoint, [Map<String, dynamic>? params]) {
    return Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
  }

  static dynamic _processApiResponse(http.Response response) {
    Logger.debug('API Response Status: ${response.statusCode}', name: 'NetworkUtil._processApiResponse');
    Logger.debug('API Response Body: ${response.body}', name: 'NetworkUtil._processApiResponse');
    final decoded = jsonDecode(response.body);
    if (decoded['success'] == true && decoded is Map<String, dynamic>) {
      return decoded['data'];
    } else {
      throw Exception(decoded['error'] ?? 'Request failed');
    }
  }

  static Future<dynamic> get(String endpoint, {Map<String, dynamic>? params, Map<String, String>? headers, bool sendAccessToken = false}) async {
    try {
      if (await hasInternetConnection() == false) {
        throw Exception('No internet connection');
      }
      final uri = _buildUri(endpoint, params);
      final finalHeaders = await getHeaders(additionalHeaders: headers, sendAccessToken: sendAccessToken);
      final response = await http.get(uri, headers: finalHeaders).timeout(Duration(seconds: timeoutDurationInSeconds));
      return _processApiResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  static Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    dynamic body,
    bool sendAccessToken = false,
    Encoding? encoding,
  }) async {
    try {
      if (await hasInternetConnection() == false) {
        throw Exception('No internet connection');
      }
      final uri = _buildUri(endpoint, params);
      final finalHeaders = await getHeaders(additionalHeaders: headers, sendAccessToken: sendAccessToken);
      Logger.debug('POST Request to $uri with body: $body', name: 'NetworkUtil.post');
      final response = await http
          .post(uri, headers: finalHeaders, body: body != null ? jsonEncode(body) : null, encoding: encoding)
          .timeout(Duration(seconds: timeoutDurationInSeconds));
      Logger.debug('POST Response from $uri: ${response.body}', name: 'NetworkUtil.post');
      return _processApiResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  static Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    dynamic body,
    bool sendAccessToken = false,
    Encoding? encoding,
  }) async {
    try {
      if (await hasInternetConnection() == false) {
        throw Exception('No internet connection');
      }
      final uri = _buildUri(endpoint, params);
      final finalHeaders = await getHeaders(additionalHeaders: headers, sendAccessToken: sendAccessToken);
      final response = await http
          .put(uri, headers: finalHeaders, body: body != null ? jsonEncode(body) : null, encoding: encoding)
          .timeout(Duration(seconds: timeoutDurationInSeconds));
      return _processApiResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  static Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    dynamic body,
    bool sendAccessToken = false,
    Encoding? encoding,
  }) async {
    try {
      if (await hasInternetConnection() == false) {
        throw Exception('No internet connection');
      }
      final uri = _buildUri(endpoint, params);
      final finalHeaders = await getHeaders(additionalHeaders: headers, sendAccessToken: sendAccessToken);
      final response = await http
          .patch(uri, headers: finalHeaders, body: body != null ? jsonEncode(body) : null, encoding: encoding)
          .timeout(Duration(seconds: timeoutDurationInSeconds));
      return _processApiResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }

  static Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    dynamic body,
    bool sendAccessToken = false,
    Encoding? encoding,
  }) async {
    try {
      if (await hasInternetConnection() == false) {
        throw Exception('No internet connection');
      }
      final uri = _buildUri(endpoint, params);
      final finalHeaders = await getHeaders(additionalHeaders: headers, sendAccessToken: sendAccessToken);
      final response = await http
          .delete(uri, headers: finalHeaders, body: body != null ? jsonEncode(body) : null, encoding: encoding)
          .timeout(Duration(seconds: timeoutDurationInSeconds));
      return _processApiResponse(response);
    } on TimeoutException {
      throw Exception('Request timed out');
    }
  }
}
