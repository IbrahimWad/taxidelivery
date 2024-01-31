import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/Core/controller/sendOrder.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/customText.dart';
import 'package:taxidelivery/view/widget/customeButton.dart';

class SendOrder extends StatelessWidget {
  const SendOrder(
      {required this.url,
      required this.price,
      super.key,
      required this.latitude,
      required this.longitude,
      required this.mylatitude,
      required this.mylongitude,
      required this.phone,
      required this.paymnet});
  final String url, phone;
  final String paymnet;
  final double price;

  final double latitude, longitude, mylatitude, mylongitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.only(right: 50),
          child: const CustomText(
            text: 'رحلتك',
            color: primry,
            fontsize: 24,
            alignment: Alignment.center,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: primry,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const CustomText(
                text: 'سعر الرحلة',
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: price.toStringAsFixed(
                        price.truncateToDouble() == price ? 0 : 1),
                    alignment: Alignment.center,
                    fontsize: 24,
                  ),
                  const CustomText(
                    text: 'دينار عراقي',
                    fontsize: 24,
                  ),
                ],
              ),
            ],
          ),
          GetBuilder<SendOrderController>(builder: (controller) {
            return CustomButton(
                text: 'ارسل الطلب',
                onPressed: () {
                  controller.paymentType(context, url, price, latitude,
                      longitude, mylatitude, mylongitude, phone);
                  // showBottomSheet(
                  //   context: context,
                  //   builder: (context) {
                  //     return Container(
                  //       height: 50,
                  //     );
                  //   },
                  // );
                  // controller.sendOrder(url, price, latitude, longitude,
                  //     mylatitude, mylongitude, phone, 'ss');
                  // Send order from here for cash
                });
          }),
        ],
      ),
    );
  }
}
