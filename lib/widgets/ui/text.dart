import 'package:flutter/material.dart';
import 'package:myapp/utils/dimensions.dart' as dimensions;

class AppText extends StatelessWidget {
  const AppText.small(this.text,
      {super.key,
      this.size = dimensions.size * 2,
      this.color,
      this.weight = FontWeight.w400,
      this.textAlign});

  const AppText.medium(this.text,
      {super.key,
      this.size = dimensions.size * 3,
      this.color,
      this.weight = FontWeight.w600,
      this.textAlign});

  const AppText.big(this.text,
      {super.key,
      this.size = dimensions.size * 4,
      this.color,
      this.weight = FontWeight.w800,
      this.textAlign});
  final double size;
  final Color? color;
  final FontWeight weight;
  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color ?? Theme.of(context).shadowColor,
        fontWeight: weight,
      ),
    );
  }
}
