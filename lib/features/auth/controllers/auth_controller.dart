import 'package:flutter/material.dart';

import '../repository/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;
  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String smsCode,
      required bool mounted}) {
    _authRepository.verifyOTP(
        context: context,
        verificationId: verificationId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) {
    _authRepository.sendOTP(context: context, phoneNumber: phoneNumber);
  }
}
