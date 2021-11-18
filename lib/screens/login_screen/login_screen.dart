// import 'package:backyard/widgets/layout_screen.dart';
import 'package:backyard_delivery/layout/layout_screen.dart';
import 'package:backyard_delivery/screens/terms_screen/terms_screen.dart';
import 'package:backyard_delivery/services/diohelper.dart';
import 'package:backyard_delivery/services/localstroage.dart';
import 'package:backyard_delivery/shared/components/components.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool emailChecker = false, passowrdChecker = false;
  check() {
    if (emailController.text == "") {
      setState(() {
        emailChecker = true;
      });
    } else
      setState(() {
        emailChecker = false;
      });
    if (passwordController.text == "") {
      setState(() {
        passowrdChecker = true;
      });
    } else
      setState(() {
        passowrdChecker = false;
      });
    return "ok";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.1.sh),
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  Text(
                    'Lets sign you in'.tr(),
                    style: TextStyle(fontSize: 50.sp, color: Color(0xff80392C)),
                  ),
                  SizedBox(
                    height: 0.025.sh,
                  ),
                  Stack(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/Group 8208.png'),
                        ],
                      ),
                      Positioned(
                        right: 20,
                        top: 200,
                        child: Column(
                          children: [
                            Container(
                              child: defaultFormField(
                                checker: emailChecker,
                                maxLines: 1,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                label: 'Email Address'.tr(),
                                prefix: Icons.email_outlined,
                              ),
                              width: .54.sw,
                              height: 60,
                            ),
                            emailChecker == true
                                ? Text(
                                    "Please enter email".tr(),
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Container(),
                            SizedBox(height: 15.h),
                            Container(
                              child: defaultFormField(
                                checker: passowrdChecker,
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                label: 'password'.tr(),
                                isPassword: true,
                                maxLines: 1,
                                prefix: Icons.lock_outlined,
                              ),
                              width: .54.sw,
                              height: 60,
                            ),
                            passowrdChecker == true
                                ? Text(
                                    "Please enter password".tr(),
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Container(),
                            SizedBox(height: 15.h),
                            Container(
                              height: 0.05.sh,
                              width: 0.32.sw,
                              child: defaultTextButton(
                                  function: () {
                                    check();
                                    if (emailChecker == false &&
                                        passowrdChecker == false) if (LocalStorage
                                            .getData(key: "deviceToken") ==
                                        null) {
                                      try {
                                        DioHelper.postData(
                                                endpoint:
                                                    "/api/auth/driver/login",
                                                formData: {
                                                  "email": emailController.text
                                                      .toString(),
                                                  "password": passwordController
                                                      .text
                                                      .toString()
                                                },
                                                context: context)
                                            .then((respone) {
                                          if (respone is! String) {
                                            LocalStorage.saveData(
                                                key: "deviceToken",
                                                value: respone["token"]);
                                            print(LocalStorage.getData(
                                                key: "deviceToken"));
                                            FirebaseMessaging.instance
                                                .getToken()
                                                .then((value) {
                                              String? token = value;
                                              print("FireBaseToken    " +
                                                  token.toString());
                                              DioHelper.postData(
                                                  endpoint: "/api/user/fcm",
                                                  context: context,
                                                  formData: {"fcm": token});
                                            });
                                            navigateAndFinish(
                                                context, NavigationBar());
                                          } else
                                            Fluttertoast.showToast(
                                                msg: "Invaild email or password"
                                                    .tr());
                                        });
                                      } catch (e) {}
                                    } else {
                                      navigateAndFinish(
                                          context, NavigationBar());
                                    }
                                  },
                                  title: 'Go'.tr()),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffB09B87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.025.sh,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TermsScreen())),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Once you log in, you agree to the '.tr(),
                        style: TextStyle(
                            fontSize: 40.sp, color: Colors.brown.shade600),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms and Conditions'.tr(),
                            style: TextStyle(
                                color: Colors.brown.shade300,
                                fontSize: 40.sp,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
