import 'package:fintech_asmt/Login/LoginProvider.dart';
import 'package:fintech_asmt/utils/Components/CountDownTimer.dart';
import 'package:fintech_asmt/utils/Components/CustomText.dart';
import 'package:fintech_asmt/utils/assets.dart';
import 'package:fintech_asmt/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginMobile extends StatefulWidget {
  final LoginProvider loginProvider;
  const LoginMobile(this.loginProvider);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      builder: (context, child) => Consumer<LoginProvider>(
        builder: ((context, loginProvider, child) =>
            LoginMobile(loginProvider)),
      ),
    );
  }

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;

  final TextEditingController mobileNumberController =
      new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  FocusNode emailF = FocusNode();
  LoginProvider get loginProvider => widget.loginProvider;

  late Widget signInWidget;

  final defaultPinTheme = const PinTheme(
    width: 40,
    height: 64,
    textStyle: TextStyle(color: Colors.white70),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.white70, width: 2),
      ),
    ),
  );

  final focusPinTheme = const PinTheme(
    width: 40,
    height: 64,
    textStyle: TextStyle(color: Colors.white),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.white, width: 3),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  String get buttonText {
    if (loginProvider.currentStage < loginProvider.totalStage) {
      return "Next";
    } else {
      return "Submit";
    }
  }

  List<Widget> otpLogin() {
    return [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomText(
            text: "Please verify phone number",
            color: Colors.white,
            fontSize: 22,
            textAlign: TextAlign.center,
          )),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomText(
            text: "We have sent a verification code to \n" +
                mobileNumberController.text,
            color: Colors.white,
            fontSize: 14,
          )),
      Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusPinTheme,
        showCursor: false,
        onChanged: (pin) {
          loginProvider.mobileOtp = pin;
        },
        pinAnimationType: PinAnimationType.slide,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: TextButton(
            onPressed: () {
              loginProvider.setResendButton = false;
            },
            child: loginProvider.resendButtonDisabled
                ? GestureDetector(
                    onTap: () {
                      loginProvider.sendOTP(resend: true);
                    },
                    child: CustomText(
                      text: 'Resend OTP',
                      color: Colors.white,
                    ),
                  )
                : CountDownTimer(
                    secondsRemaining: 10,
                    whenTimeExpires: () {
                      loginProvider.setResendButton = true;
                    },
                    addCustomText: 'Resend OTP in',
                    countDownTimerStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
          ),
        ),
      ),
    ];
  }

  Widget getsignInWidget(int stage) {
    Widget stage1 = Column(
      children: [
        CustomText(
          text: 'Signup or Login to Veno',
          fontSize: 22,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CustomText(
          text:
              'You can use your phone number\n or go back and sign in with google',
          fontSize: 16,
          weight: FontWeight.bold,
          color: Colors.white70,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: IntlPhoneField(
              controller: mobileNumberController,
              initialCountryCode: "IN",
              dropdownTextStyle: TextStyle(color: Colors.white),
              style: TextStyle(color: Colors.white),
              dropdownIcon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              onChanged: (phone) {
                loginProvider.mobileNum = phone.number;
              },
              autovalidateMode: AutovalidateMode.disabled,
              cursorColor: Colors.white70,
              onSubmitted: (v) {
                loginProvider.onButtonClick(context);
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
              ),
            )),
      ],
    );

    Widget stage2 = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: otpLogin(),
    );

    Widget stage3 = Center(
      child: Column(
        children: [
          Container(
            width: width * 0.88,
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: 'Tell us more about \nyourself',
              fontSize: 30,
              weight: FontWeight.bold,
              color: Colors.white,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            width: width * 0.9,
            child: TextFormField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              onChanged: (value) {
                loginProvider.name = value;
              },
              onFieldSubmitted: ((value) {
                emailF.requestFocus();
              }),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            width: width * 0.9,
            child: TextFormField(
              controller: emailController,
              focusNode: emailF,
              onFieldSubmitted: (value) {
                loginProvider.onButtonClick(context);
              },
              onChanged: (value) {
                loginProvider.email = value;
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    switch (stage) {
      case 1:
        return stage1;
      case 2:
        return stage2;
      case 3:
        return stage3;
      default:
        return stage1;
    }
  }

  Widget loginWidgets() {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        SizedBox(
            width: width * 0.3,
            height: width * 0.3,
            child: Image.asset(Assets.appLogo)),
        SizedBox(
          height: height * 0.03,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween(
                begin: Offset(loginProvider.a, loginProvider.b),
                end: Offset.zero,
              ).animate(animation),
              child: SlideTransition(
                position: Tween(
                  begin: Offset(loginProvider.a, loginProvider.b),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
            return Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          child: signInWidget,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    signInWidget = getsignInWidget(loginProvider.currentStage);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(width, 100),
          child: loginProvider.showBackButton
              ? Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      loginProvider.onBackButtonTap(context);
                    },
                  ),
                )
              : Container(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
            ? null
            : loginProvider.isSubmitting
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.7),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomTextButton(buttonText,
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 16,
                            letterSpacing: 1),
                        onTap: () => loginProvider.onButtonClick(context),
                        width: width * 0.6,
                        color: Colors.white),
                  ),
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.blue.shade900, Colors.blue])),
          child: loginWidgets(),
        ),
      ),
    );
  }
}
