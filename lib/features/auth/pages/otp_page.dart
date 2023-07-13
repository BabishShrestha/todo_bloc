import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';
import 'package:todo_riverpod/core/widgets/reusable_text.dart';
import 'package:todo_riverpod/features/auth/controllers/auth_controller.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widgets/spacer.dart';

class OTPPage extends ConsumerWidget {
  final String phone;
  final String smsCodeId;
  const OTPPage({super.key, required this.phone, required this.smsCodeId});

  void verifyOTPCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOTP(
        context: context,
        smsCode: smsCode,
        mounted: true,
        smsCodeId: smsCodeId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // HeightSpacer(spaceHeight: AppConst.kHeight * 0.1),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: Image.asset(
                    AppConst.todo,
                    width: AppConst.kWidth * 0.6,
                  ),
                ),
                const HeightSpacer(spaceHeight: 10),
                ReusableText(
                  text: 'Enter your OTP code',
                  style: appStyle(16, AppConst.kLight, FontWeight.w600),
                ),
                const HeightSpacer(spaceHeight: 20),
                Pinput(
                  length: 6,
                  onCompleted: (String pin) {
                    if (pin.length == 6) {
                      return verifyOTPCode(context, ref, pin);
                    }
                  },
                  onSubmitted: (String pin) {
                    if (pin.length == 6) {
                      return verifyOTPCode(context, ref, pin);
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
