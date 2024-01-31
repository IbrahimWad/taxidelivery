import 'package:flutter/cupertino.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.text,
      this.alignment = Alignment.bottomLeft,
      this.color = text1,
      this.fontsize = 16,
      this.height = 1,
      this.fontWeight = FontWeight.bold})
      : super(key: key);
  final String text;
  final Alignment alignment;
  final Color color;
  final double fontsize, height;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: fontWeight,
            color: color,
            fontSize: fontsize,
            height: height,
            overflow: TextOverflow.ellipsis),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
