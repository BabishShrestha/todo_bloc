import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_riverpod/features/auth/bloc/auth_state.dart';
import 'package:todo_riverpod/features/auth/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  void verifyOTP({
    required String smsCodeId,
    required BuildContext context,
    required String smsCode,
    required bool mounted,
  }) async {
    emit(AuthLoading());
    _authRepository.verifyOTP(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
    emit(AuthSuccess());

    // Emit appropriate states based on success or failure
  }

  void sendOTP({
    required String phoneNumber,
    required BuildContext context,
  }) {
    emit(AuthLoading());
    _authRepository.sendOTP(context: context, phoneNumber: phoneNumber);
    emit(AuthSuccess());
    // Optionally, emit a loading state before sending the OTP
  }

  void signOut() {
    emit(AuthLoading());
    _authRepository.signOut();
    emit(AuthSuccess());

    // Optionally, emit a state indicating that the user has signed out
  }
}
