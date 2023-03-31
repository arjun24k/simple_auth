import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomOutlineButton extends StatefulWidget {
  Color color;
  Widget child;
  double width;
  double height;
  EdgeInsets contentPadding;
  BorderRadius? borderRadius;
  Color hoverTextColor;

  Function? onTap;
  CustomOutlineButton(
      {this.color = Colors.black,
      required this.child,
      this.width = 300,
      this.height = 50,
      this.contentPadding = const EdgeInsets.all(2),
      this.borderRadius,
      this.hoverTextColor = Colors.black,
      required this.onTap});

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        onPressed: () {
          widget.onTap!();
        },
        onHover: (value) {
          setState(() {
            isHovering = value;
          });
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
              isHovering ? widget.hoverTextColor : widget.color),
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: widget.color)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.zero)),
        ),
        child: Padding(
          padding: widget.contentPadding,
          child: widget.child,
        ),
      ),
    );
  }
}
