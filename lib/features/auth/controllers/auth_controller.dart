import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(authRepository: ref.read(authRepositoryProvider));
});

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;
  void verifyOTP(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required bool mounted}) {
    _authRepository.verifyOTP(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) {
    _authRepository.sendOTP(context: context, phoneNumber: phoneNumber);
  }

  void signOut() {
    _authRepository.signOut();
  }
}
