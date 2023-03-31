import 'package:fintech_asmt/utils/DioClient.dart';
import 'package:fintech_asmt/utils/routes.dart';
import 'package:fintech_asmt/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  int currentStage = 1;

  String mobileOtp = '';
  String mobileNum = '';
  String otpRequestId = '';
  String name = '';
  String email = '';
  bool isSubmitting = false;
  set setSubmitting(bool v) {
    if (isSubmitting != v) {
      isSubmitting = v;
      notifyListeners();
    }
  }

  bool resendButtonDisabled = false;
  set setResendButton(bool v) {
    resendButtonDisabled = v;
    notifyListeners();
  }

  int totalStage = 3;
  double a = 1.0, b = 0.0;

  bool get showBackButton => currentStage == 2 || currentStage == 1;

  void onBackButtonTap(BuildContext context) {
    if (currentStage == 2) {
      currentStage--;
      notifyListeners();
      return;
    }
    if (currentStage == 1) {
      Navigator.of(context).pop();
      return;
    }
  }

  Future<void> onButtonClick(BuildContext context) async {
    var navigator = Navigator.of(context);
    if (currentStage > totalStage) return;
    setSubmitting = true;
    if (currentStage == 1) {
      bool res = await sendOTP();
      setSubmitting = false;
      if (!res) {
        return;
      }
    }
    if (currentStage == 2) {
      Map<String, dynamic> res = await validateOTP();
      setSubmitting = false;
      if (res.isNotEmpty) {
        if (res["response"] == "invalid otp" ||
            res["status"].toString() == "false") {
          showSnackbar(res["response"]);
          return;
        } else {
          if (res["jwt"] != null) {
            await setSharedPreferences("string", "jwt", res['jwt']);
          }
          if (res['profile_exists'].toString() == "true") {
            navigator.pushReplacementNamed(PageRoutes.home);
            return;
          }
          currentStage += 1;
          notifyListeners();
          return;
        }
      }
    }
    if (currentStage == 3) {
      if (!isEmailValid(email)) {
        showSnackbar("Enter valid email");
        setSubmitting = false;
        return;
      }
      bool res = await profileSubmit();
      setSubmitting = false;
      if (res) {
        navigator.pushNamedAndRemoveUntil(PageRoutes.home, (route) => false);
      }
      return;
    }
    currentStage += 1;
    notifyListeners();
    return;
  }

  Future<bool> sendOTP({bool resend = false}) async {
    try {
      if (resend) {
        if (!resendButtonDisabled) return false;
        setResendButton = false;
      }
      DioClient d = DioClient();
      var res = await d.post(
        "https://test-otp-api.7474224.xyz/sendotp.php",
        {"mobile": mobileNum},
      );
      if (res['status'].toString() == "true") {
        otpRequestId = res['request_id'];
        showSnackbar(res['response']);
        return true;
      }
      return false;
    } catch (e) {
      showSnackbar("An error has occurred. Please try again");
      return false;
    }
  }

  Future<Map<String, dynamic>> validateOTP() async {
    Map<String, dynamic> r = {};
    try {
      DioClient d = DioClient();
      var r = await d.post(
        "https://test-otp-api.7474224.xyz/verifyotp.php",
        {"request_id": otpRequestId, "code": mobileOtp},
      );
      return r;
    } catch (e) {
      showSnackbar("An error has occurred. Please try again");
      return r;
    }
  }

  Future<bool> profileSubmit() async {
    try {
      DioClient d = DioClient();
      var res = await d.post(
        "https://test-otp-api.7474224.xyz/profilesubmit.php",
        {"name": name, "email": email},
      );
      if (res['status'].toString() == "true") {
        showSnackbar(res['response']);
        return true;
      }
      return false;
    } catch (e) {
      showSnackbar("An error has occurred. Please try again");
      return false;
    }
  }
}
