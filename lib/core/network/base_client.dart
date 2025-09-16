import 'package:dio/dio.dart';

class BaseClient {
  static BaseClient? _instance;
  static Dio? _dio;
  BaseClient._();
}
