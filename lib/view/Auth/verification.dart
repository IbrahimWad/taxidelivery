// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/Core/controller/verification_viewModel.dart';
import 'package:taxidelivery/main.dart';
import 'package:taxidelivery/model/AuthModel.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/constant/cach.dart';
import 'package:taxidelivery/view/widget/customText.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VerificationViewModel>(
          init: VerificationViewModel(),
          builder: (controller) {
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                const CustomText(
                  text: 'رمز التحقق',
                  alignment: Alignment.center,
                  fontsize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'تم ارسال رمز التحقق الئ الرقم',
                      fontWeight: FontWeight.normal,
                      //alignment: Alignment.center,
                    ),
                    CustomText(
                      text: box.read(phoneSave),
                      color: primry,
                      //alignment: Alignment.center,
                      fontWeight: FontWeight.normal,
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Obx(() => Center(
                      child: CustomText(
                        text: controller.time.value,
                        alignment: Alignment.center,
                        fontsize: 32,
                      ),
                    )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                OtpTextField(
                    borderRadius: BorderRadius.circular(12),
                    fieldWidth: 60,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    numberOfFields: 4,
                    borderColor: border,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //  print(code);
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      controller.submit(verificationCode);
                    } // end onSubmit
                    ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(text: 'لم يصلك الرمز بعد؟'),
                    GestureDetector(
                        onTap: () {
                          if (controller.time != "00:00") {
                            return;
                          } else {
                            controller.resndOTP(
                                UserModel(otp: '', phone: box.read(phoneSave)));
                          }
                          //  print('Hello world');
                        },
                        child: const CustomText(
                          text: 'اعادة ارسال الرمز',
                          color: primry,
                        ))
                  ],
                )
              ],
            );
          }),
    );
  }
}
