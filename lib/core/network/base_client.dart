import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_env.dart';
import './network_exception.dart';

class BaseClient {
  static BaseClient? _instance;
  static Dio? _dio;

  // Storage keys
  static const String _authTokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _languageKey = 'language'; // store app language if needed

  BaseClient._();

  /// Get singleton instance
  static BaseClient get instance {
    _instance ??= BaseClient._();
    return _instance!;
  }

  /// Get configured Dio instance
  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  /// Create and configure Dio instance
  Dio _createDio() {
    print(AppEnv.baseUrl);
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEnv.baseUrl,
        connectTimeout: Duration(milliseconds: AppEnv.apiTimeout),
        receiveTimeout: Duration(milliseconds: AppEnv.apiTimeout),
        sendTimeout: Duration(milliseconds: AppEnv.apiTimeout),
        // Do not throw exceptions for non-2xx so callers can handle (e.g. 404 new user)
        validateStatus: (int? status) => true,
      ),
    );

    // Interceptor for setting headers dynamically
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();

          final token = prefs.getString(_authTokenKey) ?? '';
          final lang = prefs.getString(_languageKey) ?? 'en';

          options.headers.addAll({
            'Authorization': token.isNotEmpty ? token : 'UP!and\$',
            'app_id': '1',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'lang': lang,
          });

          return handler.next(options);
        },
      ),
    );

    return dio;
  }

  /// ====== API Methods ======

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      print(e);
      throw NetworkException.fromDioError(e);
    }
  }

  /// ====== Token management using SharedPreferences ======

  static Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, lang);
  }

  static Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    await prefs.remove(_userIdKey);
  }

  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_authTokenKey);
    return token != null && token.isNotEmpty;
  }

  static Future<String?> get token async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  static Future<String?> get userId async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }
}
