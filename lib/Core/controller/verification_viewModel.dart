// ignore_for_file: unused_field
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/Core/services/login.dart';
import 'package:taxidelivery/model/AuthModel.dart';
import 'package:http/http.dart' as http;
import 'package:taxidelivery/view/Auth/ImageName.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/constant/URL.dart';
import 'package:taxidelivery/view/widget/customText.dart';
import '../../main.dart';
import '../../view/widget/constant/cach.dart';

class VerificationViewModel extends GetxController {
  Timer? _timer;
  int remainingSeconsd = 1;
  final time = '00:00'.obs;
  void startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconsd = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconsd == -1) {
        timer.cancel();
      } else {
        int minutes = remainingSeconsd ~/ 60;
        int seconds = (remainingSeconsd % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconsd--;
      }
    });
    update();
  }

  @override
  void onInit() {
    startTimer(60);
    super.onInit();
  }

  var isLoading = false;
  String? otp;
  submit(String verificationCode) {
    otp = verificationCode;
    verification(
      UserModel(
        otp: verificationCode,
        phone: box.read(phoneSave),
      ),
    );
  }

  verification(UserModel userModel) async {
    isLoading = true;
    if (isLoading == true) {
      EasyLoading.show();
    }
    final response =
        await http.post(Uri.parse(verify), body: userModel.toJson());
    var status = jsonDecode(response.body);
    if (status['status'] == 'fail') {
      Get.showSnackbar(
        GetBar(
          messageText: const CustomText(
            text: 'رمز التحقق الخاص بك غير صحيح',
            color: error,
            alignment: Alignment.centerRight,
          ),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
        ),
        // colorText: Colors.white,
        //snackPosition: SnackPosition.TOP,
      );
      isLoading = false;
      if (isLoading == false) {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
      // box.write('otp', )
      Get.off(ImageAndNAme());
      box.write('otp', otp);
    }
    update();
  }

  resndOTP(UserModel userModel) async {
    try {
      isLoading = true;
      if (isLoading == true) {
        EasyLoading.show();
      }
      final response = await LoginService()
          .Login(UserModel(otp: '', phone: box.read(phoneSave)));
      var responsebody = response.body;
      var st = jsonDecode(responsebody);
      if (st['status'] == 'OTP send successfully') {
        startTimer(60);
        EasyLoading.dismiss();
      }
      isLoading = false;
      if (isLoading == false) {
        EasyLoading.dismiss();
      }
    } catch (error) {
      EasyLoading.dismiss();
    }
  }
}
