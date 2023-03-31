import 'package:fintech_asmt/Home/HomeProvider.dart';
import 'package:fintech_asmt/utils/Components/CustomOutlineButton.dart';
import 'package:fintech_asmt/utils/Components/CustomText.dart';
import 'package:fintech_asmt/utils/assets.dart';
import 'package:fintech_asmt/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class HomeDesktop extends StatefulWidget {
  final HomeProvider homeProvider;
  const HomeDesktop(this.homeProvider);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) => Consumer<HomeProvider>(
        builder: ((context, homeProvider, child) => HomeDesktop(homeProvider)),
      ),
    );
  }

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
  HomeProvider get homeProvider => widget.homeProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
          ? null
          : Padding(
              padding: EdgeInsets.only(top: height * 0.75),
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    child: CustomTextButton(
                        "Be an Early Bird. Avail offers now!",
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 14,
                            letterSpacing: 1),
                        onTap: () {},
                        width: width * 0.8,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomOutlineButton(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    child: CustomText(
                      text: 'Signout',
                      color: Colors.white,
                    ),
                    onTap: () {
                      homeProvider.signout(context);
                    },
                  )
                ],
              ),
            ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.purple.shade900, Colors.blue])),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            SizedBox(
                width: height * 0.2,
                height: height * 0.2,
                child: Image.asset(Assets.appLogo)),
            Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.08),
                child: CustomText(
                  text: "Welcome aboard!",
                  color: Colors.white,
                  weight: FontWeight.bold,
                  fontSize: 60,
                  textAlign: TextAlign.center,
                )),
            CustomText(
              text: "We are delighted to see you",
              color: Colors.white70,
              fontSize: 30,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
