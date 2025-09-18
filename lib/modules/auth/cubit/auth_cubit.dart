import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  Future<void> checkPhoneExist(String phone) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.checkPhoneExist(phone: phone);

      if (response.status == 200 || response.status == 404) {
        // Pass the whole response forward
        emit(CheckPhoneExistSuccess(response));
      } else {
        emit(AuthError(response.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
