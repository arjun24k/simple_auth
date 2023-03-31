import 'package:fintech_asmt/utils/routes.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  void signout(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(PageRoutes.landingPage);
  }
}
