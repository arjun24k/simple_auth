import 'package:fintech_asmt/LandingPage/LandingPageProvider.dart';
import 'package:fintech_asmt/utils/Components/CustomOutlineButton.dart';
import 'package:fintech_asmt/utils/Components/CustomText.dart';
import 'package:fintech_asmt/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class LandingPageMobile extends StatefulWidget {
  final LandingPageProvider lpProvider;
  const LandingPageMobile(this.lpProvider);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => LandingPageProvider(),
      builder: (context, child) => Consumer<LandingPageProvider>(
        builder: ((context, lpProvider, child) =>
            LandingPageMobile(lpProvider)),
      ),
    );
  }

  @override
  State<LandingPageMobile> createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile> {
  Size get screenSize => MediaQuery.of(context).size;
  LandingPageProvider get lpProvider => widget.lpProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: screenSize.width,
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.1),
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.purple.shade900, Colors.blue])),
      child: Column(
        children: [
          SizedBox(
            height: 0.03 * screenSize.height,
          ),
          Column(
            children: [
              SizedBox(
                  width: screenSize.width * 0.5,
                  height: screenSize.width * 0.5,
                  child: Image.asset(Assets.appLogo)),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              CustomText(
                text: 'Welcome to Veno',
                fontSize: 30,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              CustomText(
                text: 'Optimise your budget and\n grow your wealth',
                fontSize: 22,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              CustomText(
                  text: 'Manage your daily expenses with AI and more',
                  color: Colors.white70,
                  weight: FontWeight.bold),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              CustomOutlineButton(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: 'Sign in with OTP',
                      color: Colors.white,
                    ),
                    //Icon(Icons.password)
                  ],
                ),
                onTap: () {
                  lpProvider.onLoginTap(context);
                },
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              CustomOutlineButton(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: 'Continue with Google',
                      color: Colors.white,
                    ),
                    Image.asset(Assets.googleLogo,
                        fit: BoxFit.contain, width: 20),
                  ],
                ),
                onTap: () {},
              )
            ],
          ),
        ],
      ),
    ));
  }
}
