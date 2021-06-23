import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/splash_screen/splash_screen.dart';

// import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 2280),
      builder: () => MaterialApp(
        title: 'backyard',
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.brown, canvasColor: Colors.white),
        home: SplashScreen(),
      ),
    );
  }
}
