import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customisedAppBar(BuildContext context,
    [bool? isBackButton = true, bool? isLogoTitle, String? titleText]) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 0.10.sh,
    centerTitle: true,
    backgroundColor: Color(0xffB09B87),
    leading: isBackButton == true
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Color(0xff80392C),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : null,
    title: isLogoTitle == true
        ? Text(
            titleText!,
            style: TextStyle(
                fontSize: 72.sp,
                color: Color(0xff80392C),
                fontWeight: FontWeight.bold),
          )
        : Container(
            height: 100.h,
            width: 280.w,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fill,
            ),
          ),
    elevation: 0,
  );
}
