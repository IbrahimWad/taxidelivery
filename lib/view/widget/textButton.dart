import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'customText.dart';

// ignore: must_be_immutable
class CustomeButtonText extends StatelessWidget {
  CustomeButtonText(
      {required this.onPressed,
      required this.iconData,
      required this.text,
      super.key});

  var onPressed;
  AnimateIcons iconData;
  String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          AnimateIcon(
            key: UniqueKey(),
            onTap: () {},
            iconType: IconType.continueAnimation,
            height: 30,
            width: 30,
            color: Color.fromRGBO(Random.secure().nextInt(255),
                Random.secure().nextInt(255), Random.secure().nextInt(255), 1),
            animateIcon: iconData,
          ),
          const SizedBox(
            width: 25,
          ),
          CustomText(
            text: text,
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
