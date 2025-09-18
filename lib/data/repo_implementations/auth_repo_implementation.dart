import 'dart:convert';
import '../../core/constants/api_endpoints.dart';
import '../../core/network/base_client.dart';
import '../repositories/auth_repository.dart';
import '../models/auth_response_models.dart';

class AuthRepoImpl implements AuthRepo {
  final BaseClient _baseClient = BaseClient.instance;

  @override
  Future<CheckPhoneExistResponse> checkPhoneExist({
    required String phone,
  }) async {
    try {
      final response = await _baseClient.post(
        ApiEndpoints.checkPhoneExist,
        data: {
          'phone': phone,
        },
      );

      final dynamic body = response.data;
      final Map<String, dynamic> jsonMap =
          body is Map<String, dynamic> ? body : json.decode(body as String) as Map<String, dynamic>;

      return CheckPhoneExistResponse.fromJson(jsonMap);
    } catch (e) {
      return CheckPhoneExistResponse.error(
        message: 'Failed to check phone',
        error: e.toString(),
        status: 500,
      );
    }
  }

  @override
  Future forgotPassword({required String phone}) async {
    throw UnimplementedError('forgotPassword not implemented');
  }

  @override
  Future signIn({
    required String phone,
    required String password,
    required String deviceType,
    required String device_info,
  }) async {
    throw UnimplementedError('signIn not implemented');
  }

  @override
  Future signUp({
    required String phone,
    required String password,
    required String deviceType,
    required String device_info,
    required String device_id,
    required String network,
    required String DOB,
    required String country,
    required String country_code,
  }) async {
    throw UnimplementedError('signUp not implemented');
  }
}
