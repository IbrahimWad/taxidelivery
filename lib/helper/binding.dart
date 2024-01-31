import 'package:get/get.dart';
import 'package:taxidelivery/Core/controller/addNameandImageController.dart';
import 'package:taxidelivery/Core/controller/auth_viewModel.dart';
import 'package:taxidelivery/Core/controller/homeController.dart';
import 'package:taxidelivery/Core/controller/outTravelController.dart';
import 'package:taxidelivery/Core/controller/sendOrder.dart';

import 'package:taxidelivery/Core/controller/verification_viewModel.dart';

import '../Core/controller/in_Travel_Controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(), fenix: true);
    Get.lazyPut(() => VerificationViewModel(), fenix: true);
    Get.lazyPut(() => InTravelController(), fenix: true);
    Get.lazyPut(() => OutTravelController(), fenix: true);
    Get.lazyPut(() => SendOrderController(), fenix: true);
    Get.lazyPut(() => AddImageAndNameController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
