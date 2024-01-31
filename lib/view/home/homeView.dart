import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/Core/controller/homeController.dart';
import 'package:taxidelivery/main.dart';
import 'package:taxidelivery/view/Auth/ImageName.dart';
import 'package:taxidelivery/view/Auth/Login.dart';
import 'package:taxidelivery/view/settings/support.dart';
import 'package:taxidelivery/view/travels/in/travelInsaid.dart';
import 'package:taxidelivery/view/travels/out/travelOut.dart';
import 'package:taxidelivery/view/widget/Card.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/constant/cach.dart';
import 'package:taxidelivery/view/widget/customText.dart';
import 'package:taxidelivery/view/widget/textButton.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        key: scaffolKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: primry,
                ),
                onPressed: () {
                  scaffolKey.currentState!.openDrawer();
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 170,
                child: CircleAvatar(
                  backgroundColor: border,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(85),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(ImageAndNAme());
                        },
                        child: Image.network(
                          'https://taxibabil.000webhostapp.com/taxiDelivery/images/${controller.image}',
                          height: 170,
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: CustomText(
                  text: box.read(name),
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                  alignment: Alignment.center,
                ),
              ),
              Container(
                child: CustomText(
                  text: box.read(phoneSave),
                  alignment: Alignment.center,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // here
              CustomeButtonText(
                  onPressed: () {},
                  iconData: AnimateIcons.calendar,
                  text: 'تاريخ الرحلات'),
              CustomeButtonText(
                  onPressed: () {},
                  iconData: AnimateIcons.dollar,
                  text: 'المحفظة'),
              CustomeButtonText(
                  onPressed: () {},
                  iconData: AnimateIcons.wink,
                  text: 'التقييم'),
              CustomeButtonText(
                  onPressed: () {},
                  iconData: AnimateIcons.activity,
                  text: 'سياسة الخصوصية'),
              CustomeButtonText(
                  onPressed: () {
                    Get.to(SupportScreen());
                  },
                  iconData: AnimateIcons.settings,
                  text: 'الدعم'),
              CustomeButtonText(
                  onPressed: () {
                    box.erase();
                    Get.offAll(() => Login());
                  },
                  iconData: AnimateIcons.signOut,
                  text: 'تسجيل الخروج')
            ],
          ),
        ),
        // Rest of the Scaffold body

        body: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  child: CartCustom(
                ontap: () {
                  Get.to(
                    const TravelInsaid(),
                    transition: Transition.fade,
                  );
                },
                text: 'السفر داخل بابل',
                image: 'assets/image/in.jpg',
                height: Get.height * 0.38, // Set the desired height
                width: double.infinity, // Set the desired width
              )),
              Container(
                child: CartCustom(
                  ontap: () {
                    Get.to(
                      const Travelout(),
                      transition: Transition.fade,
                    );
                  },
                  text: 'السفر خارج بابل',
                  image: 'assets/image/out.jpg',
                  height: Get.height * 0.38, // Set the desired height
                  width: double.infinity, // Set the desired width
                ),
              ),
            ]),
      );
    });
  }
}
