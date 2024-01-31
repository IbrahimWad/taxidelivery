import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxidelivery/main.dart';
import 'package:taxidelivery/view/home/homeView.dart';

import 'package:taxidelivery/view/widget/constant/URL.dart';
import 'package:taxidelivery/view/widget/constant/cach.dart';
import 'package:http/http.dart' as http;

import '../../view/widget/constant/COLOR.dart';
import '../../view/widget/customText.dart';

class AddImageAndNameController extends GetxController {
  TextEditingController controller = TextEditingController();
  var image;
  var isLodaing = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  getUserData() async {
    isLodaing = true;
    if (isLodaing == true) {
      EasyLoading.show();
    }
    var response = await http.post(Uri.parse(userData), body: {
      'phone': box.read(phoneSave),
    });
    isLodaing = false;
    if (isLodaing == false) {
      EasyLoading.dismiss();
    }
    print(image);

    var responsebody = jsonDecode(response.body);
    // print(jsonDecode(response.body)['name']);
    controller.text = responsebody[0]['name'];
    print(responsebody[0]['name']);
    image = Uri.encodeComponent(responsebody[0]['image']);
    print('https://taxibabil.000webhostapp.com/taxiDelivery/images/$image');

    update();
  }

  File? imageName;
  String? imagePath;
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageName = File(pickedFile.path);
      imagePath = pickedFile.path;
      print(imagePath);
    } else {
      print('No image selected.');
    }

    update();
  }

  updateUserNameAndImage() async {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      box.write(name, controller.value.text);
      try {
        isLodaing = true;
        if (isLodaing) {
          EasyLoading.show();
        }
        final request =
            http.MultipartRequest('POST', Uri.parse(uploadImageAndName));

        request.fields['phone'] = box.read(phoneSave);
        request.fields['name'] = controller.value.text;

        if (imageName != null) {
          final file =
              await http.MultipartFile.fromPath('file', imageName!.path);
          request.files.add(file);
        }

        final response = await request.send();
        final responseString = await response.stream.bytesToString();
        var responseBody = jsonDecode(responseString);
        print(responseBody);
        isLodaing = false;
        if (!isLodaing) {
          EasyLoading.dismiss();
        }
        if (imageName == null && image == null) {
          Get.showSnackbar(
            GetBar(
              messageText: const CustomText(
                text: 'الرجاء قم باختيار صورة',
                color: error,
                alignment: Alignment.centerRight,
              ),
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 5),
            ),
          );
        } else {
          Get.offAll(Home());
        }
      } catch (e) {
        print(e);
      }
    }
  }

  String? validatename(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'الرجاء إدخال الاسم';
    }
    return null;
  }

  @override
  void onInit() {
    getUserData();
    controller;
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
