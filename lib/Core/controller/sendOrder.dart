import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:taxidelivery/model/orderModel.dart';
import 'package:taxidelivery/view/home/homeView.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/customText.dart';
import 'package:taxidelivery/view/widget/customeButton.dart';

class SendOrderController extends GetxController {
  var isLoading = false.obs;
  paymentType(BuildContext context, url, salary, latitude, longitude,
      mylatitude, mylongitude, phone) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'نوع الدفع',
      desc: 'الرجاء قم باختيار نوع الدفع',
      btnCancelOnPress: () {
        sendOrder(url, salary, latitude, longitude, mylatitude, mylongitude,
            phone, 'كاش');
        // Get.defaultDialog(
        //   onConfirm: () {
        //     Get.off(Home());
        //   },
        //   barrierDismissible: false,
        //   title: 'انتبه',
        //   content: const CustomText(
        //     text: 'لقد تم ارسال طلبك',
        //     alignment: Alignment.center,
        //   ),
        // );
      },
      btnOkOnPress: () {
        sendOrder(url, salary, latitude, longitude, mylatitude, mylongitude,
            phone, 'دفع الكتروني');
        // Get.defaultDialog(
        //   onConfirm: () {
        //     Get.off(Home());
        //   },
        //   barrierDismissible: false,
        //   title: 'انتبه',
        //   content: const CustomText(
        //     text: 'لقد تم ارسال طلبك',
        //     alignment: Alignment.center,
        //   ),
        // );
      },
      btnCancelText: 'كاش',
      btnOkText: 'دفع الكتروني',
      btnCancelColor: primry,
      btnOkColor: primry,
      buttonsBorderRadius: BorderRadius.circular(12),
    ).show();
  }

  sendOrder(url, salary, latitude, longitude, mylatitude, mylongitude, phone,
      payment) async {
    isLoading.value = true;
    if (isLoading.value == true) {
      EasyLoading.show();
    }
    var response = await http.post(
      Uri.parse(url),
      body: OrderModel(
        salary: salary,
        latitude: latitude,
        longitude: longitude,
        mylatitude: mylatitude,
        mylongitude: mylongitude,
        phone: phone,
        payment: payment,
      ).toJson(),
    );

    print('Response body: ${response.body}');

    try {
      var jsonResponse = jsonDecode(response.body);

      print('Decoded JSON: $jsonResponse');
      if (jsonResponse['status'] == 'Request has been sent successfully') {
        print('the car will come soon');
      } else if (jsonResponse['status'] ==
          'Your Request has already been sent') {
        print('ur order in way');
      }
      isLoading.value = false;
      if (isLoading.value == false) {
        EasyLoading.dismiss();
        Get.defaultDialog(
          actions: [
            CustomButton(
                text: 'انتقل للصفحة الرئيسية',
                onPressed: () {
                  Get.offAll(Home());
                })
          ],
          barrierDismissible: false,
          title: 'انتبه',
          content: const CustomText(
            text: 'لقد تم ارسال طلبك',
            alignment: Alignment.center,
          ),
          // textConfirm: 'اذهب للصفحة الرئيسية',
          buttonColor: primry,
        );
      }
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }
}
