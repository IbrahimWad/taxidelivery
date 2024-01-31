import 'package:flutter/material.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/customText.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = primry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      // height: 50,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        )),
        onPressed: onPressed,
        child: CustomText(
          alignment: Alignment.center,
          text: text,
          fontsize: 18,
          color: Colors.white,
          //fontSize: 18,
        ),
      ),
    );
  }
}
