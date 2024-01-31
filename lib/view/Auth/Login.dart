import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/Core/controller/auth_viewModel.dart';
import 'package:taxidelivery/model/AuthModel.dart';
import 'package:taxidelivery/view/widget/customeTextFormField.dart';

import '../widget/customText.dart';
import '../widget/customeButton.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          builder: (controller) {
            return Form(
              key: controller.formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        //color: Colors.amber,
                        margin: const EdgeInsets.symmetric(horizontal: 70),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                          child: Image.asset(
                            'assets/image/phone.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: const CustomText(
                            alignment: Alignment.topRight,
                            text:
                                'الرجاء قم بادخال رقم هاتفك للوصول الى خدمات التطبيق'),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      CustomTextFormFiled(
                        controller: controller.phone,
                        text: 'رقم الهاتف',
                        fontWeight: FontWeight.bold,
                        iconsax: Icons.mobile_friendly_outlined,
                        // key: controller.formkey,
                        validator: (value) {
                          return controller.validatePhone(value);
                        },
                        maxLength: 10,
                        hint: '7500000000',
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      CustomButton(
                          onPressed: () {
                            controller.login(UserModel(
                                otp: '',
                                phone: "+964${controller.phone.value.text}"));

                            //Get.to(Verification());
                          },
                          text: 'سجل الان'),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
