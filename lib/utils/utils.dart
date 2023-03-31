import 'package:fintech_asmt/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTextButton extends StatelessWidget {
  String text;
  TextStyle style;
  Function? onTap;
  Color? color;
  double? width;
  double? height;
  EdgeInsets? margin;
  EdgeInsets? contentPadding;

  CustomTextButton(this.text,
      {this.style = const TextStyle(fontSize: 15, color: Colors.white),
      required this.onTap,
      this.color,
      this.width = 100,
      this.height = 50,
      this.margin = const EdgeInsets.all(0),
      this.contentPadding = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: contentPadding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: color ?? Colors.indigo),
        alignment: Alignment.center,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

getSharedPreferences(
  String type,
  String key,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (type.toLowerCase()) {
    case "bool":
      return prefs.getBool(key) ?? false;
    case "double":
      return prefs.getDouble(key) ?? 0;
    case "int":
      return prefs.getInt(key) ?? 0;
    case "string_list":
      return prefs.getStringList(key) ?? <String>[];
    case "string":
    default:
      return prefs.getString(key) ?? "";
  }
}

Future<void> setSharedPreferences(
  String type,
  String key,
  dynamic value,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (type.toLowerCase()) {
    case "bool":
      await prefs.setBool(key, value);
      break;
    case "double":
      await prefs.setDouble(key, value);
      break;
    case "int":
      await prefs.setInt(key, value);
      break;
    case "string_list":
      await prefs.setStringList(key, value);
      break;
    case "string":
    default:
      await prefs.setString(key, value);
  }
}

void showSnackbar(String text) {
  ScaffoldKey.scaffoldkey.currentState!.showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
  ));
}

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
