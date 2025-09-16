import '../models/auth_response_models.dart';

abstract class AuthRepo {
  Future<CheckPhoneExistResponse> checkPhoneExist({required String phone});
  Future signIn({
    required String phone,
    required String password,
    required String deviceType,
    required String device_info,
  });
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
  });
  Future forgotPassword({required String phone});
}
