import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxidelivery/helper/binding.dart';
import 'package:taxidelivery/view/Auth/Login.dart';
import 'package:taxidelivery/view/home/homeView.dart';
import 'package:taxidelivery/view/widget/constant/cach.dart';

final box = GetStorage();
void main() async {
  await GetStorage.init();
  // EasyLoading.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return GetMaterialApp(
        initialBinding: Binding(),
        debugShowCheckedModeBanner: false,
        title: 'Taxi Delivery',
        locale: const Locale('ar'),
        builder: EasyLoading.init(),
        theme: ThemeData(
          fontFamily: 'Cairo',
        ),
        home: box.read(name) == null ? Login() : Home());
  }
}
