import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/helpers/db_helpers.dart';

import '../../../core/routes/routes.dart';
import '../widgets/alert_dialog_box.dart';

// final authRepositoryProvider = Provider<AuthRepository>(
//   (ref) => AuthRepository(auth: FirebaseAuth.instance),
// );

class AuthRepository {
  final FirebaseAuth auth;

  const AuthRepository({required this.auth});
  void verifyOTP(
      {required BuildContext context,
      required String smsCodeId,
      required String smsCode,
      required bool mounted}) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(
        context: context,
        message: e.message ?? 'Something went wrong',
      );
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  void sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        codeSent: (String smsCodeId, int? forceResendingToken) {
          // showAlertDialog(
          //   context: context,
          //   message: 'OTP sent successfully',
          // );
          DBHelper.createUser(1);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.otp, (route) => false,
              arguments: {'phone': phoneNumber, 'smsCodeId': smsCodeId});
        },
        verificationFailed: (FirebaseAuthException error) {
          if (error.code == 'invalid-phone-number') {
            showAlertDialog(
              context: context,
              message:
                  error.message ?? 'The provided phone number is not valid.',
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      // Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(
        context: context,
        message: e.message ?? 'Something went wrong',
      );
    }
  }
}
