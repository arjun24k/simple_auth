import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResponsiveUI extends StatelessWidget {
  final Widget mobileWidget;
  final Widget desktopWidget;
  const ResponsiveUI({required this.mobileWidget, required this.desktopWidget});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    print(s.width);
    if (s.width < 600) {
      return mobileWidget;
    } else {
      return desktopWidget;
    }
  }
}
