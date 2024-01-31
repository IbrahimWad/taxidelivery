import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/customText.dart';
import 'package:taxidelivery/view/widget/customeButton.dart';
import 'package:taxidelivery/view/widget/socialButton.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: text1,
                ))
          ],
        ),
        body: Container(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              const SizedBox(
                height: 60,
              ),
              const CustomText(
                text: 'اذا كنت تواجه اي مشكلة قم بالاتصال على',
                fontsize: 18,
                alignment: Alignment.centerRight,
              ),
              const CustomText(
                text: 'الرقم الظاهر تحته',
                fontsize: 18,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  height: 50,
                  child: CustomButton(
                      text: '+964 783 041 6531',
                      onPressed: () async {
                        const url = 'tel:+9647830416531';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      })),
              const SizedBox(
                height: 150,
              ),
              const CustomText(
                text: 'يمكنك متابعتنا على مواقع التواصل الاجتماعي',
                alignment: Alignment.centerRight,
                fontsize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomeButtomSocail(
                      onTap: () async {
                        const url =
                            'https://www.facebook.com/profile.php?id=100029855433663';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      image: 'assets/image/R.png',
                      text: 'فيسبوك'),
                  CustomeButtomSocail(
                      onTap: () async {
                        const url = 'https://www.instagram.com/ibrahim_wadie11';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      image: 'assets/image/R1.png',
                      text: 'انستغرام'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
