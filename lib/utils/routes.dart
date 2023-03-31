import 'package:fintech_asmt/Home/HomeDesktop.dart';
import 'package:fintech_asmt/Home/HomeMobile.dart';
import 'package:fintech_asmt/LandingPage/LandingPageDesktop.dart';
import 'package:fintech_asmt/LandingPage/LandingPageMobile.dart';
import 'package:fintech_asmt/Login/LoginDesktop.dart';
import 'package:fintech_asmt/Login/LoginMobile.dart';
import 'package:fintech_asmt/utils/Components/ResponsiveUI.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String home = 'home';
  static const String login = 'login';
  static const String landingPage = 'landing_page';

  static Map<String, WidgetBuilder> routes() {
    return {
      home: (context) => ResponsiveUI(
            mobileWidget: HomeMobile.create(),
            desktopWidget: HomeDesktop.create(),
          ),
      login: (context) => ResponsiveUI(
            mobileWidget: LoginMobile.create(),
            desktopWidget: LoginDesktop.create(),
          ),
      landingPage: (context) => ResponsiveUI(
            mobileWidget: LandingPageMobile.create(),
            desktopWidget: LandingPageDesktop.create(),
          )
    };
  }
}
