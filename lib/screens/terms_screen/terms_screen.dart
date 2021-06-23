import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffB09B87)));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffB09B87),
        appBar: customisedAppBar(context, true, true, 'Terms and Conditions'),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 0.03.sh, horizontal: 0.03.sw),
            child: Center(
              child: Text(
                'Terms and Conditions',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 60.sp, color: Color(0xffB09B87)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
