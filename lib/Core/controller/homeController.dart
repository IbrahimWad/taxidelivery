import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../view/widget/constant/URL.dart';
import '../../view/widget/constant/cach.dart';

class HomeController extends GetxController {
  var image;
  var isLodaing = false;
  String? name;
  getUserData() async {
    isLodaing = true;
    var response = await http.post(Uri.parse(userData), body: {
      'phone': box.read(phoneSave),
    });

    print(image);

    var responsebody = jsonDecode(response.body);
    // print(jsonDecode(response.body)['name']);
    name = responsebody[0]['name'];
    print(responsebody[0]['name']);
    image = Uri.encodeComponent(responsebody[0]['image']);
    print('https://taxibabil.000webhostapp.com/taxiDelivery/images/$image');
    isLodaing = false;
    update();
  }

  @override
  void onInit() {
    getUserData();
    // TODO: implement onInit
    super.onInit();
  }
}
