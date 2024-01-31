// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:taxidelivery/view/widget/customText.dart';

class CustomeButtomSocail extends StatelessWidget {
  CustomeButtomSocail(
      {required this.onTap,
      required this.image,
      required this.text,
      super.key});
  var onTap;
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 70,
                width: 70,
                // color: primry,
                child: Image.asset(image),
              ),
            ),
          ),
          CustomText(text: 'فيسبوك')
        ],
      ),
    );
  }
}
