import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight weight;
  Color color;
  TextAlign textAlign;
  double letterSpacing;
  CustomText(
      {required this.text,
      this.fontSize,
      this.weight = FontWeight.normal,
      this.color = Colors.black,
      this.textAlign = TextAlign.center,
      this.letterSpacing = 0.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: weight,
          color: color,
          fontSize: fontSize,
          letterSpacing: letterSpacing),
    );
  }
}
