import 'package:fintech_asmt/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPageProvider extends ChangeNotifier {
  void onLoginTap(BuildContext context) {
    Navigator.of(context).pushNamed(PageRoutes.login);
  }
}
