import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/Core/controller/addNameandImageController.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/customeButton.dart';
import '../widget/customeTextField.dart';

// ignore: must_be_immutable
class ImageAndNAme extends StatelessWidget {
  ImageAndNAme({super.key});

  String ImagesUrl = 'https://taxibabil.000webhostapp.com/taxiDelivery/images/';

  // late String imagename = Uri.encodeComponent();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddImageAndNameController>(
      init: Get.put(AddImageAndNameController()),
      builder: (controller) {
        return Scaffold(
          body: Form(
            key: controller.formkey,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                const SizedBox(height: 75),
                CustomTextForm(
                  iconsax: Icons.person,
                  maxLength: 1,
                  hint: 'ابراهيم وديع',
                  text: 'الاسم',
                  controller: controller.controller,
                  validator: (val) {
                    return controller.validatename(val);
                  },
                ),
                const SizedBox(height: 75),
                Container(
                  height: 250,
                  width: 250,
                  child: GestureDetector(
                    onTap: () {
                      controller.getImage();
                    },
                    child: CircleAvatar(
                      backgroundColor: border,
                      child: controller.imageName != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(125),
                              child: Image.file(
                                controller.imageName!,
                                fit: BoxFit.cover,
                                height: 250,
                                width: 250,
                              ),
                            )
                          : controller.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(125),
                                  child: Image.network(
                                    '$ImagesUrl${controller.image}',
                                    fit: BoxFit.cover,
                                    height: 250,
                                    width: 250,
                                  ),
                                )
                              : const Icon(
                                  Icons.add,
                                  color: text1,
                                  size: 75,
                                ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                CustomButton(
                    text: 'تحقق',
                    onPressed: () {
                      controller.updateUserNameAndImage();
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
