import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:backyard_delivery/layout/layout_screen.dart';
import 'package:backyard_delivery/screens/login_screen/login_screen.dart';
import 'package:backyard_delivery/services/localstroage.dart';
import 'package:flutter/material.dart';
//import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  checkFirstSeen() {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LocalStorage.getData(key: "deviceToken")==null ?LoginScreen():NavigationBar()));
    });
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
@override
  void initState() {


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
