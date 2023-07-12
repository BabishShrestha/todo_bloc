import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/app_style.dart';
import 'package:todo_riverpod/core/widgets/custom_otn_btn.dart';
import 'package:todo_riverpod/core/widgets/custom_textfield.dart';
import 'package:todo_riverpod/core/widgets/reusable_text.dart';
import 'package:todo_riverpod/features/auth/pages/otp_page.dart';

import '../../../core/widgets/spacer.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  Country country = Country(
      countryCode: "NP",
      phoneCode: "+977",
      name: "Nepal",
      displayName: "Nepal",
      displayNameNoCountryCode: "NP",
      example: "NP",
      geographic: true,
      e164Key: "",
      e164Sc: 0,
      level: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: Image.asset(AppConst.todo),
              ),
              const HeightSpacer(spaceHeight: 10),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: ReusableText(
                    text: "Please enter your phone number",
                    style: appStyle(14, AppConst.kLight, FontWeight.normal)),
              ),
              const HeightSpacer(spaceHeight: 10),
              Center(
                child: CustomTextFormField(
                    controller: phoneController,
                    prefixIcon: Container(
                      // alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                backgroundColor: AppConst.kLight,
                                textStyle: appStyle(
                                    18, AppConst.kBkDark, FontWeight.normal),
                                searchTextStyle: appStyle(
                                    18, AppConst.kBkDark, FontWeight.normal),
                                bottomSheetHeight: AppConst.kHeight * 0.6,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppConst.kRadius),
                                  topRight: Radius.circular(AppConst.kRadius),
                                ),
                              ),
                              onSelect: (country) {
                                setState(() {});
                              });
                        },
                        child: ReusableText(
                            text: "${country.flagEmoji} ${country.phoneCode}",
                            style: appStyle(
                                14, AppConst.kBkDark, FontWeight.w600)),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    hintText: "Enter Phone Number",
                    hintStyle: appStyle(14, AppConst.kBkDark, FontWeight.w600)),
              ),
              const HeightSpacer(spaceHeight: 10),
              CustomOutlineButton(
                borderColor: AppConst.kBkDark,
                height: AppConst.kHeight * 0.06,
                bgColor: AppConst.kLight,
                text: 'Enter Code',
                width: AppConst.kWidth,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const OTPPage(phone: '', smsCodeId: '',),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
