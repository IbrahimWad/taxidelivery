import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/Core/services/login.dart';
import 'package:taxidelivery/main.dart';
import 'package:taxidelivery/model/AuthModel.dart';
import 'package:taxidelivery/view/Auth/verification.dart';
import 'package:taxidelivery/view/widget/constant/cach.dart';

class AuthViewModel extends GetxController {
  TextEditingController phone = TextEditingController();

  var isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  login(UserModel userModel) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        isLoading.value = true;
        if (isLoading == true) {
          EasyLoading.show();
        }
        final response = await LoginService().Login(userModel);
        var st = jsonDecode(response.body);
        if (st['status'] == 'OTP send successfully') {
          box.write(phoneSave, '+964${phone.value.text}');
          EasyLoading.dismiss();
          Get.offAll(const Verification());
        }
        isLoading.value = false;
        if (isLoading.value == false) {
          EasyLoading.dismiss();
        }
        EasyLoading.dismiss();
      } catch (error) {
        EasyLoading.dismiss();
      }
    }
  }

  @override
  void onInit() {
    phone;
    super.onInit();
  }

  @override
  void onClose() {
    phone.clear();
    super.onClose();
  }

  String? validatePhone(String value) {
    if (value.length != 10) {
      return 'الرجاء ادخال رقم هاتف صحيح';
    }
    return null;
  }
}
