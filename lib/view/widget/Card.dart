import 'package:flutter/material.dart';
import 'package:taxidelivery/view/widget/customText.dart';

import 'constant/COLOR.dart';

class CartCustom extends StatelessWidget {
  const CartCustom({
    required this.text,
    required this.image,
    required this.ontap,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final String text;
  final String image;
  final Function ontap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: ontap as void Function()?,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: primry,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Image.asset(
                image,
                height: height,
                width: width,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: CustomText(
                  text: text,
                  alignment: Alignment.center,
                  color: primry,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
