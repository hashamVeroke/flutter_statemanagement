import '../../../data/models/auth_response_models.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class CheckPhoneExistSuccess extends AuthState {
  final CheckPhoneExistResponse response;
  CheckPhoneExistSuccess(this.response);
}
